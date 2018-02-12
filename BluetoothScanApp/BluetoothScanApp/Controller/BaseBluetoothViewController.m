//
//  BaseBluetoothViewController.m
//  BluetoothScanApp
//
//  Created by Bo-Rong on 2018/2/12.
//  Copyright © 2018年 Bo-Rong. All rights reserved.
//

#import "BaseBluetoothViewController.h"

@interface BaseBluetoothViewController ()

@end

@implementation BaseBluetoothViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
}

-(void)loadView{
    
    [super loadView];
    
    [self initData];
    
    [self initUI];
}


-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [kBluetoothDeviceManager setDelegate:self];
    
}

-(void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
    [kBluetoothDeviceManager setDelegate:nil];
    
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    
}

#pragma mark - public Inherit data function

-(void)initData{
    
}

#pragma mark - public Inherit ui function

-(void)initUI{
    
}

#pragma mark - public Inherit Navigation function

-(void)addBackButtonWithTitle:(NSString *)title{
    
    [self addLeftButtonWithTitle:title withImageName:@"common_back"];
    
}

#pragma mark - public Inherit action function

- (void)actionBtnNavigationLeftTouch
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - public data function

-(BOOL)checkIndexVaildByIndex:(NSInteger)index withArray:(NSArray *)array{
    
    BOOL result = (index < array.count) ? YES : NO;
    
    return result;
    
}

#pragma mark - private Naviation function

-(void)addLeftButtonWithTitle:(NSString *)title withImageName:(NSString *)imageName{
    
    CGSize sizeBtn = CGSizeMake(25.0f, 25.0f);
    UIButton *btnLeft = [[UIButton alloc] initWithFrame:CGRectMake(rWidth(11.5f), 28.0f, sizeBtn.width, sizeBtn.height)];
    [btnLeft setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [btnLeft addTarget:self action:@selector(actionBtnNavigationLeftTouch) forControlEvents:UIControlEventTouchUpInside];
    [btnLeft setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnLeft setTitle:title forState:UIControlStateNormal];
    [btnLeft.titleLabel setFont:[UIFont systemFontOfSize:16.0f]];
    [btnLeft setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [btnLeft setTag:BaseBluetoothViewControllerTag_BtnTopLeft];
    [self.view addSubview:btnLeft];
    
}

#pragma mark - BluetoothDeviceManagerDelegate

-(void)getBluetoothDidUpdateState:(NSString *)string{
    
    NSLog(@"%s",__FUNCTION__);
    
}

-(void)getDiscoverPeripheral:(NSMutableArray *)arrayBluetoothDevice{
    
    NSLog(@"%s",__FUNCTION__);

}

-(void)getConnectToPeripheralSuccess:(CBPeripheral *)peripherals{
    
    NSLog(@"%s",__FUNCTION__);
    
}

-(void)getFailToConnectPeripheral:(CBPeripheral *)peripheralctPeripheral{
    
    NSLog(@"%s",__FUNCTION__);
}

-(void)getDisconnectToPeripheralFinish:(CBPeripheral *)peripheral{
    
    NSLog(@"%s",__FUNCTION__);
    
}

-(void)getDiscoverServices:(NSMutableArray *)arrayCBService withPeripheral:(CBPeripheral *)peripheral{
    
    NSLog(@"%s",__FUNCTION__);

}

-(void)getDiscoverCharacteristics:(NSMutableArray *)arrayCharacteristic withCBService:(CBService *)service withPeripheral:(CBPeripheral *)peripheral{
    
    NSLog(@"%s",__FUNCTION__);
    
}

-(void)getUpdateValueForCharacteristic:(NSData *)data{
    
    NSLog(@"%s",__FUNCTION__);
    
}

@end
