//
//  NSURL+XCUP.m
//  XCocoaUtilsPublic
//
//  Created by Deheng.Xu on 13-10-23.
//  Copyright (c) 2013年 Deheng.Xu. All rights reserved.
//

#import "NSURL+XCUP.h"
#import "NSString+URI.h"

@implementation NSURL (XCUP)

- (NSURL *)xcup_URLByTrimQuery
{
    return [[NSString stringWithFormat:@"%@://%@%@", self.scheme, self.host, self.path] xcup_URL];
}

- (NSURL *)xcup_URLByAppendingQueries:(NSDictionary *)queries
{
    NSMutableString *urlWithOutQuery = self.xcup_URLByTrimQuery.absoluteString.mutableCopy;
    
    //Pickup queries of URL
    NSMutableDictionary *totalQueries = @{}.mutableCopy;
    if (self.query.length > 0) {
        NSArray *params = [self.query componentsSeparatedByString:@"&"];
        for (NSString *param in params) {
            NSArray *keyvalue = [param componentsSeparatedByString:@"="];
            if (keyvalue.count < 2) {
                continue;
            }
            if (!keyvalue[0] || !keyvalue[1]) {
                continue;
            }
            totalQueries[keyvalue[0]] = keyvalue[1];
        }
    }
    
    //Merge all queries, avoid duplicate
    [totalQueries addEntriesFromDictionary:queries];
    
    BOOL isNone = YES;
    for (NSString *key in totalQueries) {
        if (isNone) {
            isNone = NO;
            [urlWithOutQuery appendString:@"?"];
        }else {
            [urlWithOutQuery appendString:@"&"];
        }
        NSString *value = totalQueries[key];
        [urlWithOutQuery appendFormat:@"%@=%@", key, value];
    }
    
    return [NSURL URLWithString:urlWithOutQuery.copy];
}

//- (NSURL *)xcup_URLByAppendingFragments:(NSArray *)fragments {
//    NSMutableString *urlWithOutQuery = self.xcup_URLByTrimQuery.absoluteString.mutableCopy;
//    
//    if (self.fragment.length > 0) {
//        
//    }
//    
//}

@end
