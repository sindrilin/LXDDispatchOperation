//
//  ViewController.m
//  LXDDispatchOperation
//
//  Created by linxinda on 2017/4/6.
//  Copyright © 2017年 Jolimark. All rights reserved.
//

#import "ViewController.h"
#import "LXDGCD.h"
#import "LXDDispatchAsync.h"
#import "LXDDispatchOperation.h"


@interface ViewController ()

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    /// LXDGCD
    [LXDQueue executeInMainQueue: ^{
        NSLog(@"This is main queue");
    }];
    [LXDQueue executeInGlobalQueue: ^{
        NSLog(@"The code will be executed in global queue after 1 second");
    } delay: 1];
    
    /// LXDDispatch
    for (int idx = 0; idx < 10000; idx++) {
        NSQualityOfService qos = NSQualityOfServiceDefault;
        switch (arc4random() % 5) {
            case 0:
                qos = NSQualityOfServiceUserInteractive;
                break;
            case 1:
                qos = NSQualityOfServiceUserInitiated;
                break;
            case 2:
                qos = NSQualityOfServiceDefault;
                break;
            case 3:
                qos = NSQualityOfServiceUtility;
                break;
            case 4:
                qos = NSQualityOfServiceBackground;
                break;
        }
        [[LXDDispatchOperation dispatchOperationWithBlock: ^{
            NSLog(@"async block in %@", [self descriptionForQos: qos]);
        } inQoS: qos] start];
    }
}

- (NSString *)descriptionForQos: (NSQualityOfService)qos {
    switch (qos) {
        case NSQualityOfServiceUserInteractive:
            return @"user interactive";
        case NSQualityOfServiceUserInitiated:
            return @"User Initiated";
        case NSQualityOfServiceDefault:
            return @"Default";
        case NSQualityOfServiceUtility:
            return @"Utility";
        case NSQualityOfServiceBackground:
            return @"Background";
    }
}


@end
