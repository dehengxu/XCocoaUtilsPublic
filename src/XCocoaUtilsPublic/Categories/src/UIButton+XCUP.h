//
//  UIButton+Utils.h
//  TaduUtils
//
//  Created by Deheng Xu on 11-8-9.
//  Copyright 2011年 Deheng.Xu. All rights reserved.
//

#if TARGET_OS_IPHONE

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (XCUP)

#pragma mark - Block button

/// Create a button with a block instead of target/action
/// @param type UIButtonType
/// @param handleBlock a block 
+ (instancetype)blockButtonWithType:(UIButtonType)type handler:(nullable void(^)(id sender))handleBlock;

/// Create a button with a block default nil, instead of target/action
/// @param type UIButtonType
+ (instancetype)blockButtonWithType:(UIButtonType)type;

/// Only can be used on object created with blockButtonWithType:handler:
/// @param handleBlock a new action block
- (void)setHandler:(void(^)(id sender))handleBlock;

#pragma mark - Convinience init

+ (instancetype)buttonWithTitle:(NSString *)title target:(id)target selector:(SEL)selector type:(UIButtonType)type;

#pragma mark - Animation related

- (void)startAnimationForHidden;
- (void)startAnimationForShown;
- (void)startHidden;
- (void)startShown;
- (void)startAnimationForMovingToPoint:(CGPoint) newPosition;
- (void)startAnimationForMovingToDeltax:(CGFloat)dx andDeltay:(CGFloat)dy;

#pragma mark - Button image related

- (void)setNormalImage:(UIImage*)normalImage andHightlightImage:(UIImage*)highlightImage;
- (void)setNormalBkgImage:(UIImage *)normalImage andHightlightBkgImage:(UIImage *)highlightImage;
- (void)clearBackgroundColor;

@end

NS_ASSUME_NONNULL_END

#endif
