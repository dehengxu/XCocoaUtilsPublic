//
//  UIView+Ext.h
//  ComputeDays
//
//  Created by Deheng.Xu on 13-5-21.
//  Copyright (c) 2013年 Nicholas.Xu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Ext)

@property (nonatomic) CGPoint origin;
@property (nonatomic) CGFloat x;
@property (nonatomic) CGFloat y;

@property (nonatomic) CGSize size;
@property (nonatomic) CGFloat width;
@property (nonatomic) CGFloat height;

- (void)clearBackgroundColor;

@end
