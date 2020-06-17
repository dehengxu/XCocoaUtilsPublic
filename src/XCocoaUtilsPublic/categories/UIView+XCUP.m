//
//  UIView+Ext.m
//  ComputeDays
//
//  Created by Deheng.Xu on 13-5-21.
//  Copyright (c) 2013年 Nicholas.Xu. All rights reserved.
//

#import "UIView+XCUP.h"

#if TARGET_OS_IOS

@implementation UIView (XCUP)

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
    return self.bounds.size;
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

- (UIBezierPath *)bezierPathWithCorner:(CGFloat)radius
{
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:radius];
    return path;
}

- (void)drawColorBorder:(UIColor *)borderColor path:(UIBezierPath *)path borderWidth:(CGFloat)width cornerRadius:(CGFloat)radius inContext:(CGContextRef)ctx
{
    [path addClip];
    
    if (borderColor) {
        CGContextSetLineWidth(ctx, width);
        CGContextSetStrokeColorWithColor(ctx, borderColor.CGColor);
        CGContextAddPath(ctx, [path CGPath]);
        CGContextDrawPath(ctx, kCGPathStroke);
    }
}

- (void)fillInnerWithColor:(UIColor *)color path:(UIBezierPath *)path inContext:(CGContextRef)ctx
{
    CGContextSetFillColorWithColor(ctx, [color CGColor]);
    CGContextFillRect(ctx, self.bounds);
}

-(CGFloat)right
{
    return self.x + self.width;
}

-(CGFloat)bottom
{
    return self.y + self.height;
}

- (CGFloat)centerX
{
    return self.center.x;
}

- (void)setCenterX:(CGFloat)centerX
{
    CGPoint p = self.center;
    p.x = centerX;
    self.center = p;
}

- (CGFloat)centerY
{
    return self.center.y;
}

- (void)setCenterY:(CGFloat)centerY
{
    CGPoint p = self.center;
    p.y = centerY;
    self.center = p;
}

@end

#endif
