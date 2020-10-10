//
//  CGFunctionSet.h
//  XUtilities
//
//  Created by Deheng.Xu on 13-4-28.
//  Copyright (c) 2013年 Nicholas.Xu. All rights reserved.
//

#import <UIKit/UIKit.h>

#if TARGET_OS_IPHONE

#import <UIKit/UIKit.h>

#elif TARGET_OS_MAC

#import <AppKit/AppKit.h>

#endif

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>


#ifndef ValueWithBitMask
#define ValueWithBitMask(testedValue,maskCode)    ((testedValue) & (maskCode))
#endif

#ifndef CheckIfDelegateResponseSelector
#define CheckIfDelegateResponseSelector(delegate, selector)\
((delegate) && [(delegate) respondsToSelector:selector])
#endif

#pragma mark - function

//Used for delegate selector call, auto check delegate value and selector implementation.
//#ifndef CALL_DELEGATE_WITH_ARGS
//#define CALL_DELEGATE_WITH_ARGS(delegate, selector, args)   CallDelegateWithArgs(&delegate, selector, args)
extern BOOL CallDelegateWithArgs(NSObject **delegate, SEL selector, NSArray *args);
//#endif

extern CGRect CGRectResizeToCGSize(CGRect rect, CGSize size);
extern CGRect CGRectResizeToWidth(CGRect rect, CGFloat width);
extern CGRect CGRectResizeToHeight(CGRect rect, CGFloat height);

extern CGRect CGRectMoveToCGPoint(CGRect rect, CGPoint point);
extern CGRect CGRectMoveToXPosition(CGRect rect, CGFloat x);
extern CGRect CGRectMoveToYPosition(CGRect rect, CGFloat y);
extern CGSize CGSizeScaleTo(CGSize size, CGFloat factor);
extern CGSize CGSizeScaleToScaleFactors(CGSize size, CGFloat widthFactor, CGFloat heightFactor);

extern CGPoint CGRectGetCenter(CGRect rect);

//Print call stack symbols by depth.
extern void PrintCallStackSymbols(int depth);

#if TARGET_OS_IPHONE

extern CGFloat XOffsetFromUIView(UIView *view);
extern CGFloat YOffsetFromUIView(UIView *view);
extern CGFloat HeightFromUIView(UIView *view);
extern CGFloat WidthFromUIView(UIView *view);

#else

extern CGFloat XOffsetFromUIView(NSView *view);
extern CGFloat YOffsetFromUIView(NSView *view);
extern CGFloat HeightFromUIView(NSView *view);
extern CGFloat WidthFromUIView(NSView *view);

#endif

extern char * hex2dec(const char * source);

BOOL IsResponserCompressed(NSDictionary *responseHeaders);


