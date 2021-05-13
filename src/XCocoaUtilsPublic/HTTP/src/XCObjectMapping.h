//
//  XCObjectMapping.h
//
//  Created by DehengXu on 15/11/18.
//  Copyright © 2015年 DehengXu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/message.h>

#import "XCObjectMappingDelegate.h"

#define MappingClass(class_name) protocol class_name

//struct nx_meta_cache {
//	struct nx_meta_cache * _Nullable superClass;
//	NSMutableArray* _Nullable propertyList;
//	objc_property_t _Nullable * _Nullable properties;
//	Ivar _Nullable * _Nullable ivars;
//	int property_count;
//	int ivar_count;
//	Class _Nonnull theClass;
//};

@class nx_meta_cache;
NSMutableDictionary* _Nonnull nx_metaCache();
nx_meta_cache * _Nonnull nx_lookupMetaCache(Class _Nonnull aClass);

NS_ASSUME_NONNULL_BEGIN

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

NS_ASSUME_NONNULL_END
