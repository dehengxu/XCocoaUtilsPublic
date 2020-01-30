//
//  XCUPSafeTimer.h
//  XCocoaUtilsPublic
//
//  Created by Deheng Xu on 2020/1/16.
//  Copyright © 2020 Deheng.Xu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// A safe timer
@interface XCUPSafeTimer : NSObject

@property (nonatomic, readonly) void(^timerBlock)(NSTimer *);

/// Create a XCUPSafeTimer instance
/// @param interval Be update to NSTimer interval, units(seconds)
/// @param timerBlock trigger by every step
+ (instancetype)timerWithInterval:(NSTimeInterval)interval block:(void(^)(NSTimer *))timerBlock;

/// Create a repeat XCUPSafeTimer instance
/// @param interval repeat interval
/// @param timerBlock timer executable
+ (instancetype)repeatTimerWithInterval:(NSTimeInterval)interval block:(void(^)(NSTimer *))timerBlock;

/// Create a repeat XCUPSafeTimer instance
/// @param interval repeat interval
/// @param duration timer duration
/// @param timerBlock timer executable
+ (instancetype)repeatTimerWithInterval:(NSTimeInterval)interval duration:(NSTimeInterval)duration block:(void(^)(NSTimer *))timerBlock;

///
/// Start a new NSTimer
///
- (void)startTimer;

///
/// Cancel NSTimer
///
- (void)cancelTimer;

@end

NS_ASSUME_NONNULL_END
