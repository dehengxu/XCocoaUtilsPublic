//
//  NSInvocation+XCocoaUtils.h
//  XCocoaUtilsPublic
//
//  Created by NicholasXu on 2019/1/2.
//  Copyright © 2019 Deheng.Xu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSInvocation (XCocoaUtils)

- (instancetype)xcu_configurate:(void(^)(NSInvocation *invoc))configBlock;
- (instancetype)xcu_invokeWithTarget:(id)target;
- (instancetype)xcu_invoke;
- (instancetype)xcu_returnValue:(void *)returnValue;

@end

NS_ASSUME_NONNULL_END
