//
//  NSDictionary+HTTP.h
//  XCocoaUtilsPublic
//
//  Created by NicholasXu on 2018/12/21.
//  Copyright © 2018 Deheng.Xu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (HTTP)

- (NSDictionary *)xcup_parameters;

@end

@interface NSDictionary (HTTP)

- (NSString *)xcup_sortedParameterStringAscending:(BOOL)isAscending;
- (NSString *)xcup_sortedCaseInsensitiveParameterStringAscending:(BOOL)isAscending;
- (NSString *)xcup_sortedParameterString:(BOOL)isAscending caseInsensitive:(BOOL)isCaseInsensitive;

@end

NS_ASSUME_NONNULL_END
