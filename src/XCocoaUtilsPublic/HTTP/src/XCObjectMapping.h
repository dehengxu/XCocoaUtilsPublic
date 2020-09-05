//
//  XCObjectMapping.h
//
//  Created by DehengXu on 15/11/18.
//  Copyright © 2015年 DehengXu. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "XCObjectMappingDelegate.h"

#define MappingClass(class_name) protocol class_name

@interface XCObjectMapping : NSObject<XCObjectMappingDelegate>

@end

@interface NSObject (JSONToObject)

- (nullable id)realValueForTypeEncode:(nonnull const char *)type fromString:(nonnull NSString *)string;
- (nullable NSDictionary *)dictionary;
- (nullable NSString *)fetchFirstProtocolName:(const char * _Nullable)attribute;
- (NSDictionary *_Nullable)propertiesMapping;

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

