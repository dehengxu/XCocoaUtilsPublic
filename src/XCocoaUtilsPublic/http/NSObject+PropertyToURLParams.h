//
//  NSObject+PropertyToURLParams.h
//  TestAPI
//
//  Created by DehengXu on 14-5-16.
//  Copyright (c) 2014年 Deheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (PropertyToURLParams)

/**
 Get a url params string composed by object's properties.
 
 @return a params string.
 */
- (NSString *)URLParams;

/**
 Get a url params string composed by object's properties\
 without specified exclude properties.
 
 @param properties exclude properties.
 
 @return a params string.
 */
- (NSString *)URLParamsExcludeProperties:(NSArray*)properties;

@end
