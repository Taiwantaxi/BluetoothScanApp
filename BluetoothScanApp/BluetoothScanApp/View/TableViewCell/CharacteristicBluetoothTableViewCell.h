//
//  CharacteristicBluetoothTableViewCell.h
//  BluetoothScanApp
//
//  Created by Bo-Rong on 2018/2/12.
//  Copyright © 2018年 Bo-Rong. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <MHToolKit_Framwork/MHToolKit_Framwork.h>

#import "GlobalData.h"

@interface CharacteristicBluetoothTableViewCell : UITableViewCell

/**
 * @brief 特徵值名稱
 */
@property (nonatomic, strong) UILabel *labelCharacteristicName;

/**
 * @brief 特徵值屬性
 */
@property (nonatomic, strong) UILabel *labelCharacteristicProperty;

#pragma mark - public update function

-(void)updateUIWithCharacteristic:(CBCharacteristic *) cbCharacteristic;

@end
