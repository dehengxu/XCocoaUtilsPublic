//
//  NSObject+Debug.h
//  XUtils
//
//  Created by Deheng.Xu on 13-6-20.
//  Copyright (c) 2013年 Deheng.Xu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (XCUPDebug)

+ (NSArray *)propertyList;

- (id)performSelector:(SEL)aSelector withObjects:(NSArray *)objects;

- (NSTimeInterval)measureRunningBlock:(void(^)(void))aBlock times:(NSInteger)times;

/**
 Look up all properties' value.
 
 @return properties value string.
 */
- (NSString *)lookupDescription;

@end
