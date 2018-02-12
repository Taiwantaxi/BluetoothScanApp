//
//  GlobalData.m
//  BluetoothScanApp
//
//  Created by Bo-Rong on 2018/2/12.
//  Copyright © 2018年 Bo-Rong. All rights reserved.
//

#import "GlobalData.h"

static GlobalData *instance = nil;
@implementation GlobalData

-(instancetype)init{
    
    self = [super init];
    
    if(self){
        
        [self initData];
        
    }
    
    return self;
}

#pragma mark - private init function

-(void)initData{
    
}

#pragma mark - public function

+(GlobalData *)sharedInstance{
    
    @synchronized ([GlobalData class]) {
        if(!instance){
            
            instance = [[self alloc] init];
            
        }
        return instance;
    }
    
    return nil;
    
}


@end
