//
//  DebugUtility.h
//  XUtilities
//
//  Created by Deheng.Xu on 13-5-3.
//  Copyright (c) 2013年 Nicholas.Xu. All rights reserved.
//

#if TARGET_OS_IPHONE

#import <UIKit/UIKit.h>

#else

#endif

extern void _objc_autoreleasePoolPrint(void);

/// Check key if null and return immediately
#define IsNullAndReturn(key) do { NSAssert(([key isKindOfClass:NSString.class] && key.length > 0) || key, @" "#key" is nil.");\
if (!(([key isKindOfClass:NSString.class] && key.length > 0) || key)) { return ; }\
}while(0)

/// Check key if null and return specified value
#define IsNullAndReturnValue(key, retv) do { NSAssert(([key isKindOfClass:NSString.class] && key.length > 0) || key, @" "#key" is nil, will return "#retv "");\
if (!(([key isKindOfClass:NSString.class] && key.length > 0) || key)) { return retv; }\
}while(0)

/*
 Try...Catch...  block macros. Indicate exception line number.
 */
#pragma mark - debug macros
#ifndef TRY_BEGIN
#define TRY_BEGIN   @try {
#endif

#ifndef TRY_CATCH
#define TRY_CATCH   }\
@catch (NSException *exception) {\
NSLog(@"%s:%d   %@:\n%@\n", __FUNCTION__, (__LINE__ - 1), [exception name], [exception reason]);\
[exception raise];\
}
#endif

/*
 Print current thread if main.
 */
#define PRINT_IS_MAINTHREAD()  NSLog(@"%@ isMainThread:%u addr:0x%x", __FUNCTION__, [NSThread isMainThread], (NSUInteger)[NSThread currentThread])

/*
 Print function name, object address and some args.
 */
#define LOG_FUNCTION_NAME(x,...) NSLog(@"%s addr:0x%x; %@", __FUNCTION__, (NSUInteger)self,##__VA_ARGS__)
#define XLog LOG_FUNCTION_NAME

#define xprint(fmt,...) printf(fmt,##__VA_ARGS__)

#define descriptionOfCocoaObject(obj) ((obj == nil) ? @""#obj "is null" : [NSString stringWithFormat:@"%@%@", @"\""#obj"\" is", [(obj) class]])

#import <Foundation/Foundation.h>

@interface DebugUtility : NSObject

@property (nonatomic, retain) NSMutableArray * foundSubviews;

+ (void)printArray:(NSArray *)anArray;
+ (void)printArray:(NSArray *)anArray ToDestinateString:(NSString **)aDestString;
+ (void)printDictionary:(NSDictionary *)anDictionary;
+ (void)printCollection:(id)anyCollection;

#if TARGET_OS_IPHONE
- (void)resetDataForTravelingSubviews;
- (void)travelSubviews:(UIView *) view;
- (void)findSubview:(UIView *)view WithName:(NSString *)name;
#endif

+ (NSString *)httpParamsStringByArray:(NSArray*)params;

@end
