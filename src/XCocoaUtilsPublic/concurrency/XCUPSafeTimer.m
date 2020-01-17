//
//  XCUPSafeTimer.m
//  XCocoaUtilsPublic
//
//  Created by Deheng Xu on 2020/1/16.
//  Copyright © 2020 Deheng.Xu. All rights reserved.
//

#import "XCUPSafeTimer.h"

@interface XCUPSafeTimer ()

@property (nonatomic, strong, nullable) NSTimer *timer;
@property (nonatomic, assign) BOOL isReapt;
@property (nonatomic, assign) NSTimeInterval interval;
@property (nonatomic, assign) NSTimeInterval duration;
@property (nonatomic, strong) NSDate *startTime;

@end

@implementation XCUPSafeTimer

+ (instancetype)timerWithInterval:(NSTimeInterval)interval block:(void(^)(NSTimer *))timerBlock
{
    XCUPSafeTimer *timer = [XCUPSafeTimer new];
    timer.timerBlock = timerBlock;
    timer.interval = interval;
    return timer;
}

+ (instancetype)repeatTimerWithInterval:(NSTimeInterval)interval block:(void (^)(NSTimer * _Nonnull))timerBlock
{
    XCUPSafeTimer *timer = [self timerWithInterval:interval block:timerBlock];
    timer.isReapt = YES;
    return timer;
}

+ (instancetype)repeatTimerWithInterval:(NSTimeInterval)interval duration:(NSTimeInterval)duration block:(void(^)(NSTimer *))timerBlock
{
    XCUPSafeTimer *timer = [self repeatTimerWithInterval:interval block:timerBlock];
    timer.interval = interval;
    timer.duration = duration;
    return timer;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.isReapt = NO;
    }
    return self;
}

- (void)startTimer
{
    if (self.timer && self.timer.isValid) {
        [self cancelTimer];
    }
    self.timer = [NSTimer timerWithTimeInterval:self.interval target:self selector:@selector(handleTimer:) userInfo:nil repeats:self.isReapt];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    self.startTime = [NSDate new];
}

- (void)cancelTimer
{
    if (!self.timer || !self.timer.isValid) {
        return;
    }
    [self.timer invalidate];
    self.timer = nil;
    self.startTime = nil;
}

- (void)handleTimer:(NSTimer *)timer
{
    self.timerBlock(timer);
    if ([NSDate.new timeIntervalSinceDate:self.startTime] > self.duration) {
        [self cancelTimer];
    }
}

- (void)dealloc
{
    [self cancelTimer];
    NSLog(@"%s", __func__);
}

@end
