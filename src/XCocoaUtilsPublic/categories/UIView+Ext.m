//
//  UIView+Ext.m
//  ComputeDays
//
//  Created by Deheng.Xu on 13-5-21.
//  Copyright (c) 2013年 Nicholas.Xu. All rights reserved.
//

#import "UIView+Ext.h"

@implementation UIView (Ext)

- (CGPoint)origin
{
    return self.frame.origin;
}

- (void)setOrigin:(CGPoint)origin
{
    CGRect f = self.frame;
    f.origin = origin;
    self.frame = f;
}

- (CGSize)size
{
    return self.frame.size;
}

- (void)setSize:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGFloat)x
{
    return [self origin].x;
}

- (void)setX:(CGFloat)originX
{
    CGRect f = self.frame;
    f.origin.x = originX;
    self.frame = f;
}

- (CGFloat)y
{
    return [self origin].y;
}

- (void)setY:(CGFloat)originY
{
    CGRect f = self.frame;
    f.origin.y = originY;
    self.frame = f;
}

- (CGFloat)width
{
    return [self size].width;
}

- (void)setWidth:(CGFloat)width
{
    CGRect f = self.frame;
    f.size.width = width;
    self.frame = f;
}

- (CGFloat)height
{
    return [self size].height;
}

- (void)setHeight:(CGFloat)height
{
    CGRect f = self.frame;
    f.size.height = height;
    self.frame = f;
}

- (void)clearBackgroundColor
{
    [self setBackgroundColor:[UIColor clearColor]];
}

@end
