//
//  ocmacros.h
//  XCocoaUtilsPublic
//
//  Created by NicholasXu on 2018/12/10.
//  Copyright © 2018 Deheng.Xu. All rights reserved.
//

#ifndef ocmacros_h
#define ocmacros_h

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

#define ValueAtPoint(point) (*(point))

#define CFObjectAddress(CFObj)  ((CFIndex) CFObj)

#define NSObjectAddress(NSObj)  ((NSUInteger) NSObj)

#define weakify(var) __weak typeof(var) xcup_weak_##var = var;

#define strongify(var) \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Wshadow\"") \
__strong typeof(var) var = xcup_weak_##var; \
_Pragma("clang diagnostic pop")

#endif /* ocmacros_h */
