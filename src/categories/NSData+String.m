//
//  NSData+String.m
//  XUtils
//
//  Created by Xu Deheng on 12-5-10.
//  Copyright (c) 2012年 __MyCompany__ All rights reserved.
//

#import "NSData+String.h"
#import "NSObject+Ext.h"

@implementation NSData (String)

- (NSString *)utf8String
{
    return [self stringByEncoding:NSUTF8StringEncoding];
}

- (NSString *)stringByEncoding:(NSStringEncoding)encoding
{
    return [[[NSString alloc] initWithData:self encoding:encoding] autorelease];
}

@end
