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

- (NSDictionary *)x_parameters;

@end

@interface NSDictionary (HTTP)

- (NSString *)x_sortedParameterStringAscending:(BOOL)isAscending;
- (NSString *)x_sortedCaseInsensitiveParameterStringAscending:(BOOL)isAscending;

@end

NS_ASSUME_NONNULL_END
