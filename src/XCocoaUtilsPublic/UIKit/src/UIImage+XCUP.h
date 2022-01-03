//
//  UIImage+Ext.h
//  TaduNewUI
//
//  Created by Xu Deheng on 12-5-18.
//  Copyright (c) 2012年 ___MyCompony__ All rights reserved.
//

#if TARGET_OS_IPHONE

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (XCUP)
+ (UIImage*)imageWithColor:(UIColor*)color size:(CGSize)size;
@end

NS_ASSUME_NONNULL_END

#endif
