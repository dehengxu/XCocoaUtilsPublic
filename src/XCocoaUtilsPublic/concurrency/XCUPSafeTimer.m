//
//  XCUPSafeTimer.m
//  XCocoaUtilsPublic
//
//  Created by Deheng Xu on 2020/1/16.
//  Copyright © 2020 Deheng.Xu. All rights reserved.
//

#import "XCUPSafeTimer.h"

static NSMutableDictionary<NSString*, XCUPSafeTimer *> *__nx_timers__;
static NSRecursiveLock *__nx_lock__;

static void pushTimer(XCUPSafeTimer *timer) {
    if (!timer.name) return;
    [__nx_timers__ setObject:timer forKey:timer.name];
}

static void popTimer(XCUPSafeTimer *timer) {
    if (!timer.name) return;
    [__nx_timers__ removeObjectForKey:timer.name];
}

static XCUPSafeTimer *popTimerNamed(NSString *name) {
    if (!name) return nil;
    id tim = __nx_timers__[name];
    popTimer(tim);
    return tim;
}


@interface XCUPSafeTimer ()

@property (nonatomic, copy) void(^timerBlock)(NSTimer *, BOOL reachEnd);
@property (nonatomic, strong, nullable) NSTimer *timer;
@property (nonatomic, assign) BOOL isReapt;
@property (nonatomic, assign) NSTimeInterval interval;
@property (nonatomic, assign) NSTimeInterval duration;
@property (copy) NSString *name;
@property (atomic) NSUInteger counter;
@property (atomic, strong) NSRecursiveLock *timerLock;

@end

@implementation XCUPSafeTimer

//+ (void)initialize
//{
//    [super initialize];
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        if (!__nx_timers__) {
//            __nx_timers__ = [[NSMutableDictionary alloc] initWithCapacity:16];
//        }
//        if (!__nx_lock__) {
//            __nx_lock__ = [NSRecursiveLock new];
//        }
//    });
//}

+ (instancetype)timerWithInterval:(NSTimeInterval)interval block:(void(^)(NSTimer *, BOOL))timerBlock
{
    XCUPSafeTimer *timer = [XCUPSafeTimer new];
    timer.timerBlock = timerBlock;
    timer.interval = interval;
    
    pushTimer(timer);
    
    [timer start];
    
    return timer;
}

+ (instancetype)repeatTimerWithInterval:(NSTimeInterval)interval block:(void (^)(NSTimer * _Nonnull, BOOL))timerBlock
{
    XCUPSafeTimer *timer = [self timerWithInterval:interval block:timerBlock];
    timer.isReapt = YES;
    
    pushTimer(timer);
    [timer start];
    return timer;
}

+ (instancetype)repeatTimerWithInterval:(NSTimeInterval)interval duration:(NSTimeInterval)duration block:(void(^)(NSTimer *, BOOL reachEnd))timerBlock
{
    XCUPSafeTimer *timer = [self repeatTimerWithInterval:interval block:timerBlock];
    NSString *uuidStr = [[NSUUID UUID] UUIDString];
    timer.name = uuidStr;
    timer.interval = interval;
    timer.duration = duration;
    
    pushTimer(timer);

    [timer start];
    return timer;
}

+ (void)cancel:(NSString *)name
{
    [__nx_lock__ lock];
    
    XCUPSafeTimer *tim = popTimerNamed(name);
    [tim cancel];
    
    [__nx_lock__ unlock];
}

+ (void)cancelAll
{
    [__nx_lock__ lock];
    
    NSArray *keys = [__nx_timers__ allKeys];
    for(NSString *key in keys) {
        [self cancel:key];
    }
#if DEBUG
    NSLog(@"keys: %@", __nx_timers__.allKeys);
#endif
    [__nx_lock__ unlock];
}


- (instancetype)init
{
    self = [super init];
    if (self) {
        self.isReapt = NO;
        self.timerLock = [NSRecursiveLock new];
    }
    return self;
}

- (void)start
{
    [self.timerLock lock];
    
    if (self.timer && self.timer.isValid) {
        //[self cancelTimer];
        [self.timer invalidate];
        self.timer = nil;
    }
    self.timer = [NSTimer timerWithTimeInterval:self.interval target:self selector:@selector(handleTimer:) userInfo:nil repeats:self.isReapt];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    
    [self.timerLock unlock];
}

- (void)cancel
{
    [self.timerLock lock];
    
    if (!self.timer || !self.timer.isValid) {
        return;
    }
    [self.timer invalidate];
    self.timer = nil;
    popTimer(self);
    
    [self.timerLock unlock];
}

- (void)handleTimer:(NSTimer *)timer
{
    BOOL reachEnd = false;
    if (self.duration > 0 && (++self.counter * self.interval) >= self.duration) {
        reachEnd = true;
    }
    self.timerBlock(timer, reachEnd);
    if (reachEnd) {
        [self cancel];
    }
}

- (void)dealloc
{
    [self cancel];
    NSLog(@"%s", __func__);
}

@end
