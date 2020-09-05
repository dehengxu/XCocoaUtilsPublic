//
//  NSObject+Debug.m
//  XUtils
//
//  Created by Deheng.Xu on 13-6-20.
//  Copyright (c) 2013年 Deheng.Xu. All rights reserved.
//

#import "NSObject+XCUPDebug.h"

#import <objc/runtime.h>

#import "XCUPMacros.h"
#import "NSObject+XCUP.h"

@implementation NSObject (XCUPDebug)

+ (NSArray *)propertyList
{
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:12];
    
    unsigned int outCount;
    objc_property_t * props = class_copyPropertyList(self, &outCount);
    
    int i = 0;
    NSString *p = nil;
    for (i = 0; i < outCount; i++) {
        objc_property_t prop = props[i];
        p = [NSString stringWithCString:property_getName(prop) encoding:NSUTF8StringEncoding];
        [array addObject:p];
    }
    
    return array;
}

- (id)performSelector:(SEL)aSelector withObjects:(NSArray *)objects
{
    NSInvocation *invoc = [NSInvocation invocationWithMethodSignature:[self methodSignatureForSelector:aSelector]];
    invoc.selector = aSelector;
    invoc.target = self;

    NSObject *obj = nil;
    for (uint32_t i = 0; i < objects.count; i++) {
        obj = [objects objectAtIndex:i];
        [invoc setArgument:&obj atIndex:2 + i];
        obj = nil;
    }
    [invoc invoke];
    
    const char *typeChar = [[invoc methodSignature] methodReturnType];
    
    if (typeChar[0] == '@' || typeChar[0] == '#') {
        //Return an object.
        id rtnValue = nil;
        [invoc getReturnValue:&rtnValue];
        return rtnValue;
    }else {
        //Return a simple type.
        //id rtnValue = nil;
        //[invoc getReturnValue:&rtnValue];
        NSLog(@"Return value only support object.");
        NSAssert(false, @"Return value only support object.");
        return nil;
    }
}

- (NSTimeInterval)measureRunningBlock:(void(^)(void))aBlock times:(NSInteger)times
{
    NSAssert(aBlock != NULL, @"aBlock must be non-null.");

    NSDate *startDate = [NSDate date];
    for (int i = 0; i < times; i++) {
        aBlock();
    }
    NSTimeInterval time = [[NSDate date] timeIntervalSinceDate:startDate];
    NSLog(@"Running %lu times, cost time :%f(s)", times, time);
    return time;
}

- (NSString *)lookupDescription
{
    NSMutableString *rtn = [NSMutableString stringWithFormat:@""];
    unsigned int propertyCount = 0;
    objc_property_t *property_list = class_copyPropertyList([self class], &propertyCount);
    if (propertyCount) {
        for (unsigned int c = 0; c < propertyCount; c++) {
            //get name
            const char *name = property_getName(property_list[c]);
            if (c > 0) {
                [rtn appendFormat:@","];
            }else {
                [rtn appendFormat:@"%@\\@%lu [", [self classForCoder], (unsigned long)self];
            }
            
            [rtn appendFormat:@"%s=%@", name, [self valueForKeyPath:[NSString stringWithFormat:@"%s", name]]];
        }
    }
    [rtn appendFormat:@"]"];
    
    return [NSString stringWithString:rtn];
}

@end
