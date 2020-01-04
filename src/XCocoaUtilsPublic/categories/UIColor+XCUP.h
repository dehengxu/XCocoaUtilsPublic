//
//  UIColor+Utils.h
//  TaduUtils
//
//  Created by Deheng.Xu on 11-7-24.
//  Copyright 2011 Deheng.Xu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#if TARGET_OS_IPHONE

@interface UIColor (XCUP)

+ (UIColor *)colorWithARGB:(long long)argb;
+ (UIColor *)colorWithAlpha:(NSUInteger)alpha Red:(NSUInteger)red green:(NSUInteger)green blue:(NSUInteger)blue;
+ (UIColor *)colorWithARGBNSString:(NSString *)argb;
+ (UIColor *)colorWithARGBCString:(const char *)argb;
+ (UIColor *)colorWithImageName:(NSString *)imageName;
+ (UIColor *)randomColor;

@end

#endif
