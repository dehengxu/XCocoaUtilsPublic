//
//  DebugUtility.m
//  XUtilities
//
//  Created by Deheng.Xu on 13-5-3.
//  Copyright (c) 2013年 Nicholas.Xu. All rights reserved.
//

#import "XCUFoundation.h"
#import "DebugUtility.h"
#import "memory_macros.h"
#if __has_include("RegexKitLite.h")
#import "RegexKitLite.h"
#endif
#import "NameValuePaire.h"
#import <mach/mach.h>

/// Ref: https://stackoverflow.com/questions/787160/programmatically-retrieve-memory-usage-on-iphone
NSUInteger reportMemory(void)
{
    struct task_basic_info info;
    mach_msg_type_number_t size = TASK_BASIC_INFO_COUNT;
    kern_return_t kerr = task_info(mach_task_self(), TASK_BASIC_INFO, (task_info_t)&info, &size);
    if (kerr == KERN_SUCCESS) {
        printf(">>------------------------------->\n");
        printf("Memory in use (in bytes): %lu\n", info.resident_size);
        printf("Memory in use (in MiB): %f\n", ((CGFloat)info.resident_size / 1048576));
        printf("\n");
        return (NSUInteger)info.resident_size;
    } else {
        printf("Error with task_info(): %s\n", mach_error_string(kerr));
        return NSUIntegerMax;
    }
}

@interface DebugUtility (private)


@end

@implementation DebugUtility

+ (void)printArray:(NSArray *)anArray
{
    if (!anArray) {
        NSLog(@"%s print array is null!", __FUNCTION__);
        return;
    }
    int i = 0;
    for (NSObject * obj in anArray) {
        NSLog(@"Class:%@; index:%d; value:[%@]", [obj classForCoder], i, obj);
        i ++;
    }
}

+ (void)printArray:(NSArray *)anArray ToDestinateString:(NSString **)aDestString
{
    NSMutableString * str = [NSMutableString string];
    int  i = 0;
    for (NSObject * obj in anArray) {
        [str appendFormat:@"Class:%@; index:%d; value:%@\n", [obj classForCoder], i, obj];
        i ++;
    }
    (*aDestString) = str;
}

+ (void)printDictionary:(NSDictionary *)anDictionary
{
    NSArray *keys = [anDictionary allKeys];
    for (NSString *key in keys) {
        NSLog(@"key :%@; value:%@", key, [anDictionary valueForKey:key]);
    }
}

+ (void)printCollection:(id)anyCollection
{
    if (nil == anyCollection) { NSLog(@"printCollection: %@", anyCollection); }
    
    if ([anyCollection isKindOfClass:[NSArray class]]) {
        [self printArray:anyCollection];
    }else if ([anyCollection isKindOfClass:[NSDictionary class]]) {
        [self printDictionary:anyCollection];
    }else if ([anyCollection isKindOfClass:[NSSet class]]) {
        
    }
}

#if TARGET_OS_IPHONE

/////////////////// 打印视图层级结构
int level = -1;
NSMutableString * tabString = nil;

- (void)resetDataForTravelingSubviews
{
    SafeRelease(tabString);
    SafeRelease(_foundSubviews);
    tabString = [NSMutableString new];
    _foundSubviews = [NSMutableArray new];
    level = -1;
}

- (void)travelSubviews:(UIView *) view {
    level ++;
    [tabString appendString:@" "];
    UIView * testView = nil;
    for (int i = 0; i < [[view subviews] count]; i++) {
        testView = [[view subviews] objectAtIndex:i];
        NSLog(@"%@:%@ %@ %@", tabString, [testView class], NSStringFromCGRect(testView.frame), xcu_NSStringFromBool(testView.clipsToBounds));
        [self travelSubviews:testView];
    }
    level--;
    if (level > 0) {
        [tabString deleteCharactersInRange:NSMakeRange(0, 1)];
    }
}

- (void)findSubview:(UIView *)view WithName:(NSString *)name
{
    level ++;
    //if (level > 0) [tabString appendString:@" "];
    UIView * testView = nil;
    for (int i = 0; i < [[view subviews] count]; i++) {
        testView = [[view subviews] objectAtIndex:i];
        if ([NSStringFromClass([testView class]) hasPrefix:name]) {
            [_foundSubviews addObject:testView];
        }
        //NSLog(@"%@:%@ %@;  match:%@", tabString, NSStringFromClass([testView class]), NSStringFromCGRect(testView.frame), NSStringFromBool([NSStringFromClass([testView class]) hasPrefix:name]));
        [self findSubview:testView WithName:name];
    }
    level--;
    //if (level > 0) {
    //    [tabString deleteCharactersInRange:NSMakeRange(0, 1)];
    //}
}

#endif

+ (NSString *)httpParamsStringByArray:(NSArray *)params
{
#ifdef _REGEXKITLITE_H_
    NSMutableArray *comp = [NSMutableArray arrayWithCapacity:12];
    for (NameValuePaire *param__ in params) {
        [comp addObject:[NSString stringWithFormat:@"%@=%@", param__.name, param__.value]];
    }
    NSString *rtn = [comp componentsJoinedByString:@"&"];
    return rtn;
#else
    NSLog(@"Warnning No _REGEXKITLITE_H_  MACRO!");
    return nil;
#endif
}

@end
