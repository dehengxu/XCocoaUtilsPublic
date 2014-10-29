//
//  NSLayoutConstraint+Convenient.m
//  PlaygroundLab
//
//  Created by DehengXu on 14/10/21.
//  Copyright (c) 2014年 DehengXu. All rights reserved.
//

#import "NSLayoutConstraint+Convenient.h"

@implementation NSLayoutConstraint (Convenient)

+ (NSArray *)defaultConstraintsWithFormat:(NSString *)format views:(NSDictionary *)views
{
    return [NSLayoutConstraint constraintsWithVisualFormat:format options:0 metrics:nil views:views];
}

+ (void)setConstraintsWithView:(UIView *)view size:(CGSize)size
{
    if (!view.superview) {
        return;
    }
    NSArray *constraints = nil;

    constraints = [NSLayoutConstraint defaultConstraintsWithFormat:[NSString stringWithFormat:@"[view(%f)]", size.width] views:NSDictionaryOfVariableBindings(view, view.superview)];
    [view.superview addConstraints:constraints];

    constraints = [NSLayoutConstraint defaultConstraintsWithFormat:[NSString stringWithFormat:@"V:[view(%f)]", size.height] views:NSDictionaryOfVariableBindings(view, view.superview)];
    [view.superview addConstraints:constraints];
}

+ (void)followViewCenterX:(UIView *)v1 withView:(UIView *)v2
{
    if (!v2.superview) {
        return;
    }

    id constraint = [NSLayoutConstraint constraintWithItem:v2 attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:v1 attribute:NSLayoutAttributeCenterX multiplier:1. constant:0];
    [v2.superview addConstraint:constraint];
}

+ (void)followViewCenterY:(UIView *)v1 withView:(UIView *)v2
{
    if (!v2.superview) {
        return;
    }

    id constraint = [NSLayoutConstraint constraintWithItem:v2 attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:v1 attribute:NSLayoutAttributeCenterY multiplier:1. constant:0];
    [v2.superview addConstraint:constraint];
}

+ (void)followViewCenter:(UIView *)v1 withView:(UIView *)v2
{
    [self followViewCenterX:v1 withView:v2];
    [self followViewCenterY:v1 withView:v2];
}

@end

@implementation UIView (LayoutConstraint)

- (void)setConstraintSize:(CGSize)size onSuperView:(UIView *)superView
{
    if (!superView) {
        return;
    }
    NSArray *constraints = nil;

    constraints = [NSLayoutConstraint defaultConstraintsWithFormat:[NSString stringWithFormat:@"[view(%f)]", size.width] views:NSDictionaryOfVariableBindings(self, superView)];
    [superView addConstraints:constraints];

    constraints = [NSLayoutConstraint defaultConstraintsWithFormat:[NSString stringWithFormat:@"V:[view(%f)]", size.height] views:NSDictionaryOfVariableBindings(self, superView)];
    [superView addConstraints:constraints];

}

- (void)followViewCenterX:(UIView *)v1
{
    [NSLayoutConstraint followViewCenterX:v1 withView:self];
}

- (void)followViewCenterY:(UIView *)v1
{
    [NSLayoutConstraint followViewCenterY:v1 withView:self];
}

- (void)followViewCenter:(UIView *)v1
{
    [NSLayoutConstraint followViewCenter:v1 withView:self];
}

@end


