//
//  CommonNavigationView.h
//  BluetoothScanApp
//
//  Created by Bo-Rong on 2018/2/12.
//  Copyright © 2018年 Bo-Rong. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <MHToolKit_Framwork/MHToolKit_Framwork.h>

@interface CommonNavigationView : UIView

//中心標題
@property (nonatomic, strong) UILabel *navigationBarCenterTitle;


#pragma mark - public update function

-(void)updateUIWithTitle:(NSString *)title;

@end
