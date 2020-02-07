//
//  FunctionSet.m
//  XUtilities
//
//  Created by Deheng.Xu on 13-4-28.
//  Copyright (c) 2013年 Nicholas.Xu. All rights reserved.
//

#import "XCUPCGFunctions.h"

#import <UIKit/UIKit.h>

extern inline BOOL CallDelegateWithArgs(NSObject **delegate, SEL selector, NSArray *args)
{
    if (*delegate && [*delegate respondsToSelector:selector]) {
        NSInvocation *invoc = [NSInvocation invocationWithMethodSignature:[*delegate methodSignatureForSelector:selector]];
        [invoc setArgument:delegate atIndex:0];
        [invoc setArgument:&selector atIndex:1];
        int starti = 2;
        for (__strong NSObject *arg in args) {
            [invoc setArgument:&arg atIndex:starti];
            starti ++;
        }
        [invoc invoke];
        return YES;
    }
    return NO;
}

// Candidate.
//extern inline void CallDelegateWithArgs(NSObject **delegate, SEL *selector, NSArray **args)
//{
//    if (!(*delegate)) {
//        return;
//    }
//    
//    [*delegate retain];
//    if (*delegate && [*delegate respondsToSelector:*selector]) {
//        NSInvocation *invoc = [NSInvocation invocationWithMethodSignature:[*delegate methodSignatureForSelector:*selector]];
//        [invoc setArgument:delegate atIndex:0];
//        [invoc setArgument:&selector atIndex:1];
//        int starti = 2;
//        for (__strong NSObject *arg in (*args)) {
//            [invoc setArgument:arg atIndex:starti];
//            starti ++;
//        }
//        [invoc invoke];
//    }
//    [*delegate release];
//}

extern inline CGRect CGRectResizeToCGSize(CGRect rect, CGSize size) {
    CGRect newrect = rect;
    newrect.size = size;
    return newrect;
}

extern inline CGRect CGRectResizeToWidth(CGRect rect, CGFloat width)
{
    CGRect newrect = rect;
    newrect.size = CGSizeMake(width, rect.size.height);
    return newrect;
}

extern inline CGRect CGRectResizeToHeight(CGRect rect, CGFloat height)
{
    CGRect newrect = rect;
    newrect.size = CGSizeMake(rect.size.width, height);
    return newrect;
}

extern inline CGRect CGRectMoveToCGPoint(CGRect rect, CGPoint point) {
    CGRect newrect = rect;
    newrect.origin = point;
    return newrect;
}

extern inline CGRect CGRectMoveToXPosition(CGRect rect, CGFloat x)
{
    CGRect newrect = rect;
    newrect.origin = CGPointMake(x, rect.origin.y);
    return newrect;
}

extern inline CGRect CGRectMoveToYPosition(CGRect rect, CGFloat y)
{
    CGRect newrect = rect;
    newrect.origin = CGPointMake(rect.origin.x, y);
    return newrect;
}

extern inline CGSize CGSizeScaleTo(CGSize size, CGFloat scale) {
    CGSize newsize = size;
    newsize.width = scale * size.width;
    newsize.height = scale * size.height;
    return newsize;
}

extern inline CGSize CGSizeScaleToScaleFactors(CGSize size, CGFloat widthFactor, CGFloat heightFactor) {
    CGSize newsize = size;
    newsize.width = widthFactor * size.width;
    newsize.height = heightFactor * size.height;
    return newsize;
}

extern inline void PrintCallStackSymbols(int depth) {
    NSArray *ar = [NSThread callStackSymbols];
    NSLog(@"%s %@", __func__, (([ar count] > depth && (depth > 0)) ? [ar subarrayWithRange:NSMakeRange(0, depth)] : ar));
}

#if TARGET_OS_IPHONE
extern inline CGFloat XOffsetFromUIView(UIView *view)
#else
extern inline CGFloat XOffsetFromUIView(NSView *view)
#endif
{
    return CGRectGetMinX(view.frame);
}

#if TARGET_OS_IPHONE
extern inline CGFloat YOffsetFromUIView(UIView *view)
#else
extern inline CGFloat YOffsetFromUIView(NSView *view)
#endif
{
    return CGRectGetMinY(view.frame);
}

#if TARGET_OS_IPHONE
extern inline CGFloat HeightFromUIView(UIView *view)
#else
extern inline CGFloat HeightFromUIView(NSView *view)
#endif
{
    return CGRectGetHeight(view.frame);
}

#if TARGET_OS_IPHONE
extern inline CGFloat WidthFromUIView(UIView *view)
#else
extern inline CGFloat WidthFromUIView(NSView *view)
#endif
{
    return CGRectGetWidth(view.frame);
}

char * hex2dec(const char * source)
{
    int last_non_zero_pos, i, hex_index;
    char * dec_string;
    
    /* log(16) = 1.204 */
    const double length_rate = 1.3;
    
    unsigned long hex_length = strlen(source);
    int dec_length = hex_length * length_rate + 1;
    
    /* Result goes here. */
    int * dec = (int *)malloc(dec_length * sizeof(int));
    
    /* Value of 0x1, 0x10, 0x100, 0x1000, ... */
    int * curr = (int *)malloc(dec_length * sizeof(int));
    
    for (i = 0; i < dec_length; i++)
    {
        dec[i] = curr[i] = 0;
    }
    
    /* 0x1 = 0000000000001(10) */
    curr[0] = 1;
    
    for (hex_index = 0; hex_index < hex_length; hex_index++)
    {
        /* Convert from right to left. */
        unsigned long hex_pos = hex_length - 1 - hex_index;
        char hex_curr_value = source[hex_pos];
        int dec_curr_value, dec_index, curr_index;
        
        /* Convert a single hex to dec. */
        if (hex_curr_value <= '9' && hex_curr_value >= '0')
        {
            dec_curr_value = hex_curr_value - '0';
        }
        else if (hex_curr_value <= 'f' && hex_curr_value >= 'a')
        {
            dec_curr_value = hex_curr_value - 'a' + 10;
        }
        else if (hex_curr_value <= 'F' && hex_curr_value >= 'A')
        {
            dec_curr_value = hex_curr_value - 'A' + 10;
        }
        
        /* Add this hex to dec result. */
        for (dec_index = 0; dec_index < dec_length; dec_index++)
        {
            dec[dec_index] += dec_curr_value * curr[dec_index];
        }
        for (dec_index = 0; dec_index < dec_length; dec_index++)
        {
            dec[dec_index + 1] += dec[dec_index] / 10;
            dec[dec_index] = dec[dec_index] % 10;
        }
        
        /* 0x1->0x10, 0x10->0x100, 0x100->0x1000, ... */
        for (curr_index = 0; curr_index < dec_length; curr_index++)
        {
            curr[curr_index] *= 16;
        }
        for (curr_index = 0; curr_index < dec_length; curr_index++)
        {
            curr[curr_index + 1] += curr[curr_index] / 10;
            curr[curr_index] = curr[curr_index] % 10;
        }
    }
    
    /* The output is reversed, so we should reverse it. */
    last_non_zero_pos = dec_length - 1;
    while (0 == dec[last_non_zero_pos])
    {
        last_non_zero_pos--;
    }
    dec_string = (char *)malloc((last_non_zero_pos + 2) * sizeof(char));
    for (i = 0; i < last_non_zero_pos + 1; i++)
    {
        dec_string[i] = dec[last_non_zero_pos - i] + '0';
    }
    
    free(dec);
    free(curr);
    
    return dec_string;
}

BOOL IsResponserCompressed(NSDictionary *responseHeaders) {
    NSArray * keys  = [NSArray arrayWithObjects:
                       //@"Content-Type", @"Content-Encoding",
                       @"Data-Encoding", nil];
    if (responseHeaders == nil) {
        return NO;
    }
    
    NSLog(@"%s %@", __FUNCTION__, responseHeaders);
    for (NSString * theKey in keys) {
        NSLog(@"theKey :%@", theKey);
        NSLog(@"value :%@", [responseHeaders valueForKey:theKey]);
        
        if ([responseHeaders valueForKey:theKey] == nil) {
            continue;
        }
        
        if ([[responseHeaders valueForKey:theKey] rangeOfString:@"gzip"].length > 0) {
            NSLog(@"range :%@", NSStringFromRange([[responseHeaders valueForKey:theKey] rangeOfString:@"gzip"]));
            return YES;
        }
        if ([[responseHeaders valueForKey:theKey] rangeOfString:@"x-gzip"].length > 0) {
            NSLog(@"range :%@", NSStringFromRange([[responseHeaders valueForKey:theKey] rangeOfString:@"x-gzip"]));
            return YES;
        }
    }
    return NO;
}


