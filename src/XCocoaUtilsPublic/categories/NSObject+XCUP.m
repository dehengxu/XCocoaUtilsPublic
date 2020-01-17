//
//  NSObject+NSObject_Utils.m
//  XUtils
//
//  Created by Xu Deheng on 12-3-25.
//  Copyright (c) 2012年 Deheng.Xu. All rights reserved.
//

#import "NSObject+XCUP.h"
#import <objc/runtime.h>

#import "XCUPMacros.h"

@implementation NSObject (XCUP)

+ (NSString *)nameOfClass:(Class)cls
{
    return [NSString stringWithCString:class_getName(cls) encoding:NSUTF8StringEncoding];
}

+ (NSString *)name
{
    return [NSString stringWithCString:class_getName(self.class) encoding:NSUTF8StringEncoding];
}

+ (NSString *)className
{
    return [NSString stringWithCString:class_getName(self.class) encoding:NSUTF8StringEncoding];
}

- (NSString *)dispatchQueueLabel
{
    return [NSString stringWithCString:dispatch_queue_get_label(dispatch_get_current_queue()) encoding:NSUTF8StringEncoding];
}

- (id)XAutorelease
{
#if ARC_ENABLED
    return self;
#else
    return [self autorelease];
#endif
}

- (void)XRelease
{
#if ARC_ENABLED
    //Do nothing.
    return;
#else
    [self release];
#endif
}

- (id)XRetain
{
#if ARC_ENABLED
    return self;
#else
    return [self retain];
#endif
}

@end
