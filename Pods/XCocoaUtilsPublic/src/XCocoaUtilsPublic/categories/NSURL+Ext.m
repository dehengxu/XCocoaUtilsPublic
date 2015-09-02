//
//  NSURL+Ext.m
//  XCocoaUtilsPublic
//
//  Created by Deheng.Xu on 13-10-23.
//  Copyright (c) 2013年 Deheng.Xu. All rights reserved.
//

#import "NSURL+Ext.h"

@implementation NSURL (Ext)

- (NSURL *)URLByTrimQuery
{
    return [NSURL URLWithString:[NSString stringWithFormat:@"%@://%@%@", self.scheme, self.host, self.path]];
}

@end
