//
//  DiscoverBluetoothViewController.m
//  BluetoothScanApp
//
//  Created by Bo-Rong on 2018/2/12.
//  Copyright © 2018年 Bo-Rong. All rights reserved.
//

#import "DiscoverBluetoothViewController.h"

#import "ServiceBluetoothViewController.h"

@interface DiscoverBluetoothViewController ()

@end

@implementation DiscoverBluetoothViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    if(kBluetoothDevice){
        //取消所有藍芽連線設備
        [kBluetoothDeviceManager disconnectBluetoothDevice:kBluetoothDevice];
        kBluetoothDevice = nil;
    }
    
}

-(void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    
}

#pragma mark - public Inherit data function

-(void)initData{
    
}

#pragma mark - public Inherit ui function

-(void)initUI{
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    //標題
    CGSize sizeLabelTitle = CGSizeMake(rWidth(300), rHeight(60));
    UILabel *labelTitle = [[UILabel alloc] init];
    [labelTitle setFrame:CGRectMake((kWinSizeWidth - sizeLabelTitle.width) / 2.0f, UIStatusBarHeight + UINavigationBarHeight + rHeight(10), sizeLabelTitle.width, sizeLabelTitle.height)];
    [labelTitle setText:@"藍芽設備"];
    [labelTitle setFont:[UIFont systemFontOfSize:24]];
    [labelTitle setTextAlignment:NSTextAlignmentCenter];
    [self.view addSubview:labelTitle];
    
    //Scan Button
    CGSize sizeBtn = CGSizeMake(rWidth(200), rHeight(36));
    UIButton *btn = [[UIButton alloc] init];
    [btn setFrame:CGRectMake((kWinSizeWidth - sizeBtn.width) / 2.0f, labelTitle.frame.origin.y + labelTitle.frame.size.height + rHeight(20), sizeBtn.width, sizeBtn.height)];
    [btn setBackgroundImage:[MHImageUtil imageFromColor:[UIColor grayColor] forSize:sizeBtn withCornerRadius:rWidth(10)] forState:UIControlStateNormal];
    [btn setTitle:@"掃描" forState:UIControlStateNormal];
    [btn setTintColor:[UIColor whiteColor]];
    [btn.titleLabel setFont:[UIFont systemFontOfSize:rWidth(16)]];
    [btn addTarget:self action:@selector(actionBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    //TableView
    CGSize sizeTableView = CGSizeMake(kWinSizeWidth, kWinSizeHeight - btn.frame.origin.y - btn.frame.size.height - rHeight(100));
    m_tableView = [[UITableView alloc] init];
    [m_tableView setFrame:CGRectMake(0, btn.frame.origin.y + btn.frame.size.height + rHeight(50), sizeTableView.width, sizeTableView.height)];
    [m_tableView setDelegate:self];
    [m_tableView setDataSource:self];
    [m_tableView setBackgroundColor:[UIColor whiteColor]];
    [m_tableView setKeyboardDismissMode:UIScrollViewKeyboardDismissModeOnDrag];
    [self.view addSubview:m_tableView];
    
}

#pragma mark - private action function

-(void)actionBtn:(id)sender{
    
    [self.view makeToast:@"掃描"];
    
    [kBluetoothDeviceManager scanBluetoothDevice];
    
}

#pragma mark - UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [m_arrayTableViewData count];
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *identifier = @"Mycell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if(!cell){
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
        [cell setSelectionStyle:UITableViewCellSelectionStyleDefault];
        
    }
    
    BluetoothDevice *device = [m_arrayTableViewData objectAtIndex: indexPath.row];
    
    //設備名稱
    if(device.peripheral.name){
        [cell.textLabel setText:device.peripheral.name];
    }else{
        [cell.textLabel setText:@"未知設備"];
    }
    
    //設備訊號強度
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%zd dBm", device.signalStrength];
    
    //設備連線狀態
    if(device.peripheral.state == CBPeripheralStateConnected){
        cell.imageView.image = [UIImage imageNamed:@"ConnectIcon"];
    }else {
        cell.imageView.image = [UIImage imageNamed:@"DisconnectIcon"];
    }
    
    return cell;
    
}


#pragma mark - UITableViewDelegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if([self checkIndexVaildByIndex:indexPath.row withArray:m_arrayTableViewData]){
        
        BluetoothDevice *device = [[BluetoothDevice alloc] init];
        device = [m_arrayTableViewData objectAtIndex: indexPath.row];
        
        if(device.peripheral.state == CBPeripheralStateDisconnected){
            
            //連線藍牙設備
            [kBluetoothDeviceManager connectBluetoothDevice:device];
            
            if(kBluetoothDevice){
                kBluetoothDevice = nil;
            }
            kBluetoothDevice = device;
            
        }else if (device.peripheral.state == CBPeripheralStateConnected){
            
            //取消藍芽設備連線
            [kBluetoothDeviceManager disconnectBluetoothDevice:device];
            
            if(kBluetoothDevice){
                kBluetoothDevice = nil;
            }
            
        }
        
    }
    
}

#pragma mark - BluetoothDeviceManagerDelegate

-(void)getBluetoothDidUpdateState:(NSString *)string{
    
    [super getBluetoothDidUpdateState:string];
    
    [self.view makeToast:string];
    
}

-(void)getDiscoverPeripheral:(NSMutableArray *)arrayBluetoothDevice{
    
    [super getDiscoverPeripheral:arrayBluetoothDevice];
    
    m_arrayTableViewData = arrayBluetoothDevice;
    [m_tableView reloadData];
    
}

-(void)getConnectToPeripheralSuccess:(CBPeripheral *)peripherals{
    
    [super getConnectToPeripheralSuccess:peripherals];
    
    [self.view makeToast:@"Connect To Peripheral Success"];
    [m_tableView reloadData];
    
    //[kBluetoothDeviceManager discoverServicesWithPeripheral:peripherals];
    
    ServiceBluetoothViewController *targetVc = [[ServiceBluetoothViewController alloc] init];
    [self.navigationController pushViewController:targetVc animated:YES];
    
}

-(void)getFailToConnectPeripheral:(CBPeripheral *)peripheralctPeripheral{
    
    [super getFailToConnectPeripheral:peripheralctPeripheral];
    
    [self.view makeToast:@"Fail To Connect Peripheral"];
    [m_tableView reloadData];
    
}

-(void)getDisconnectToPeripheralFinish:(CBPeripheral *)peripheral{
    
    [super getDisconnectToPeripheralFinish:peripheral];
    
    [self.view makeToast:@"Disconnect To Peripheral Finish"];
    [m_tableView reloadData];
    
}

-(void)getDiscoverServices:(NSMutableArray *)arrayCBService withPeripheral:(CBPeripheral *)peripheral{
    
    [super getDiscoverServices:arrayCBService withPeripheral:peripheral];
    
    for(CBService *service in arrayCBService){
        
        [self.view makeToast:[service.UUID description]];
            
        [kBluetoothDeviceManager startServiceDiscoverCharacteristic:service withPeripheral:peripheral];
        
    }
    
}

-(void)getDiscoverCharacteristics:(NSMutableArray *)arrayCharacteristic withCBService:(CBService *)service withPeripheral:(CBPeripheral *)peripheral{
    
    [super getDiscoverCharacteristics:arrayCharacteristic withCBService:service withPeripheral:peripheral];
    
    for (CBCharacteristic *c in arrayCharacteristic){
        
        [self.view makeToast:[c description]];
        [kBluetoothDeviceManager readCharacteristic:c withService:service withPeripheral:peripheral];
        
    }
    
}

-(void)getUpdateValueForCharacteristic:(NSData *)data{
    
    [super getUpdateValueForCharacteristic:data];
    
    NSString *result = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    [self.view makeToast:result];
    
}


@end
