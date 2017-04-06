//
//  LXDTimer.m
//  LXDPersonalBlog
//
//  Created by 林欣达 on 16/5/4.
//  Copyright © 2016年 SindriLin. All rights reserved.
//

#import "LXDTimer.h"
#import "LXDQueue.h"

@interface LXDTimer ()

@property (nonatomic, copy) dispatch_block_t block;
@property (nonatomic, assign) NSTimeInterval interval;
@property (nonatomic, strong) dispatch_queue_t executeQueue;
@property (nonatomic, strong) dispatch_source_t executeSource;

@end


@implementation LXDTimer


#pragma mark - 构造器
- (instancetype)init
{
    if (self = [super init]) {
        self.executeQueue = [LXDQueue defaultPriorityQueue].executeQueue;
        self.executeSource = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, LXDQueue.defaultPriorityQueue.executeQueue);
    }
    return self;
}

- (instancetype)initWithExecuteQueue: (LXDQueue *)queue
{
    if (self = [super init]) {
        self.executeQueue = queue.executeQueue;
        self.executeSource = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue.executeQueue);
    }
    return self;
}

- (void)dealloc
{
    [self destory];
}


#pragma mark - 操作
- (void)execute: (dispatch_block_t)block interval: (NSTimeInterval)interval
{
    [self execute: block interval: interval delay: 0];
}

- (void)execute: (dispatch_block_t)block interval: (NSTimeInterval)interval delay: (NSTimeInterval)delay
{
    NSParameterAssert(block);
    self.block = block;
    self.interval = interval;
    dispatch_source_set_timer(self.executeSource, dispatch_time(DISPATCH_TIME_NOW, delay * NSEC_PER_SEC), interval * NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(self.executeSource, block);
}

- (void)start
{
    if (!_executeSource) {
        self.executeSource = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, _executeQueue);
        [self execute: _block interval: _interval];
    }
    dispatch_resume(self.executeSource);
}

- (void)destory
{
    if (_executeSource) {
        dispatch_source_cancel(self.executeSource);
        self.executeSource = nil;
    }
}


@end
