//
//  CommonNavigationView.m
//  BluetoothScanApp
//
//  Created by Bo-Rong on 2018/2/12.
//  Copyright © 2018年 Bo-Rong. All rights reserved.
//

#import "CommonNavigationView.h"

@implementation CommonNavigationView

-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if(self){
        
        [self initData];
        
        [self initUI];
        
    }
    
    return self;
    
}

-(void)drawRect:(CGRect)rect{
    
    [super drawRect:rect];
    
}

#pragma mark - private init function

-(void)initData{
    
}

-(void)initUI{
    
    [self setBackgroundColor:[UIColor grayColor]];
    
    CGSize sizeLabelTitle = CGSizeMake(rWidth(200.0f), 30.0f);
    self.navigationBarCenterTitle = [[UILabel alloc] init];
    [self.navigationBarCenterTitle setFrame:CGRectMake((kWinSizeWidth - sizeLabelTitle.width) / 2.0f, 20.0f + (44.0f - sizeLabelTitle.height) / 2.0f, sizeLabelTitle.width, sizeLabelTitle.height)];
    [self.navigationBarCenterTitle setTextAlignment:NSTextAlignmentCenter];
    [self.navigationBarCenterTitle setBackgroundColor:[UIColor clearColor]];
    [self.navigationBarCenterTitle setFont:[UIFont systemFontOfSize:24.0f]];
    [self addSubview:self.navigationBarCenterTitle];
    
}

#pragma mark - public update function

-(void)updateUIWithTitle:(NSString *)title{
    
    self.navigationBarCenterTitle.text = title;
    
}



@end
