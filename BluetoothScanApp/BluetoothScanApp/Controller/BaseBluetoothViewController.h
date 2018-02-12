//
//  BaseBluetoothViewController.h
//  BluetoothScanApp
//
//  Created by Bo-Rong on 2018/2/12.
//  Copyright © 2018年 Bo-Rong. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <MHToolKit_Framwork/MHToolKit_Framwork.h>

#import "UIView+Toast.h"

#import "BluetoothDeviceManager.h"

#import "GlobalData.h"

#define UIStatusBarHeight           20.0f
#define UINavigationBarHeight       64.0f

typedef NS_ENUM(NSInteger, BaseBluetoothViewControllerTag) {
    
    BaseBluetoothViewControllerTag_BtnTopLeft = 1000,
    
};

@interface BaseBluetoothViewController : UIViewController <BluetoothDeviceManagerDelegate>

#pragma mark - public Inherit function

-(void)initData;

#pragma mark - public Inherit ui function

-(void)initUI;

#pragma mark - Inherit Naigation function

- (void)addBackButtonWithTitle:(NSString *)title;

#pragma mark - public Inherit action function

- (void)actionBtnNavigationLeftTouch;

#pragma mark - public data function

-(BOOL)checkIndexVaildByIndex:(NSInteger)index withArray:(NSArray *)array;

@end
