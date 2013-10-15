//
//  DebugUtility.m
//  XUtilities
//
//  Created by Deheng.Xu on 13-5-3.
//  Copyright (c) 2013年 Nicholas.Xu. All rights reserved.
//

#import "NSString+Ext.h"
#import "DebugUtility.h"
#import "FunctionSet.h"

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

+ (void)printDictionary:(NSDictionary*)anDictionary
{
    NSArray *keys = [anDictionary allKeys];
    for (NSString *key in keys) {
        NSLog(@"key :%@; value:%@", key, [anDictionary valueForKey:key]);
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
        NSLog(@"%@:%@ %@ %@", tabString, [testView class], NSStringFromCGRect(testView.frame), NSStringFromBool(testView.clipsToBounds));
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
