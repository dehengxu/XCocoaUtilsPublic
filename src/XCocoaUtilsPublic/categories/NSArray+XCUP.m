//
//  NSArray+XCUP.m
//  TaduUtils
//
//  Created by Xu Nicholas on 11-8-21.
//  Copyright 2011年 Deheng.Xu. All rights reserved.
//

#import "NSArray+XCUP.h"
#import <pthread.h>

@implementation NSArray (XCUP)


- (id)xcup_objectForKey:(id)key atKeyPath:(NSString *)keyPath
{
    return [self xcup_objectForKey:key atKeyPath:keyPath withCaseSensitive:YES];
}

- (id)xcup_objectForKey:(id)key atKeyPath:(NSString *)keyPath withCaseSensitive:(BOOL)caseSensitive
{
    for (NSObject * obj in self) {
        id value = [obj valueForKeyPath:keyPath];
        
        if (value && [value isEqual:key]) {
            return obj;
        }
        
        if ([key isKindOfClass:[NSString class]] && [value isKindOfClass:[NSString class]]) {
            if (caseSensitive && [value isEqualToString:key]) {
                return obj;
            }else if (!caseSensitive && [[value lowercaseString] isEqualToString:[key lowercaseString]]) {
                return obj;
            }
        }
    }
    return nil;
}

- (id)xcup_firstObject
{
    if (self.count == 0 || self.count >= NSNotFound) {
        return nil;
    }
    return [self objectAtIndex:0];
}

- (id)xcup_objectAfter:(id)anObject
{
    NSUInteger idx = [self indexOfObject:anObject];
    if (idx != NSNotFound && idx < [self count] - 1) {
        return [self objectAtIndex:idx + 1];
    }
    return nil;
}

- (id)xcup_objectBefore:(id)anObject
{
    NSUInteger idx = [self indexOfObject:anObject];
    if (idx != NSNotFound && idx > 0) {
        return [self objectAtIndex:idx - 1];
    }
    return nil;
}

- (NSArray *)xcup_getObjectsValueForKey:(NSString *)key
{
    NSMutableArray *rtn = [NSMutableArray arrayWithCapacity:self.count];
    for (NSObject *obj in self) {
        [rtn addObject:[obj valueForKey:key]];
    }
    return rtn;
}

- (BOOL)xcup_containsStringObject:(NSString *)anObject
{
    for (NSString *ele in self) {
        if ([ele isKindOfClass:[NSString class]]) {
            if ([ele isEqualToString:anObject]) {
                return YES;
            }
        }else {
            continue;
        }
    }
    return NO;
}

@end

@implementation NSMutableArray (Ext)

- (void)xcup_removeFirstObject
{
//    pthread_rwlock_t lock;
//    while(!pthread_rwlock_tryrdlock(&lock)) {
//        [NSThread sleepForTimeInterval:0.1f];
//    }
    [self removeObject:self.xcup_firstObject];
//    pthread_rwlock_unlock(&lock);
}

- (void)xcup_removeObjectForKey:(id)key atKeyPath:(NSString *)keyPath
{
    [self removeObject:[self xcup_objectForKey:key atKeyPath:keyPath]];
}

@end
