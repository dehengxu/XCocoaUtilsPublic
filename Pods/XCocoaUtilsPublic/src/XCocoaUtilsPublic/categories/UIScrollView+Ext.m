//
//  UIScrollView+Ext.m
//  XUtils
//
//  Created by Deheng.Xu on 13-6-21.
//  Copyright (c) 2013年 Deheng.Xu. All rights reserved.
//

#import "UIScrollView+Ext.h"

@implementation UIScrollView (Ext)

- (CGFloat)contentWidth
{
    return self.contentSize.width;
}

- (void)setContentWidth:(CGFloat)contentWidth
{
    self.contentSize = CGSizeMake(contentWidth, self.contentSize.height);
}

- (CGFloat)contentHeight
{
    return self.contentSize.height;
}

- (void)setContentHeight:(CGFloat)contentHeight
{
    self.contentSize = CGSizeMake(self.contentSize.width, contentHeight);
}

- (void)autoUpdateInset
{
    if ([UIDevice currentDevice].systemVersion.floatValue >= 7.0) {
        self.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    }else {
        self.contentInset = UIEdgeInsetsMake(44, 0, 0, 0);
    }
}

@end
