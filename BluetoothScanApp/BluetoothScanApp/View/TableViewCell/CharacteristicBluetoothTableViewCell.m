//
//  CharacteristicBluetoothTableViewCell.m
//  BluetoothScanApp
//
//  Created by Bo-Rong on 2018/2/12.
//  Copyright © 2018年 Bo-Rong. All rights reserved.
//

#import "CharacteristicBluetoothTableViewCell.h"

@implementation CharacteristicBluetoothTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if(self){
        
        [self initData];
        
        [self initUI];
        
    }
    
    return self;
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

#pragma mark - private init function

-(void)initData{
    
}

-(void)initUI{
    
    CGSize sizeGap = CGSizeMake(rWidth(10.0f), 5.0f);
    CGSize sizeLabelCharacteristicName = CGSizeMake(kWinSizeWidth - sizeGap.width, 30.0f);
    self.labelCharacteristicName = [[UILabel alloc] init];
    [self.labelCharacteristicName setFrame:CGRectMake(sizeGap.width, sizeGap.height, sizeLabelCharacteristicName.width, sizeLabelCharacteristicName.height)];
    [self addSubview:self.labelCharacteristicName];
    
    
    CGSize sizelabelCharacteristicProperty = CGSizeMake(kWinSizeWidth - sizeGap.width, 30.0f);
    self.labelCharacteristicProperty = [[UILabel alloc] init];
    [self.labelCharacteristicProperty setFrame:CGRectMake(sizeGap.width, self.labelCharacteristicName.frame.origin.y + self.labelCharacteristicName.frame.size.height + sizeGap.height, sizelabelCharacteristicProperty.width, sizelabelCharacteristicProperty.height)];
    [self.labelCharacteristicProperty setTextColor:[UIColor grayColor]];
    [self addSubview:self.labelCharacteristicProperty];
    
    
}

#pragma mark - public update function

-(void)updateUIWithCharacteristic:(CBCharacteristic *)cbCharacteristic{
    
    [self.labelCharacteristicName setText:[cbCharacteristic.UUID description]];
    
    NSString *stringProperties = @"屬性:";
    
    if(cbCharacteristic.properties & CBCharacteristicPropertyBroadcast){
        
        stringProperties = [stringProperties stringByAppendingString:@"廣播|"];
        
    }
    
    if (cbCharacteristic.properties & CBCharacteristicPropertyRead){
        
        stringProperties = [stringProperties stringByAppendingString:@"可讀|"];

    }
    
    if (cbCharacteristic.properties & CBCharacteristicPropertyWriteWithoutResponse){
        
        stringProperties = [stringProperties stringByAppendingString:@"可寫但無回應|"];

    }
    
    if (cbCharacteristic.properties & CBCharacteristicPropertyWrite){
        
        stringProperties = [stringProperties stringByAppendingString:@"可寫|"];
        
    }
    
    if (cbCharacteristic.properties & CBCharacteristicPropertyNotify){
        
        stringProperties = [stringProperties stringByAppendingString:@"通知|"];
        
    }
    
    if (cbCharacteristic.properties & CBCharacteristicPropertyIndicate){
        
        stringProperties = [stringProperties stringByAppendingString:@"允許顯示特徵值|"];
        
    }
    
    if (cbCharacteristic.properties & CBCharacteristicPropertyAuthenticatedSignedWrites){
        
        stringProperties = [stringProperties stringByAppendingString:@"允許寫入認證簽名|"];
        
    }
    
    if (cbCharacteristic.properties & CBCharacteristicPropertyExtendedProperties){
        
        stringProperties = [stringProperties stringByAppendingString:@"拓展|"];
        
    }
    
    if (cbCharacteristic.properties & CBCharacteristicPropertyNotifyEncryptionRequired){
        
        stringProperties = [stringProperties stringByAppendingString:@"通知需加密|"];
        
    }
    
    if (cbCharacteristic.properties & CBCharacteristicPropertyIndicateEncryptionRequired){
        
        stringProperties = [stringProperties stringByAppendingString:@"顯示特徵值需加密|"];
        
    }
    
    stringProperties = [stringProperties substringToIndex:stringProperties.length - 1];
    
    [self.labelCharacteristicProperty setText:stringProperties];
    
    
}


@end
