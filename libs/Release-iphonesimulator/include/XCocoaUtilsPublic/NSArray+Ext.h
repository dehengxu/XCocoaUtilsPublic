//
//  NSArray+Utils.h
//  TaduUtils
//
//  Created by Xu Nicholas on 11-8-21.
//  Copyright 2011年 Deheng.Xu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (Ext)

- (id)objectForKey:(id)key atKeyPath:(NSString *)keyPath;
- (id)objectForKey:(id)key atKeyPath:(NSString *)keyPath withCaseSensitive:(BOOL)caseSensitive;
- (id)firstObject;
- (id)objectAfter:(id)anObject;
- (id)objectBefore:(id)anObject;
- (id)mutableArray;
- (NSArray *)getObjectsValueForKey:(NSString *)key;

@end

@interface NSMutableArray (Ext)

- (void)removeObjectForKey:(id)key atKeyPath:(NSString *)keyPath;

@end