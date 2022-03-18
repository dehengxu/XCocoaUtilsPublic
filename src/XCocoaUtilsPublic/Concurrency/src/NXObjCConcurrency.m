//
//  NXObjCConcurrency.m
//  Test
//
//  Created by NicholasXu on 2022/2/3.
//  Copyright © 2022 com.dehengxu.ios. All rights reserved.
//

#import "NXObjCConcurrency.h"
#import <objc/message.h>

dispatch_queue_t nx_create_queue(const char* label, dispatch_queue_attr_t attr) {
    dispatch_queue_t queue = dispatch_queue_create(label, attr);
    [NXObjCConcurrency registerWithQueue:queue];
    return queue;
}

dispatch_queue_t nx_create_dispatch_queue_with_target(const char* label, dispatch_queue_attr_t attr, dispatch_queue_t __nullable target) {
    dispatch_queue_t queue;
    if (@available(iOS 10.0, *)) {
        queue = dispatch_queue_create_with_target(label, attr, target);
    } else {
        dispatch_set_target_queue(queue, target);
    }
    [NXObjCConcurrency registerWithQueue:queue];
    return queue;
}

BOOL isSerial(dispatch_queue_t queue) {
    Class clazz = [queue class];
    Class rootClass = NSClassFromString(@"OS_dispatch_queue");
    Class serialClass = NSClassFromString(@"OS_dispatch_queue_serial");
    // Class concurrentClass = NSClassFromString(@"OS_dispatch_queue_concurrent");
    do {
        if (clazz == rootClass) {
            return NO;
        }
        if (clazz == serialClass) {
            return YES;
        }
    } while( (clazz = class_getSuperclass(clazz)) != nil );
    return  NO;
}

void syncOn(dispatch_queue_t queue, void(^worker)(void)) {
    if ([NXObjCConcurrency isCurrent:queue]) {
        worker();
    } else {
        dispatch_sync(queue, worker);
    }
}

void asyncOn(dispatch_queue_t queue, void(^worker)(void)) {
    if ([NXObjCConcurrency isCurrent:queue]) {
        worker();
    } else {
        dispatch_async(queue, worker);
    }
}


@class NXDispatchSpecificKeyWrapper;
static NSMutableSet<NXDispatchSpecificKeyWrapper *> *_keyBits = nil;

@interface NXDispatchSpecificKeyWrapper : NSObject
@property (nonatomic, assign) NSInteger value;
@property (nonatomic, strong) dispatch_queue_t queue;

@end

@implementation NXDispatchSpecificKeyWrapper

- (instancetype)initWithQueue:(dispatch_queue_t)queue {
    self = [super init];
    if (!self) {
        return nil;
    }
    self.queue = queue;
    dispatch_queue_set_specific(queue, (__bridge const void * _Nonnull)(self), (__bridge void * _Nullable)(self), nil);
    return self;
}

@end

@implementation NXObjCConcurrency

+ (void)initialize {
    [super initialize];
}

+ (void)setup {
    [self registerWithQueue:dispatch_get_main_queue()];
    [self registerWithQueue:dispatch_get_global_queue(QOS_CLASS_DEFAULT, 0)];
    [self registerWithQueue:dispatch_get_global_queue(QOS_CLASS_UTILITY, 0)];
    [self registerWithQueue:dispatch_get_global_queue(QOS_CLASS_USER_INTERACTIVE, 0)];
    [self registerWithQueue:dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0)];
    [self registerWithQueue:dispatch_get_global_queue(QOS_CLASS_BACKGROUND, 0)];
}

+ (void)registerWithQueue:(dispatch_queue_t)queue {
    if (nil == _keyBits) {
        _keyBits = [NSMutableSet new];
    }
    NXDispatchSpecificKeyWrapper* wrapper = [[NXDispatchSpecificKeyWrapper alloc] initWithQueue:queue];
    [_keyBits addObject:wrapper];
}

+ (BOOL)isCurrent:(dispatch_queue_t)queue {
    for (NXDispatchSpecificKeyWrapper* wrapper in _keyBits) {
        if (dispatch_get_specific((__bridge const void*)wrapper) == (__bridge void*)wrapper) {
            // Get current specific key
            if (dispatch_queue_get_specific(wrapper.queue, (__bridge const void*)wrapper) == (__bridge void*)wrapper) {
                return YES;
            }
        }
    }
    return NO;
}

+ (NSArray*)currentDispatchQueues {
    NSMutableArray* queues = [NSMutableArray new];
    for (NXDispatchSpecificKeyWrapper* wrapper in _keyBits) {
        if (dispatch_get_specific((__bridge const void*)wrapper) == (__bridge void*)wrapper) {
            // Get current specific key
            //if (dispatch_queue_get_specific(wrapper.queue, (__bridge const void*)wrapper) == (__bridge void*)wrapper) {
                [queues addObject:wrapper.queue];
            //}
        }
    }
    return queues;
}

@end
