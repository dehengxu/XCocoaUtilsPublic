//
//  XCObjectMapping.h
//
//  Created by DehengXu on 15/11/18.
//  Copyright © 2015年 DehengXu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/message.h>

#pragma mark - XCObjectMapping definition

@protocol XCObjectMapping

@optional
+ (NSDictionary *_Nullable)propertiesMapping;

@end

#pragma mark - C++ world

#pragma mark - C world

#if defined(__cplusplus)
extern "C" {
#endif

extern CFDictionaryKeyCallBacks kNX_CStringDictionaryKeyCallBacks;
extern CFDictionaryValueCallBacks kNX_CStringDictionaryValueCallBacks;

#define MappingClass(class_name) protocol class_name

@interface nx_meta_cache : NSObject
{
    @public
    Class _Nonnull _theClass;
    nx_meta_cache *_Nullable _superClass;

    NSMutableArray *_Nullable _propertyNames;
    objc_property_t _Nonnull *_Nullable _properties;

    //_Alignas(void*)
	unsigned int _ivarCount;
	//_Alignas(void*)
	unsigned int _propertyCount;
    Ivar _Nullable *_Nullable _ivars;

    NSMutableDictionary *_propertyAndIvars;
	NSDictionary *_mappedProp;
}
@end

@interface nx_meta_ivar_descriptor : NSObject
{
    @public
    Ivar _ivar;
    Class __strong _ivarClass;
    Class __strong _generic;
    char *_ivarName;
    char *_typeEncoding;
    char *_propNameCString;
    ptrdiff_t _offset;
}
@property (nonatomic, assign) Ivar _Nullable ivar;
@property (nonatomic, strong) Class _Nullable ivarClass;
@property (nonatomic, strong) Class _Nullable generic;
@property (nonatomic, assign) char *_Nullable ivarName;
@property (nonatomic, readonly) char *_Nullable typeEncoding;
@property (nonatomic, readonly) char *_Nullable propNameCString;
@property (nonatomic, assign) ptrdiff_t offset;

@end

nx_meta_cache * _Nonnull nx_buildMetaCache(Class _Nonnull aClass);
nx_meta_cache * _Nonnull nx_lookupMetaCache(Class _Nonnull aClass);
Ivar _Nullable nx_getIvarByPropertyName(Class _Nonnull aClass, const char *_Nonnull propName);
void nx_setIvarByPropertyName();

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (JSONToObject)

- (nullable id)realValueForTypeEncode:(nonnull const char *)type fromString:(nonnull NSString *)string;
- (nullable NSDictionary *)dictionary;
- (nullable NSString *)fetchFirstProtocolName:(const char *_Nullable)attribute;
- (NSDictionary *_Nullable)propertiesMapping;

@end

@interface NSString (JSONToObject)

- (nullable id)forkFromClass:(nonnull Class)aClass;

@end

@interface NSData (JSONToObject)

- (nullable id)forkFromClass:(nonnull Class)aClass;

@end

@interface NSArray (JSONToObject)

- (nullable id)forkFromClass:(nonnull Class)aClass;

@end

@interface NSDictionary (JSONToObject)

- (nullable id)forkFromClass:(nonnull Class)aClass;
- (void)flushObject:(nonnull id)object;

@end

NS_ASSUME_NONNULL_END

#if defined(__cplusplus)
}
#endif
