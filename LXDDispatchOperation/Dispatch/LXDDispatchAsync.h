//
//  LXDDispatchQueuePool.h
//  LXDAppMonitor
//
//  Created by linxinda on 2017/4/2.
//  Copyright © 2017年 Jolimark. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef NS_ENUM(NSInteger, LXDQualityOfService) {
    LXDQualityOfServiceUserInteractive = NSQualityOfServiceUserInteractive,
    LXDQualityOfServiceUserInitiated = NSQualityOfServiceUserInitiated,
    LXDQualityOfServiceUtility = NSQualityOfServiceUtility,
    LXDQualityOfServiceBackground = NSQualityOfServiceBackground,
    LXDQualityOfServiceDefault = NSQualityOfServiceDefault,
};


void LXDDispatchQueueAsyncBlockInQOS(LXDQualityOfService qos, dispatch_block_t block);
void LXDDispatchQueueAsyncBlockInUserInteractive(dispatch_block_t block);
void LXDDispatchQueueAsyncBlockInUserInitiated(dispatch_block_t block);
void LXDDispatchQueueAsyncBlockInBackground(dispatch_block_t block);
void LXDDispatchQueueAsyncBlockInDefault(dispatch_block_t block);
void LXDDispatchQueueAsyncBlockInUtility(dispatch_block_t block);
