//
//  UIButton+Utils.m
//  TaduUtils
//
//  Created by Deheng Xu on 11-8-9.
//  Copyright 2011年 Deheng.Xu. All rights reserved.
//

#import "UIButton+XCUP.h"
#import "UIView+XCUP.h"

#if TARGET_OS_IPHONE

@interface XCUPBlockButton : UIButton
@property (nonatomic, copy) void(^actionBlock)(id sender);
- (void)_private_onClick:(id) sender;
@end

@implementation XCUPBlockButton

- (void)_private_onClick:(id)sender {
	if (self.actionBlock) {
		self.actionBlock(self);
	}
}

- (void)addTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents {
	if ([target isKindOfClass:XCUPBlockButton.class] && action == @selector(_private_onClick:)) {
		[super addTarget:target action:action forControlEvents:controlEvents];
	}else {
		NSAssert(false, @"XCUPBlockButton only wrap selector _private_onClick: with block");
	}
}

@end

@implementation UIButton (XCUP)

+ (UIButton *)blockButtonWithType:(UIButtonType)type handler:(void (^)(id))handleBlock {
	XCUPBlockButton *btn = [XCUPBlockButton buttonWithType:type];
	[btn addTarget:btn action:@selector(_private_onClick:) forControlEvents:UIControlEventTouchUpInside];
	[btn setHandler:handleBlock];
	return btn;
}

+ (UIButton *)blockButtonWithType:(UIButtonType)type {
	return [self blockButtonWithType:type handler:nil];
}

- (void)setHandler:(void(^)(id sender))handleBlock {
	if ([self isKindOfClass:XCUPBlockButton.class]) {
		[(XCUPBlockButton*)self setActionBlock:handleBlock];
	}
}

+ (instancetype)buttonWithTitle:(NSString *)title target:(id)target selector:(SEL)selector type:(UIButtonType)type {
	id btn = [self buttonWithType:type];
	[btn setTitle:title forState:UIControlStateNormal];
	[btn addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
	return btn;
}

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
