//
//  XCObjectMapping.h
//
//  Created by DehengXu on 15/11/18.
//  Copyright © 2015年 DehengXu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/message.h>

#import "XCObjectMappingDelegate.h"

#pragma mark - C++ world

#ifdef __cplusplus

extern "C++" {
    namespace nxcxx {

        namespace objc {

            template<typename T>
            void nx_copyClassMetaInfoList(Class aClass, unsigned int *count, T**dest);

            template<typename T>
            static inline void nx_setIvarPrimitiveValue(id object, Ivar ivar, T value) {
                ptrdiff_t offset = ivar_getOffset(ivar);
                void *p = (__bridge void*)object;
                *(T*)((char*)p + offset) = value;
            }

        }//namespace objc

    }//namespace nxcxx
}

#endif

#pragma mark - C world

#if defined(__cplusplus)
extern "C" {
#endif

    extern CFDictionaryKeyCallBacks kNX_CStringDictionaryKeyCallBacks;
    extern CFDictionaryValueCallBacks kNX_CStringDictionaryValueCallBacks;

#define MappingClass(class_name) protocol class_name

    @class nx_meta_cache;
    @interface nx_meta_cache : NSObject
    {
    @public
        Class _Nonnull theClass;
        nx_meta_cache * _Nullable superClass;

        NSMutableArray* _Nullable propertyNames;
        unsigned int property_count;
        objc_property_t _Nonnull * _Nullable properties;

        unsigned int ivar_count;
        Ivar _Nullable * _Nullable ivars;

        CFMutableDictionaryRef propertyAndIvars;
        //NSMutableDictionary *propertyAndIvars;
    }
    @end

    @interface nx_meta_ivar_info : NSObject
    {
        @public
        Ivar _ivar;
        Class __strong _ivarClass;
        Class __strong _generic;
        char* _ivarName;
        char* _typeEncoding;
        char* _propNameCString;
        ptrdiff_t _offset;
    }
    @property (nonatomic, assign) Ivar _Nullable ivar;
    @property (nonatomic, strong) Class _Nullable ivarClass;
    @property (nonatomic, strong) Class _Nullable generic;
    @property (nonatomic, readonly) char* _Nullable ivarName;
    @property (nonatomic, readonly) char* _Nullable typeEncoding;
    @property (nonatomic, readonly) char* _Nullable propNameCString;
    @property (nonatomic, assign) ptrdiff_t offset;
    @end

    nx_meta_cache *_Nonnull nx_buildMetaCache(Class _Nonnull aClass);
    nx_meta_cache * _Nonnull nx_lookupMetaCache(Class _Nonnull aClass);
    Ivar _Nullable nx_getIvarByPropertyName(Class _Nonnull aClass, const char* _Nonnull propName);
    void nx_setIvarByPropertyName();

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

#if defined(__cplusplus)
}
#endif
