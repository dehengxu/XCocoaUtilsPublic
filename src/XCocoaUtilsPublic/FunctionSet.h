//
//  FunctionSet.h
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

#pragma mark - ARC tool

#ifndef ARC_ENABLED
#define ARC_ENABLED  __has_feature(objc_arc)
#endif

#ifndef ARC_DISABLED
#define ARC_DISABLED  !__has_feature(objc_arc)
#endif

#pragma mark - Memory management utility.

#if ARC_ENABLED
//Add macro for arc

#else
//Add macro for no-arc


#endif

#ifndef BlockSafeRelease

#if !ARC_ENABLED
#define BlockSafeRelease(block) do{if(block) {Block_release(block); block = NULL;}}while(0)
#else
#define BlockSafeRelease(block) do{block = NULL;}while(0)
#endif

#endif

#ifndef SafeRelease

#if !ARC_ENABLED
#define SafeRelease(obj) do {if (obj){[(obj) release];(obj) = nil;}}while (0)
#else
#define SafeRelease(obj) do {(obj) = nil;}while(0)
#endif

#endif

#ifndef XRetain

#if !ARC_ENABLED
#define XRetain(obj) [(obj) retain]
#else
#define XRetain(obj) (obj)
#endif

#endif

#ifndef XRelease

#if !ARC_ENABLED
#define XRelease(obj) do{[obj release];}while(0)
#else
#define XRelease(obj) 
#endif

#endif

#ifndef XAutorelease

#if !ARC_ENABLED
#define XAutorelease(obj) [(obj) autorelease]
#else
#define XAutorelease(obj) (obj)
#endif

#endif

#ifndef CFSafeRelease

#if !ARC_ENABLED
#define CFSafeRelease(x) do{if ((x)) {CFRelease((x));(x)=NULL;}}while(0)
#else
#define CFSafeRelease(x) 
#endif

#endif

#ifndef DispatchSafeRelease

#if !ARC_ENABLED
#define DispatchSafeRelease(x) do{if ((x)) { dispatch_release((x)); (x) = NULL; }}while(0)
#else
#define DispatchSafeRelease(x)
#endif

#endif

//XSuperDealloc
#if !ARC_ENABLED
#define XSuperDealloc() [super dealloc]
#else
#define XSuperDealloc()
#endif

#pragma mark - Convert utility.

#define CFStringRefByNSString(str)  ((__bridge CFStringRef)(str))

#define CFMutableStringRefByNSMutableString(str) ((__bridge CFMutableStringRef)(str))

#define CFDataRefByNSData(dat)      ((__bridge CFDataRef)(dat))

#ifndef CFStringWithCstring
#define CFStringWithCstring(cstring) CFStringCreateWithCString(kCFAllocatorDefault, cstring, kCFStringEncodingUTF8)
#endif

#define CFArrayRefByNSArray(arr)    ((__bridge CFArrayRef)(arr))

#define NSArrayByCFArrayRef(cfarr)  ((NSArray *)cfarr)

#define NSMutableArrayByCFMutableArrayRef(cfarr)  ((NSMutableArray *)cfarr)

#if ARC_ENABLED
#define NSStringByCFStringRef(strRef) ((__bridge_transfer NSString*) (strRef))
#else
#define NSStringByCFStringRef(strRef) ((NSString*) (strRef))
#endif

#define CFObjectAddress(CFObj)  ((CFIndex) CFObj)

#define NSObjectAddress(NSObj)  ((NSUInteger) NSObj)

#define ValueAtPoint(point) (*(point))

#ifndef AUTORELEASE_POOL_BEGIN
#if ARC_ENABLED
#define AUTORELEASE_POOL_BEGIN @autoreleasepool{
#else
#define AUTORELEASE_POOL_BEGIN     NSAutoreleasePool *_pool = [NSAutoreleasePool new];
#endif
#endif

#ifndef AUTORELEASE_POOL_END
#if ARC_ENABLED
#define AUTORELEASE_POOL_END    }
#else
#define AUTORELEASE_POOL_END    [_pool drain];
#endif
#endif

#ifndef ValueWithBitMask
#define ValueWithBitMask(testedValue,maskCode)    ((testedValue) & (maskCode))
#endif

#pragma mark - web utility.

#define JS_HTML_TITLE    @"document.title"
#define JS_HTML_BODY     @"document.documentElement.innerHTML"
#define JS_HTML_OUTER    @"document.documentElement.outerHTML"

#pragma mark - UIKit utility.

#ifndef STATUS_FRAME
#define STATUS_FRAME  ([UIApplication sharedApplication].statusBarFrame)
#endif

#ifndef APP_FRAME
#define APP_FRAME ([[UIScreen mainScreen] applicationFrame])
#endif

#ifndef APP_BOUNDS
#define APP_BOUNDS ([[UIScreen mainScreen] bounds])
#endif

#ifndef UIViewAutoresizeWidthHeight
#define UIViewAutoresizeWidthHeight UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight
#endif

#ifndef UIViewAutoresizeFlexibleAround
#define UIViewAutoresizeFlexibleAround UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleRightMargin
#endif

#ifndef SYNTHESIZE_SINGLETON_FOR_CLASS
#define SYNTHESIZE_SINGLETON_FOR_CLASS(classname) \
\
static classname *shared##classname = nil; \
\
+ (classname *)shared##classname \
{ \
@synchronized(self) \
{ \
if (shared##classname == nil) \
{ \
shared##classname = [[self alloc] init]; \
} \
} \
\
return shared##classname; \
} \
\
+ (id)allocWithZone:(NSZone *)zone \
{ \
@synchronized(self) \
{ \
if (shared##classname == nil) \
{ \
shared##classname = [super allocWithZone:zone]; \
return shared##classname; \
} \
} \
\
return nil; \
} \
\
- (id)copyWithZone:(NSZone *)zone \
{ \
return self; \
} \
\
- (id)retain \
{ \
return self; \
} \
\
- (NSUInteger)retainCount \
{ \
return NSUIntegerMax; \
} \
\
- (oneway void)release \
{ \
} \
\
- (id)autorelease \
{ \
return self; \
}
#endif

#pragma mark - function

//Used for delegate selector call, auto check delegate value and selector implementation.
//#ifndef CALL_DELEGATE_WITH_ARGS
//#define CALL_DELEGATE_WITH_ARGS(delegate, selector, args)   CallDelegateWithArgs(&delegate, selector, args)
extern inline void CallDelegateWithArgs(NSObject **delegate, SEL selector, NSArray *args);
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

@interface FunctionSet : NSObject

@end

