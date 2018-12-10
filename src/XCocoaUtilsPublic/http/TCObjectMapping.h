//
//  TCObjectMapping.h
//  TCFinance
//
//  Created by DehengXu on 15/11/18.
//  Copyright © 2015年 DehengXu. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "TCObjectMappingDelegate.h"

#define MappingClass(class_name) protocol class_name

@interface TCObjectMapping : NSObject<TCObjectMappingDelegate>

@end

@interface NSObject (JSONToObject)

- (nullable id)realValueForTypeEncode:(nonnull const char *)type fromString:(nonnull NSString *)string;
- (nullable NSDictionary *)dictionary;
- (nullable NSString *)fetchFirstProtocolName:(const char * _Nullable)attribute;

/**
 *  Inspect a class.
 *  Print a class property structure.
 *
 *  @param aClass
 */
- (void)inspect:(Class _Nullable)aClass;

@end

@interface NSString (JSONToObject)

- (nullable id)forkFromClass:(nonnull Class) aClass;

@end

@interface NSData (JSONToObject)

- (nullable id)forkFromClass:(nonnull Class) aClass;

@end

@interface NSArray (JSONToObject)

- (nullable id)forkFromClass:(nonnull Class) aClass;

@end

@interface NSDictionary (JSONToObject)

- (nullable id)forkFromClass:(nonnull Class) aClass;
- (void)flushObject:(nonnull id)object;

@end

