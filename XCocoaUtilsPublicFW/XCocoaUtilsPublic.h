//
//  XCocoaUtilsPublic_iOS.h
//  XCocoaUtilsPublic iOS
//
//  Created by Deheng Xu on 2019/2/27.
//  Copyright © 2019 Deheng.Xu. All rights reserved.
//

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
//#import <XCocoaUtilsPublic/XOperationTemplate.h>
#endif

// Http
#if __has_include(<XCocoaUtilsPublic/XCUPHttp.h>)
#import <XCocoaUtilsPublic/XCUPHttp.h>

//#import <XCocoaUtilsPublic/NSData+Base64.h>
//#import <XCocoaUtilsPublic/NSObject+PropertyToURLParams.h>
//#import <XCocoaUtilsPublic/XCObjectMappingDelegate.h>
//#import <XCocoaUtilsPublic/NSString+URI.h>
//#import <XCocoaUtilsPublic/NSDictionary+HTTP.h>
//#import <XCocoaUtilsPublic/NameValuePaire.h>
//#import <XCocoaUtilsPublic/XCObjectMapping.h>
#endif

//Debug
#if __has_include(<XCocoaUtilsPublic/XCUPDebug.h>)
#import <XCocoaUtilsPublic/XCUPDebug.h>

//#import <XCocoaUtilsPublic/DebugUtility.h>
//#import <XCocoaUtilsPublic/NSURL+Test.h>
#endif

// C macros
#if __has_include(<XCocoaUtilsPublic/XCUPMacros.h>)
#import <XCocoaUtilsPublic/XCUPMacros.h>

//#import <XCocoaUtilsPublic/memory_macros.h>
//#import <XCocoaUtilsPublic/singletone.h>
//#import <XCocoaUtilsPublic/UIKit_macros.h>
//#import <XCocoaUtilsPublic/web_macros.h>
//#import <XCocoaUtilsPublic/CF_macros.h>
#endif

// IO
#if __has_include(<XCocoaUtilsPublic/XCUPIO.h>)
#import <XCocoaUtilsPublic/XCUPIO.h>

//#import <XCocoaUtilsPublic/FileIOHelper.h>
//#import <XCocoaUtilsPublic/DefaultSettings.h>
#endif

// UIKit
#if __has_include(<XCocoaUtilsPublic/XCUPUIKit.h>)
#import <XCocoaUtilsPublic/XCUPUIKit.h>

//#import <XCocoaUtilsPublic/XCUPBlockAlertView.h>
//#import <XCocoaUtilsPublic/XCUPCGFunctions.h>
#endif

// Benchmark
#if __has_include(<XCocoaUtilsPublic/XCUPBenchmark.h>)
#import <XCocoaUtilsPublic/XCUPBenchmark.h>
//#import <XCocoaUtilsPublic/BenchMark.h>
//#import <XCocoaUtilsPublic/cbench_mark.h>
#endif

//! Project version number for XCocoaUtilsPublic_iOS.
FOUNDATION_EXPORT double XCocoaUtilsPublic_iOSVersionNumber;

//! Project version string for XCocoaUtilsPublic_iOS.
FOUNDATION_EXPORT const unsigned char XCocoaUtilsPublic_iOSVersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <XCocoaUtilsPublic_iOS/PublicHeader.h>



