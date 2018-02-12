//
//  BluetoothDevice.m
//  BluetoothDemo
//
//  Created by Bo-Rong on 2017/9/21.
//  Copyright © 2017年 Bo-Rong. All rights reserved.
//

#import "BluetoothDevice.h"

@implementation BluetoothDevice

-(instancetype)init{
    
    self = [super init];
    
    if(self){
        
        [self initData];
        
    }
    
    return self;
    
}

-(void) initData {
    
    
}

-(void)updata:(CBPeripheral *)peripheral withAdvertisementData:(NSDictionary *)advertisementData withSingalStrength:(NSNumber *)RSSI{
    
    if(peripheral){
        self.peripheral = peripheral;
    }
    
    if(advertisementData){
        self.dicAdvertisementData = advertisementData;
    }
    
    if(RSSI){
        self.signalStrength = [RSSI integerValue];
    }
    
}

@end
