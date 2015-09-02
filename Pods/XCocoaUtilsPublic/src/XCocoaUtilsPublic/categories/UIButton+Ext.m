//
//  UIButton+Utils.m
//  TaduUtils
//
//  Created by Deheng Xu on 11-8-9.
//  Copyright 2011年 Deheng.Xu. All rights reserved.
//

#import "UIButton+Ext.h"
#import "UIView+Ext.h"

#if TARGET_OS_IPHONE

@implementation UIButton (Ext)

//- (id)initWithFrame:(CGRect)frame
//{
//    self = [super initWithFrame:frame];
//    if (self) {
//        // Initialization code
//    }
//    return self;
//}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)startAnimationForHidden
{
#if USING_BLOCK
    
    [UIView animateWithDuration:0.25f animations:^{
        [self setAlpha:0.0f];
    } completion:^(BOOL finished) {
        //NSLog(@"Hide animation finished! %@   %@", self.imageView, self.superview);
    }];
    
#else

    [UIView beginAnimations:nil context:nil];
    [self setAlpha:0.0f];
    [UIView commitAnimations];
    
#endif
}

- (void)startAnimationForShown
{
#if USING_BLOCK
    
    [UIView animateWithDuration:0.25f animations:^{
        [self setAlpha:1.0f];
    } completion:^(BOOL finished) {
        //NSLog(@"Show animation finished! %@  %@", self.imageView, self.superview);
    }];
    
#else
    
    [UIView beginAnimations:nil context:nil];
    [self setAlpha:1.0f];
    [UIView commitAnimations];
    
#endif
}
- (void)startHidden
{
    [self setAlpha:0.0f];
}
- (void)startShown
{
  [self setAlpha:1.0f];  
}

- (void)startAnimationForMovingToPoint:(CGPoint)newPosition
{
    CGRect fm = self.frame;
    [UIView beginAnimations:nil context:nil];
    fm.origin = newPosition;
    self.frame = fm;
    [UIView commitAnimations];
}

- (void)startAnimationForMovingToDeltax:(CGFloat)dx andDeltay:(CGFloat)dy
{
    CGRect fm = self.frame;
    [UIView beginAnimations:nil context:nil];
    fm.origin = CGPointMake(fm.origin.x + dx, fm.origin.y);
    self.frame = fm;
    [UIView commitAnimations];
}

- (void)setNormalImage:(UIImage *)normalImage andHightlightImage:(UIImage *)highlightImage
{
    if (normalImage && [normalImage isKindOfClass:[UIImage class]]) {
        [self setImage:normalImage forState:UIControlStateNormal];
    }
    if (highlightImage && [highlightImage isKindOfClass:[UIImage class]]) {
        [self setImage:highlightImage forState:UIControlStateHighlighted];
    }
}

- (void)setNormalBkgImage:(UIImage *)normalImage andHightlightBkgImage:(UIImage *)highlightImage
{
    if (normalImage && [normalImage isKindOfClass:[UIImage class]]) {
        [self setBackgroundImage:normalImage forState:UIControlStateNormal];
    }
    if (highlightImage && [highlightImage isKindOfClass:[UIImage class]]) {
        [self setBackgroundImage:highlightImage forState:UIControlStateHighlighted];
    }
}

- (void)clearBackgroundColor
{
    [self setBackgroundColor:[UIColor clearColor]];
}

@end

#endif
