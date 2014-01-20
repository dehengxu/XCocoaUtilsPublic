//
//  UIScrollView+Ext.h
//  XUtils
//
//  Created by Deheng.Xu on 13-6-21.
//  Copyright (c) 2013年 Deheng.Xu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScrollView (Ext)

@property (nonatomic) CGFloat contentWidth;
@property (nonatomic) CGFloat contentHeight;

- (void)autoUpdateInset;

@end
