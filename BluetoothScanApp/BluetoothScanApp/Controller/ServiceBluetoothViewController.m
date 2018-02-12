//
//  ServiceBluetoothViewController.m
//  BluetoothScanApp
//
//  Created by Bo-Rong on 2018/2/12.
//  Copyright © 2018年 Bo-Rong. All rights reserved.
//

#import "ServiceBluetoothViewController.h"

#import "CommonNavigationView.h"

#import "CharacteristicBluetoothViewController.h"

@interface ServiceBluetoothViewController ()

@end

@implementation ServiceBluetoothViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [kBluetoothDeviceManager discoverServicesWithPeripheral:kBluetoothDevice.peripheral];
    
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
    
    //NavigationBar
    CGSize sizeNavigationBar = CGSizeMake(kWinSizeWidth, UINavigationBarHeight);
    CommonNavigationView *navbar = [[CommonNavigationView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, sizeNavigationBar.width, sizeNavigationBar.height)];
    [navbar updateUIWithTitle:@"服務"];
    [self.view addSubview:navbar];
    
    //返回紐
    [self addBackButtonWithTitle:nil];
    
    //標題
    CGSize sizeLabelTitle = CGSizeMake(rWidth(300), rHeight(60));
    UILabel *labelTitle = [[UILabel alloc] init];
    [labelTitle setFrame:CGRectMake((kWinSizeWidth - sizeLabelTitle.width) / 2.0f, UIStatusBarHeight + UINavigationBarHeight + rHeight(10), sizeLabelTitle.width, sizeLabelTitle.height)];
    
    if(kBluetoothDevice.peripheral.name){
        [labelTitle setText:kBluetoothDevice.peripheral.name];
    }else{
        [labelTitle setText:@"未知設備"];
    }
    
    [labelTitle setFont:[UIFont systemFontOfSize:24]];
    [labelTitle setTextAlignment:NSTextAlignmentCenter];
    [self.view addSubview:labelTitle];
    
    //測試 Button
    CGSize sizeBtn = CGSizeMake(rWidth(200), rHeight(36));
    UIButton *btn = [[UIButton alloc] init];
    [btn setFrame:CGRectMake((kWinSizeWidth - sizeBtn.width) / 2.0f, labelTitle.frame.origin.y + labelTitle.frame.size.height + rHeight(20), sizeBtn.width, sizeBtn.height)];
    [btn setBackgroundImage:[MHImageUtil imageFromColor:[UIColor grayColor] forSize:sizeBtn withCornerRadius:rWidth(10)] forState:UIControlStateNormal];
    [btn setTitle:@"掃描服務" forState:UIControlStateNormal];
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
    
    [m_tableView reloadData];
    
    [kBluetoothDeviceManager discoverServicesWithPeripheral:kBluetoothDevice.peripheral];
    
    
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
        [cell.textLabel setNumberOfLines:0];
    }
    
    CBService *cbService = [m_arrayTableViewData objectAtIndex: indexPath.row];
    
    if(cbService.UUID){
        
        cell.imageView.image = [UIImage imageNamed:@"ConnectIcon"];
        
        [cell.textLabel setText:[cbService.UUID description]];
        
        [cell.detailTextLabel setText:@">>"];
    }
    
    return cell;
    
}

#pragma mark - UITableViewDelegate


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 60.0f;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if([self checkIndexVaildByIndex:indexPath.row withArray:m_arrayTableViewData]){
        
        CBService *cbService = [m_arrayTableViewData objectAtIndex: indexPath.row];
        
        if(kBluetoothService){
            kBluetoothService = nil;
        }
        kBluetoothService = cbService;
        
        CharacteristicBluetoothViewController *targetVc = [[CharacteristicBluetoothViewController alloc] init];
        [self.navigationController pushViewController:targetVc animated:YES];
        
    }
    
}

#pragma mark - BluetoothDeviceManagerDelegate

-(void)getBluetoothDidUpdateState:(NSString *)string{
    
    [super getBluetoothDidUpdateState:string];
    
}

-(void)getDiscoverPeripheral:(NSMutableArray *)arrayBluetoothDevice{
    
    [super getDiscoverPeripheral:arrayBluetoothDevice];
    
}

-(void)getConnectToPeripheralSuccess:(CBPeripheral *)peripherals{
    
    [super getConnectToPeripheralSuccess:peripherals];
    
}

-(void)getFailToConnectPeripheral:(CBPeripheral *)peripheralctPeripheral{
    
    [super getFailToConnectPeripheral:peripheralctPeripheral];
    
}

-(void)getDisconnectToPeripheralFinish:(CBPeripheral *)peripheral{
    
    [super getDisconnectToPeripheralFinish:peripheral];
    
}

-(void)getDiscoverServices:(NSMutableArray *)arrayCBService withPeripheral:(CBPeripheral *)peripheral{
    
    [super getDiscoverServices:arrayCBService withPeripheral:peripheral];
    
    m_arrayTableViewData = arrayCBService;
    [m_tableView reloadData];
    
}

-(void)getDiscoverCharacteristics:(NSMutableArray *)arrayCharacteristic withCBService:(CBService *)service withPeripheral:(CBPeripheral *)peripheral{
    
    [super getDiscoverCharacteristics:arrayCharacteristic withCBService:service withPeripheral:peripheral];
    
}

-(void)getUpdateValueForCharacteristic:(NSData *)data{
    
    [super getUpdateValueForCharacteristic:data];
    
}


@end
