//
//  ServiceBluetoothViewController.h
//  BluetoothScanApp
//
//  Created by Bo-Rong on 2018/2/12.
//  Copyright © 2018年 Bo-Rong. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BaseBluetoothViewController.h"

@interface ServiceBluetoothViewController : BaseBluetoothViewController <UITableViewDelegate, UITableViewDataSource>

{
    NSMutableArray *m_arrayTableViewData;
    
    UITableView *m_tableView;
    
}


@end
