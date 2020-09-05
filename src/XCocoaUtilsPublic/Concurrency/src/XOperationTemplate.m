//
//  FLOperationTemplate.m
//  FeedLibrary
//
//  Created by Deheng.Xu on 13-3-28.
//  Copyright (c) 2013年 Nicholas.Xu. All rights reserved.
//

#import "XOperationTemplate.h"

@interface XOperationTemplate ()

@end

@implementation XOperationTemplate

- (id)init
{
    self = [super init];
    if (self) {
        _isReady = YES;
        _isConcurrent = NO;
    }
    return self;
}

#pragma mark - operation status

- (BOOL)isConcurrent
{
    return _isConcurrent;
}

- (BOOL)isReady
{
    return _isReady;
}

- (BOOL)isFinished
{
    return _isFinished;
}

- (BOOL)isCancelled
{
    return _isCanceled;
}

- (BOOL)isExecuting
{
    return _isExecuting;
}

- (void)makeCanceled:(BOOL)value
{
    [self willChangeValueForKey:@"isCanceled"];
    _isCanceled = value;
    [self didChangeValueForKey:@"isCanceled"];
    
    //[self makeKVOValueForKey:@{@"isCanceled":@(value)}];
}

- (void)makeExecuting:(BOOL)value
{
    [self willChangeValueForKey:@"isExecuting"];
    _isExecuting = value;
    [self didChangeValueForKey:@"isExecuting"];
    
    //[self makeKVOValueForKey:@{@"isExecuting":@(value)}];
}

- (void)makeFinished:(BOOL)value
{
    [self willChangeValueForKey:@"isFinished"];
    _isFinished = value;
    [self didChangeValueForKey:@"isFinished"];
    
    //[self makeKVOValueForKey:@{@"isFinished":@(value)}];
}

- (void)makeReady:(BOOL)value
{
    [self willChangeValueForKey:@"isReady"];
    _isReady = value;
    [self didChangeValueForKey:@"isReady"];
    
    //[self makeKVOValueForKey:@{@"isReady":@(value)}];
}

- (void)makeKVOValueForKey:(NSDictionary *)valueAndKey
{
    NSArray *keys = [valueAndKey allKeys];
    for (NSString *key in keys) {
        [self willChangeValueForKey:key];
        [self setValue:[valueAndKey valueForKey:key] forKey:key];
        [self didChangeValueForKey:key];
    }
}

@end
