//
//  NSInvocation+XCocoaUtils.m
//  XCocoaUtilsPublic
//
//  Created by NicholasXu on 2019/1/2.
//  Copyright © 2019 Deheng.Xu. All rights reserved.
//

#import "NSInvocation+XCocoaUtils.h"

@implementation NSInvocation (XCocoaUtils)

- (instancetype)xcu_configurate:(void (^)(NSInvocation * _Nonnull))configBlock
{
    if (configBlock) {
        configBlock(self);
    }
    return self;
}

- (instancetype)xcu_invokeWithTarget:(id)target
{
    [self invokeWithTarget:target];
    return self;
}

- (instancetype)xcu_invoke
{
    [self invoke];
    return self;
}

- (instancetype)xcu_returnValue:(void *)returnValue
{
    [self getReturnValue:returnValue];
    return self;
}

@end
