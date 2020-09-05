//
//  NSURL+Test.m
//  XUtils
//
//  Created by Xu Deheng on 12-5-11.
//  Copyright (c) 2012年 __MyCompany__ All rights reserved.
//

#import "NSURL+Test.h"

@implementation NSURL (Test)
- (void)printURLAllParts
{
    NSMutableString *str_ = [NSMutableString stringWithCapacity:512];
    
    [str_ appendFormat:@"baseURL    :%@\n", self.baseURL.absoluteString];
    [str_ appendFormat:@"scheme     :%@\n", self.scheme];
    [str_ appendFormat:@"host       :%@\n", self.host];
    [str_ appendFormat:@"port       :%@\n", self.port];
    [str_ appendFormat:@"query      :%@\n", self.query];
    [str_ appendFormat:@"user       :%@\n", self.user];
    [str_ appendFormat:@"password   :%@\n", self.password];
    [str_ appendFormat:@"stdURL     :%@\n", self.standardizedURL.absoluteString];
    [str_ appendFormat:@"path       :%@\n", self.path];
    [str_ appendFormat:@"resourceSpecifier  :%@\n", self.resourceSpecifier];
    [str_ appendFormat:@"relativePath       :%@\n", self.relativePath];
    [str_ appendFormat:@"relativeString     :%@\n", self.relativeString];

    NSLog(@"%s\n%@", __func__, str_);
}
@end
