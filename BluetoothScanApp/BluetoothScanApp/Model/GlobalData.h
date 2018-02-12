//
//  GlobalData.h
//  BluetoothScanApp
//
//  Created by Bo-Rong on 2018/2/12.
//  Copyright © 2018年 Bo-Rong. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BluetoothDevice.h"

@interface GlobalData : NSObject

/**
 * @biref 目前的藍芽設備
 */
@property (nonatomic, strong) BluetoothDevice *bluetoothDevice;

/**
 * @brief 目前起動的服務
 */
@property (nonatomic, strong) CBService *cbService;

/**
 * @brief 目前讀取的特徵值
 */
@property (nonatomic, strong) CBCharacteristic *cbCharacteristic;

#pragma mark - public function

+(GlobalData *)sharedInstance;


#define kBluetoothDevice                    [GlobalData sharedInstance].bluetoothDevice

#define kBluetoothService                   [GlobalData sharedInstance].cbService

#define kBluetoothCharacteristic            [GlobalData sharedInstance].cbCharacteristic

@end
