//
//  UIView+Ext.h
//  ComputeDays
//
//  Created by Deheng.Xu on 13-5-21.
//  Copyright (c) 2013年 Nicholas.Xu. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UIView (XCUP)

@property (nonatomic) CGPoint origin;
@property (nonatomic) CGFloat x;
@property (nonatomic) CGFloat y;

@property (nonatomic) CGSize size;
@property (nonatomic) CGFloat width;
@property (nonatomic) CGFloat height;

@property (nonatomic,readonly) CGFloat right;
@property (nonatomic,readonly) CGFloat bottom;

@property (nonatomic) CGFloat centerX;
@property (nonatomic) CGFloat centerY;

- (void)clearBackgroundColor;

- (UIBezierPath *)bezierPathWithCorner:(CGFloat)radius;
- (void)drawColorBorder:(UIColor *)color path:(UIBezierPath *)path borderWidth:(CGFloat)width cornerRadius:(CGFloat)radius inContext:(CGContextRef)ctx;
- (void)fillInnerWithColor:(UIColor *)color path:(UIBezierPath *)path inContext:(CGContextRef)ctx;

@end