//
//  NXGCDTimer.m
//  GCDCases
//
//  Created by NicholasXu on 2020/2/12.
//  Copyright © 2020 DehengXu. All rights reserved.
//

#import "NXGCDTimer.h"

dispatch_source_t create_dispatch_timer(dispatch_queue_t queue) {
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    return timer;
}

static NSMutableDictionary<NSString*, NXGCDTimer *> * __nx_timers__;
static NSRecursiveLock *__nx_lock__;

@interface NXGCDTimer ()
@property (nonatomic, strong) dispatch_source_t timer;
@property (atomic, strong) NSRecursiveLock *timerLock;
@property NSUInteger counter;
@property (copy) NSString *name;

@end

static void pushTimer(NXGCDTimer *timer) {
    [__nx_timers__ setObject:timer forKey:timer.name];
}

static void popTimer(NXGCDTimer *timer) {
    if (!timer || !timer.name) return;
    [__nx_timers__ removeObjectForKey:timer.name];
}

static NXGCDTimer *popTimerNamed(NSString *name) {
    id tim = __nx_timers__[name];
    popTimer(tim);
    return tim;
}

@implementation NXGCDTimer

+ (void)initialize
{
    [super initialize];
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!__nx_timers__) {
            __nx_timers__ = [[NSMutableDictionary alloc] initWithCapacity:16];
        }
        if (!__nx_lock__) {
            __nx_lock__ = [NSRecursiveLock new];
        }
    });
}

+ (instancetype)repeatTimerWithInterval:(NSTimeInterval)seconds duration:(NSTimeInterval)duration onQueue:(dispatch_queue_t)queue handleBlock:(void (^)(NXGCDTimer *timer, BOOL reachEnd))aBlock
{
    [__nx_lock__ lock];
    
    NSString *uuidStr = [[NSUUID UUID] UUIDString];
    id tim = [self repeatTimerWithInterval:seconds name:uuidStr duration:duration onQueue:queue handleBlock:aBlock];
    
    [__nx_lock__ unlock];
    return tim;
}

+ (instancetype)repeatTimerWithInterval:(NSTimeInterval)seconds name:(NSString *)name duration:(NSTimeInterval)duration onQueue:(dispatch_queue_t)queue handleBlock:(void (^)(NXGCDTimer *timer, BOOL reachEnd))aBlock
{
    [__nx_lock__ lock];
    
    [self cancel:name];
    id tim = [[self alloc] initWithName:name];
    [tim repeatTimerWithInterval:seconds duration:duration onQueue:queue handleBlock:aBlock];
    
    [__nx_lock__ unlock];
    return tim;
}

+ (void)cancel:(NSString *)name
{
    [__nx_lock__ lock];
    
    NXGCDTimer *tim = popTimerNamed(name);
    [tim cancel];
    
    [__nx_lock__ unlock];
}

+ (void)cancelAllTimers
{
    [__nx_lock__ lock];
    
    NSArray *keys = [__nx_timers__ allKeys];
    for(NSString *key in keys) {
        NXGCDTimer *tim = popTimerNamed(key);
        [tim cancel];
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
        self.timerLock = [NSRecursiveLock new];
    }
    return self;
}

- initWithName:(NSString *)name
{
    self = [self init];
    if (self) {
        self.name = name;
    }
    return self;
}

- (void)repeatTimerWithInterval:(NSTimeInterval)seconds duration:(NSTimeInterval)duration onQueue:(dispatch_queue_t)queue handleBlock:(void (^)(NXGCDTimer *timer, BOOL reachEnd))aBlock
{
    [self.timerLock lock];
    [self cancel];
    
    self.timer = create_dispatch_timer(queue);
    self.counter = 0;
    pushTimer(self);
    
    dispatch_source_set_timer(self.timer, dispatch_time(DISPATCH_TIME_NOW, seconds * NSEC_PER_SEC), seconds * NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(self.timer, ^() {
        
        BOOL reachEnd = false;
        if (duration != 0.0 && (++self.counter * seconds) >= duration) {
            reachEnd = true;
        }
        if (aBlock) {
            aBlock(self, reachEnd);
        }else {
            NSLog(@"NXGCDTimer execution block is nil.");
        }
        
        if (reachEnd) {
            [self cancel];
        }
        
    });
    dispatch_resume(self.timer);
    [self.timerLock unlock];
}

- (void)cancel
{
    [self.timerLock lock];
    if (self.timer) {
        dispatch_source_cancel(self.timer);
        self.timer = nil;
    }
    popTimer(self);
    [self.timerLock unlock];
}

- (void)dealloc
{
#if DEBUG
    NSLog(@"%s", __func__);
#endif
}

@end
