//
//  NSURL+Ext.m
//  XCocoaUtilsPublic
//
//  Created by Deheng.Xu on 13-10-23.
//  Copyright (c) 2013年 Deheng.Xu. All rights reserved.
//

#import "NSURL+XCUP.h"

@implementation NSURL (XCUP)

- (NSURL *)URLByTrimQuery
{
    return [NSURL URLWithString:[NSString stringWithFormat:@"%@://%@%@", self.scheme, self.host, self.path]];
}

@end
