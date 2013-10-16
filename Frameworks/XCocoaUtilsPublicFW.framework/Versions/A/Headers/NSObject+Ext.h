//
//  NSObject+NSObject_Utils.h
//  XUtils
//
//  Created by Xu Deheng on 12-3-25.
//  Copyright (c) 2012年 Deheng.Xu. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifndef ARC_ENABLED
#define ARC_ENABLED  __has_feature(objc_arc)
#endif

#ifndef ARC_DISABLED
#define ARC_DISABLED  !__has_feature(objc_arc)
#endif

@interface NSObject (Ext)
+ (NSString *)nameOfClass:(Class)cls;
+ (NSString *)name;
+ (NSString *)className;

- (NSString *)dispatchQueueLabel;

//Methods adapt for ARC and MRC
- (id)XAutorelease;
- (void)XRelease;
- (id)XRetain;

@end
