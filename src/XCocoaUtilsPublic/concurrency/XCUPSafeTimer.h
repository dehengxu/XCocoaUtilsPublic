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

+ (instancetype)timerWithInterval:(NSTimeInterval)interval block:(void(^)(NSTimer *))timerBlock;
+ (instancetype)repeatTimerWithInterval:(NSTimeInterval)interval block:(void(^)(NSTimer *))timerBlock;
+ (instancetype)repeatTimerWithInterval:(NSTimeInterval)interval duration:(NSTimeInterval)duration block:(void(^)(NSTimer *))timerBlock;

- (void)startTimer;
- (void)cancelTimer;

@end

NS_ASSUME_NONNULL_END
