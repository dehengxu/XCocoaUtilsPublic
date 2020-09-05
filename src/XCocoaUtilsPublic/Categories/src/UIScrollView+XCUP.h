//
//  UIScrollView+Ext.h
//  XUtils
//
//  Created by Deheng.Xu on 13-6-21.
//  Copyright (c) 2013年 Deheng.Xu. All rights reserved.
//

#if TARGET_OS_IOS

#import <UIKit/UIKit.h>

@interface UIScrollView (XCUP)

@property (nonatomic) CGFloat contentWidth;
@property (nonatomic) CGFloat contentHeight;

- (void)autoUpdateInset;

@end

#endif
