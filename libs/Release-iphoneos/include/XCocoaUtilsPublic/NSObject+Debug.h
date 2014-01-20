//
//  NSObject+Debug.h
//  XUtils
//
//  Created by Deheng.Xu on 13-6-20.
//  Copyright (c) 2013年 Deheng.Xu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Debug)

+ (NSArray *)propertyList;

- (id)performSelector:(SEL)aSelector withObjects:(NSArray *)objects;

@end
