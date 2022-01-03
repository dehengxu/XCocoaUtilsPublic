//
//  UIImage+Ext.m
//  TaduNewUI
//
//  Created by Xu Deheng on 12-5-18.
//  Copyright (c) 2012年 ___MyCompony__ All rights reserved.
//

#import "UIImage+XCUP.h"

#if TARGET_OS_IPHONE

@implementation UIImage (XCUP)
+ (UIImage*)imageWithColor:(UIColor*)color size:(CGSize)size
{
    if (CGSizeEqualToSize(size, CGSizeZero)) {
        return nil;
    }
    UIImage *rtn = nil;
    UIGraphicsBeginImageContext(size);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(ctx, color.CGColor);
    CGContextFillRect(ctx, CGRectMake(0, 0, size.width, size.height));
    rtn = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return rtn;
}
@end

#endif
