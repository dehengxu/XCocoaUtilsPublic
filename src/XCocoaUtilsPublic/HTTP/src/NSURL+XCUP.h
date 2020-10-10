//
//  NSURL+XCUP.h
//  XCocoaUtilsPublic
//
//  Created by Deheng.Xu on 13-10-23.
//  Copyright (c) 2013年 Deheng.Xu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSURL (XCUP)

- (NSURL *)xcup_URLByTrimQuery;
- (NSURL *)xcup_URLByAppendingQueries:(NSDictionary *)queries;
//- (NSURL *)xcup_URLByAppendingFragments:(NSArray *)fragments;

@end
