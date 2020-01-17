//
//  NSData+String.m
//  XUtils
//
//  Created by Xu Deheng on 12-5-10.
//  Copyright (c) 2012年 __MyCompany__ All rights reserved.
//

#import "NSData+String.h"
#import "NSObject+XCUP.h"

@implementation NSData (XCUString)

- (NSString *)xcu_utf8String
{
    return [self xcu_stringByEncoding:NSUTF8StringEncoding];
}

- (NSString *)xcu_stringByEncoding:(NSStringEncoding)encoding
{
    return [[[NSString alloc] initWithData:self encoding:encoding] XAutorelease];
}

@end
