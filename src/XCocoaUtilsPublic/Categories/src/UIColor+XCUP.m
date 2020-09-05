//
//  UIColor+Utils.m
//  TaduUtils
//
//  Created by Deheng.Xu on 11-7-24.
//  Copyright 2011 Deheng.Xu. All rights reserved.
//

#import "UIColor+XCUP.h"

#if TARGET_OS_IPHONE

@implementation UIColor (XCUP)

+ (UIColor *)colorWithARGB:(long long)argb;
{
	NSUInteger a, r, g, b;
	CGFloat base = 255.0;
	b = (argb & 0xff);
	g = ((argb >> 8) & 0xff);
	r = ((argb >> 16) & 0xff);
	a = ((argb >> 24) & 0xff);
	
	return [UIColor colorWithRed:r / base green:g / base blue:b / base alpha:a / base];
}

+ (UIColor *)colorWithAlpha:(NSUInteger)alpha Red:(NSUInteger)red green:(NSUInteger)green blue:(NSUInteger)blue
{
	CGFloat base = 255.0;
	return [UIColor colorWithRed:red / base green:green / base blue:blue / base alpha:alpha / base];
}

+ (UIColor *)colorWithARGBNSString:(NSString *)argb
{
    return [UIColor colorWithARGBCString:[argb cStringUsingEncoding:NSASCIIStringEncoding]];
}

+ (UIColor *)colorWithARGBCString:(const char *)argb
{
    if (argb == NULL) {
        return nil;
    }
    return [UIColor colorWithARGB:strtoll(argb, NULL, 16)];
}

+ (UIColor *)colorWithImageName:(NSString *)imageName
{
    return [UIColor colorWithPatternImage:[UIImage imageNamed:imageName]];
}

+ (UIColor *)randomColor
{
    return [UIColor colorWithHue:(labs(random()) % 255 / 255.0) saturation:(labs(random() % 255) / 255.0) brightness:(labs(random() % 255) / 255.0) alpha:1.0];
}

@end

#endif
