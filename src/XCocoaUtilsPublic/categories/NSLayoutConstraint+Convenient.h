//
//  NSLayoutConstraint+Convenient.h
//  PlaygroundLab
//
//  Created by DehengXu on 14/10/21.
//  Copyright (c) 2014年 DehengXu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSLayoutConstraint (Convenient)

+ (NSArray *)defaultConstraintsWithFormat:(NSString *)format views:(NSDictionary *)views;
+ (void)setConstraintsWithView:(UIView *)view size:(CGSize)size;
+ (void)followViewCenterX:(UIView *)v1 withView:(UIView *)v2;
+ (void)followViewCenterY:(UIView *)v1 withView:(UIView *)v2;
+ (void)followViewCenter:(UIView *)v1 withView:(UIView *)v2;

@end

@interface UIView (LayoutConstraint)

- (void)setConstraintSize:(CGSize)size onSuperView:(UIView *)superView;
- (void)followViewCenterX:(UIView *)v1;
- (void)followViewCenterY:(UIView *)v1;
- (void)followViewCenter:(UIView *)v1;

@end
