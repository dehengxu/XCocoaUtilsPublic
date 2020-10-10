//
//  NSDictionary+HTTP.m
//  XCocoaUtilsPublic
//
//  Created by NicholasXu on 2018/12/21.
//  Copyright © 2018 Deheng.Xu. All rights reserved.
//

#import "NSDictionary+HTTP.h"

@implementation NSString (HTTP)

- (NSDictionary *)xcup_parameters
{
    NSMutableDictionary *tmp = [NSMutableDictionary new];
    NSArray *kvpairs = [self componentsSeparatedByString:@"&"];
    for (NSString *paire in kvpairs) {
        NSArray *paires = [paire componentsSeparatedByString:@"="];
        if (paires.count) {
            [tmp setObject:(paires.count > 1 ? paires[1] : @"") forKey:paires[0]];
        }
    }
    
    return [tmp copy];
}

@end

@implementation NSDictionary (HTTP)

- (NSString *)xcup_sortedParameterStringAscending:(BOOL)isAscending
{
    return [self xcup_sortedParameterString:isAscending caseInsensitive:NO];
}

- (NSString *)xcup_sortedCaseInsensitiveParameterStringAscending:(BOOL)isAscending
{
    return [self xcup_sortedParameterString:isAscending caseInsensitive:YES];
}

- (NSString *)xcup_sortedParameterString:(BOOL)isAscending caseInsensitive:(BOOL)isCaseInsensitive
{
    NSArray *sorted = [self.allKeys sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        NSComparisonResult result = NSOrderedSame;
        
        if (isCaseInsensitive) {
            result = [[obj1 description] caseInsensitiveCompare:[obj2 description]];
        }else {
            result = [[obj1 description] compare:[obj2 description]];
        }
        
        if (!isAscending) {
            if (result == NSOrderedAscending) {
                return NSOrderedDescending;
            }else if (result == NSOrderedDescending) {
                return NSOrderedAscending;
            }else {
                return result;
            }
        }
        return result;
    }];
    
    NSMutableString *buff = nil;
	if (!buff) { buff = [NSMutableString new]; }

    BOOL began = NO;
    for (NSString *key in sorted) {
        if (began) {
            [buff appendString:@"&"];
        }
        began = YES;
        [buff appendFormat:@"%@=%@", key, [self objectForKey:key]];
    }
    
    return [buff copy];
}

@end
