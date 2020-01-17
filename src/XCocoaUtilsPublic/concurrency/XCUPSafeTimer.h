//
//  XCUPSafeTimer.h
//  XCocoaUtilsPublic
//
//  Created by Deheng Xu on 2020/1/16.
//  Copyright © 2020 Deheng.Xu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XCUPSafeTimer : NSObject

@property (nonatomic, copy) void(^timerBlock)(NSTimer *);

/// Create a XCUPSafeTimer instance
/// @param interval Be update to NSTimer interval, units(seconds)
/// @param timerBlock trigger by every step
+ (instancetype)timerWithInterval:(NSTimeInterval)interval block:(void(^)(NSTimer *))timerBlock;
+ (instancetype)repeatTimerWithInterval:(NSTimeInterval)interval block:(void(^)(NSTimer *))timerBlock;
+ (instancetype)repeatTimerWithInterval:(NSTimeInterval)interval duration:(NSTimeInterval)duration block:(void(^)(NSTimer *))timerBlock;


///
/// Start a new NSTimer, 
///
///
- (void)startTimer;
- (void)cancelTimer;

@end

NS_ASSUME_NONNULL_END
