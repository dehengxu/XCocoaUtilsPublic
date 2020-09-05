//
//  NXGCDTimer.h
//  GCDCases
//
//  Created by NicholasXu on 2020/2/12.
//  Copyright © 2020 DehengXu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

FOUNDATION_EXPORT dispatch_source_t create_dispatch_timer(dispatch_queue_t queue);

@interface NXGCDTimer : NSObject
@property (readonly) NSString *name;

+ (instancetype)repeatTimerWithInterval:(NSTimeInterval)seconds duration:(NSTimeInterval)duration onQueue:(dispatch_queue_t)queue handleBlock:(void(^)(NXGCDTimer *timer, BOOL reachEnd))aBlock;

+ (instancetype)repeatTimerWithInterval:(NSTimeInterval)seconds name:(NSString *)name duration:(NSTimeInterval)duration onQueue:(dispatch_queue_t)queue handleBlock:(void(^)(NXGCDTimer *timer, BOOL reachEnd))aBlock;

+ (void)cancel:(NSString *)name;

+ (void)cancelAllTimers;

- (void)repeatTimerWithInterval:(NSTimeInterval)seconds duration:(NSTimeInterval)duration onQueue:(dispatch_queue_t)queue handleBlock:(void(^)(NXGCDTimer *timer, BOOL reachEnd))aBlock;

- (void)cancel;

@end

NS_ASSUME_NONNULL_END
