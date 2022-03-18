//
//  NXObjCConcurrency.h
//  Test
//
//  Created by NicholasXu on 2022/2/3.
//  Copyright © 2022 com.dehengxu.ios. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

__BEGIN_DECLS

#ifdef __BLOCKS__
dispatch_queue_t nx_create_dispatch_queue(const char* _Nullable label, dispatch_queue_attr_t _Nullable attr);
dispatch_queue_t nx_create_dispatch_queue_with_target(const char* label, dispatch_queue_attr_t attr, dispatch_queue_t _Nullable target);
BOOL isSerial(dispatch_queue_t queue);
void syncOn(dispatch_queue_t queue, void(^worker)(void));
void asyncOn(dispatch_queue_t queue, void(^worker)(void));
#endif

__END_DECLS

@interface NXObjCConcurrency : NSObject

+ (void)setup;
+ (void)registerWithQueue:(dispatch_queue_t)queue;
+ (BOOL)isCurrent:(dispatch_queue_t)queue;
+ (NSArray* )currentDispatchQueues;

@end

NS_ASSUME_NONNULL_END
