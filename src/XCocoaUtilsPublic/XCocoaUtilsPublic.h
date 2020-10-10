//
//  XCocoaUtilsPublic.h
//  XCocoaUtilsPublic
//
//  Created by Deheng.Xu on 13-10-30.
//  Copyright (c) 2013年 Deheng.Xu. All rights reserved.
//

#ifndef XCocoaUtilsPublic_XCocoaUtilsPublic_h
#define XCocoaUtilsPublic_XCocoaUtilsPublic_h

#import <UIKit/UIKit.h>

// General categories
#if __has_include(<XCocoaUtilsPublic/extensions.h>)
#import <XCocoaUtilsPublic/extensions.h>
#endif

// Logging
#if __has_include(<XCocoaUtilsPublic/XLogging.h>)
#import <XCocoaUtilsPublic/XLogging.h>
#endif

// Runtime
#if __has_include(<XCocoaUtilsPublic/NSInvocation+XCUP.h>)
#import <XCocoaUtilsPublic/NSInvocation+XCUP.h>
#endif

// Concurrency
#if __has_include(<XCocoaUtilsPublic/XCUPConcurrency.h>)
#import <XCocoaUtilsPublic/XCUPConcurrency.h>
#endif

// Http
#if __has_include(<XCocoaUtilsPublic/XCUPHttp.h>)
#import <XCocoaUtilsPublic/XCUPHttp.h>
#endif

//Debug
#if __has_include(<XCocoaUtilsPublic/XCUPDebug.h>)
#import <XCocoaUtilsPublic/XCUPDebug.h>
#endif

// C macros
#if __has_include(<XCocoaUtilsPublic/XCUPMacros.h>)
#import <XCocoaUtilsPublic/XCUPMacros.h>
#endif

// IO
#if __has_include(<XCocoaUtilsPublic/XCUPIO.h>)
#import <XCocoaUtilsPublic/XCUPIO.h>
#endif

// UIKit
#if __has_include(<XCocoaUtilsPublic/XCUPUIKit.h>)
#import <XCocoaUtilsPublic/XCUPUIKit.h>
#endif

// Benchmark
#if __has_include(<XCocoaUtilsPublic/XCUPBenchmark.h>)
#import <XCocoaUtilsPublic/XCUPBenchmark.h>
#endif

// Compress
#if __has_include(<XCocoaUtilsPublic/NSData+XCUPGzip.h>)
#import <XCocoaUtilsPublic/NSData+XCUPGzip.h>
#endif

// C common utils
#if __has_include(<XCocoaUtilsPublic/CCommons.h>)
#import <XCocoaUtilsPublic/CCommon.h>
#endif

// Foundation extensions
#if __has_include(<XCocoaUtilsPublic/XCUFoundation.h>)
#import <XCocoaUtilsPublic/XCUFoundation.h>
#endif

//! Project version number for XCocoaUtilsPublic_iOS.
FOUNDATION_EXPORT double XCocoaUtilsPublic_iOSVersionNumber;

//! Project version string for XCocoaUtilsPublic_iOS.
FOUNDATION_EXPORT const unsigned char XCocoaUtilsPublic_iOSVersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <XCocoaUtilsPublic_iOS/PublicHeader.h>


#endif
