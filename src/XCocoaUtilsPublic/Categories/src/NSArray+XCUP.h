//
//  NSArray+Utils.h
//  TaduUtils
//
//  Created by Xu Nicholas on 11-8-21.
//  Copyright 2011年 Deheng.Xu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (XCUP)

- (id)xcup_objectForKey:(id)key atKeyPath:(NSString *)keyPath;
- (id)xcup_objectForKey:(id)key atKeyPath:(NSString *)keyPath withCaseSensitive:(BOOL)caseSensitive;
- (id)xcup_firstObject;
- (id)xcup_objectAfter:(id)anObject;
- (id)xcup_objectBefore:(id)anObject;
- (NSArray *)xcup_getObjectsValueForKey:(NSString *)key;
- (BOOL)xcup_containsStringObject:(NSString *)anObject;

@end

@interface NSMutableArray (Ext)

- (void)xcup_removeFirstObject;
- (void)xcup_removeObjectForKey:(id)key atKeyPath:(NSString *)keyPath;

@end
