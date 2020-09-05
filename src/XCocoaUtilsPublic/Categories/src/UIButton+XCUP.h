//
//  UIButton+Utils.h
//  TaduUtils
//
//  Created by Deheng Xu on 11-8-9.
//  Copyright 2011年 Deheng.Xu. All rights reserved.
//

#if TARGET_OS_IPHONE

#import <UIKit/UIKit.h>

@interface UIButton (XCUP)

- (void)startAnimationForHidden;
- (void)startAnimationForShown;
- (void)startHidden;
- (void)startShown;
- (void)startAnimationForMovingToPoint:(CGPoint) newPosition;
- (void)startAnimationForMovingToDeltax:(CGFloat)dx andDeltay:(CGFloat)dy;

- (void)setNormalImage:(UIImage*)normalImage andHightlightImage:(UIImage*)highlightImage;
- (void)setNormalBkgImage:(UIImage *)normalImage andHightlightBkgImage:(UIImage *)highlightImage;
- (void)clearBackgroundColor;

@end

#endif
