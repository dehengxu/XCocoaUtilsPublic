//
//  NSObject+PropertyToURLParams.m
//  TestAPI
//
//  Created by DehengXu on 14-5-16.
//  Copyright (c) 2014年 Deheng. All rights reserved.
//
#import <objc/runtime.h>
#import "NSObject+PropertyToURLParams.h"
#import "NSArray+XCUP.h"

@implementation NSObject (PropertyToURLParams)

- (NSString *)URLParams
{
    return [self URLParamsExcludeProperties:nil];
}

- (NSString *)URLParamsExcludeProperties:(NSArray *)properties
{
    NSMutableString *rtn = [NSMutableString stringWithFormat:@""];
    unsigned int propertyCount = 0;
    objc_property_t *property_list = class_copyPropertyList([self class], &propertyCount);
    if (propertyCount) {
        for (unsigned int c = 0; c < propertyCount; c++) {
            //get name
            const char *name = property_getName(property_list[c]);
            //exclude list
            if ([properties xcup_containsStringObject:[NSString stringWithFormat:@"%s", name]]) {
                continue;
            }
            
            if (c > 0) {
                [rtn appendFormat:@"&"];
            }
            if ([self valueForKeyPath:[NSString stringWithFormat:@"%s", name]]) {
                [rtn appendFormat:@"%s=%@", name, [self valueForKeyPath:[NSString stringWithFormat:@"%s", name]]];
            }
        }
    }
    
    return [NSString stringWithString:rtn];
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
                [rtn appendFormat:@"%@ \\ @%lu [", [self classForCoder], (unsigned long)self];
            }
            
            [rtn appendFormat:@"%s=%@", name, [self valueForKeyPath:[NSString stringWithFormat:@"%s", name]]];
        }
    }
    [rtn appendFormat:@"]"];
    
    return [NSString stringWithString:rtn];
}

@end
