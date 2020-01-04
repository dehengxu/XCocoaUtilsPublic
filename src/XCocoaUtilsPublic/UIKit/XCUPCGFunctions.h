//
//  CGFunctionSet.h
//  XUtilities
//
//  Created by Deheng.Xu on 13-4-28.
//  Copyright (c) 2013年 Nicholas.Xu. All rights reserved.
//

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
extern inline BOOL CallDelegateWithArgs(NSObject **delegate, SEL selector, NSArray *args);
//#endif

extern inline CGRect CGRectResizeToCGSize(CGRect rect, CGSize size);
extern inline CGRect CGRectResizeToWidth(CGRect rect, CGFloat width);
extern inline CGRect CGRectResizeToHeight(CGRect rect, CGFloat height);

extern inline CGRect CGRectMoveToCGPoint(CGRect rect, CGPoint point);
extern inline CGRect CGRectMoveToXPosition(CGRect rect, CGFloat x);
extern inline CGRect CGRectMoveToYPosition(CGRect rect, CGFloat y);
extern inline CGSize CGSizeScaleTo(CGSize size, CGFloat factor);
extern inline CGSize CGSizeScaleToScaleFactors(CGSize size, CGFloat widthFactor, CGFloat heightFactor);

//Print call stack symbols by depth.
extern void PrintCallStackSymbols(int depth);

#if TARGET_OS_IPHONE

extern inline CGFloat XOffsetFromUIView(UIView *view);
extern inline CGFloat YOffsetFromUIView(UIView *view);
extern inline CGFloat HeightFromUIView(UIView *view);
extern inline CGFloat WidthFromUIView(UIView *view);

#else

extern inline CGFloat XOffsetFromUIView(NSView *view);
extern inline CGFloat YOffsetFromUIView(NSView *view);
extern inline CGFloat HeightFromUIView(NSView *view);
extern inline CGFloat WidthFromUIView(NSView *view);

#endif

extern char * hex2dec(const char * source);

BOOL IsResponserCompressed(NSDictionary *responseHeaders);


