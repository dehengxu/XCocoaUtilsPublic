//
//  XCObjectMapping.m
//
//  Created by DehengXu on 15/11/18.
//  Copyright © 2015年 DehengXu. All rights reserved.
//

#import "XCObjectMapping.h"
#import <objc/runtime.h>
#import <objc/objc.h>
#import <objc/message.h>

NSString *const XCObjectMappingJSONFormatException = @"XCObjectMapping: JSON content type exception.";

#pragma mark - Class meta information

#define CStringSetter(ivarName)  if (ivarName) {\
int nstrlen = strlen(ivarName) + 1;\
_##ivarName = (char*)malloc(nstrlen);\
memcpy(_##ivarName, ivarName, nstrlen);\
}else if (_##ivarName) {\
free(_##ivarName);\
_##ivarName = NULL;\
}

@implementation nx_meta_cache : NSObject

- (void)dealloc {
    free(ivars);
    free(properties);
}

@end

@implementation nx_meta_ivar_info

@synthesize ivarClass = _ivarClass;
@synthesize ivarName = _ivarName;
@synthesize typeEncoding = _typeEncoding;
@synthesize propNameCString = _propNameCString;

- (void)setIvarName:(char *)ivarName {
    CStringSetter(ivarName);
}

- (void)setTypeEncoding:(char * _Nullable)typeEncoding {
    CStringSetter(typeEncoding);
}

- (void)setPropNameCString:(char *)propNameCString {
    CStringSetter(propNameCString);
}

- (void)dealloc {
    NSLog(@"%s", __func__);
    if (_ivarName) {
        free(_ivarName);
    }
    if (_typeEncoding) {
        free(_typeEncoding);
    }
    if (_propNameCString) {
        free(_propNameCString);
    }
}

@end

static NSMutableDictionary *metaCache = nil;
static SEL mappingSelector = nil;

NSString* nx_fetchFirstProtocolName(const char* attribute) {
    char * pbegin = (char*)strstr(attribute, "<");
    if (pbegin == NULL) return nil;

    char *pend = (char*)strstr(attribute, ">");
    if (pend == NULL) return nil;

    unsigned long length = strlen(pbegin) - strlen(pend) - 1;
    char substr[length + 1];
    __unused char *sub = strncpy(substr, pbegin + 1, length);
    substr[length] = '\0';
    if (substr == NULL) {
        return nil;
    }

    NSString* ret = [NSString stringWithCString:substr encoding:NSUTF8StringEncoding];
    return ret;
}

Class nx_fetchFirstProtocol(const char* attribute) {
    NSString* ret = nx_fetchFirstProtocolName(attribute);
    if (!ret) return nil;
    Class aClass = NSClassFromString(ret);
    return aClass;
}

Class nx_ivarClass(Ivar ivar) {
    if (!ivar) return nil;
    const char* typeEncode = ivar_getTypeEncoding(ivar);
    size_t size = strlen(typeEncode);
    if (size < 4) return nil;
    char name[size - 2 + 1];// @""
    memcpy(name, typeEncode+2, size - 3 + 1);
    name[size - 3] = '\0';
    Class aClass = objc_getClass(name);
    return aClass;
}

Ivar nx_getIvarByPropertyName(Class aClass, const char* propName) {
    int len = strlen(propName);
    if (len < 1) {
        assert(0);
        return NULL;
    }
    char ivarName[len + 2];
    ivarName[0] = '_';
    ivarName[len + 1] = 0;
    memcpy(ivarName+1, propName, len);
    Ivar ivar = class_getInstanceVariable(aClass, ivarName);
    return ivar;
}

static unsigned long c_hash(const void* str) {
    // this does not need to be a great hash
    // it is just used to reduce the number of strcmp() calls
    // of existing images when loading a new image
    uint32_t h = 0;
    for (const char* s=(const char*)str; *s != '\0'; ++s)
        h = h*5 + *s;
    //printf("%s hash => %p\n", str, h);
    return h;
}
static Boolean c_equal(const void* value1, const void* value2) {
    return (strcmp((const char*)value1, (const char*)value2) == 0);
}

CFDictionaryKeyCallBacks kNX_CStringDictionaryKeyCallBacks = {
    .hash = c_hash,
    .equal = c_equal
};
CFDictionaryValueCallBacks kNX_CStringDictionaryValueCallBacks = {

};

nx_meta_cache *_Nonnull nx_buildMetaCache(Class _Nonnull aClass) {
    nx_meta_cache *meta = [nx_meta_cache new];
    meta->theClass = aClass;
    //Initial members
    meta->properties = class_copyPropertyList(aClass, &meta->property_count);
    meta->ivars = class_copyIvarList(aClass, &meta->ivar_count);

    meta->propertyNames = [NSMutableArray arrayWithCapacity:16];
    meta->propertyAndIvars =
    [[NSMapTable alloc] initWithKeyOptions:NSPointerFunctionsStrongMemory valueOptions:NSPointerFunctionsStrongMemory capacity:4];
    //[NSMutableDictionary dictionaryWithCapacity:4];
    //CFDictionaryCreateMutable(kCFAllocatorDefault, 4, &kNX_CStringDictionaryKeyCallBacks, &kCFTypeDictionaryValueCallBacks);
    //CFDictionaryCreateMutable(kCFAllocatorDefault, 16, &kCFTypeDictionaryKeyCallBacks, &kCFTypeDictionaryValueCallBacks);

    for(int i = 0; i < meta->property_count; i++) {
        const char* name = property_getName(meta->properties[i]);

        unsigned long len = strlen(name);
        char ivar_name[len + 2];
        ivar_name[0] = '_';
        memcpy(ivar_name+1, name, len+1);

        nx_meta_ivar_info *ivarInfo = [nx_meta_ivar_info new];
        ivarInfo.ivarName = ivar_name;
        Ivar ivar = nx_getIvarByPropertyName(aClass, name);
        ivarInfo->_ivar = ivar;
        ivarInfo->_ivarClass = nx_ivarClass(ivar);
        ivarInfo.typeEncoding = (char*)ivar_getTypeEncoding(ivar);
        ivarInfo->_offset = ivar_getOffset(ivar);
        ivarInfo.propNameCString = (char*)name;
        const char* attr = property_getAttributes(meta->properties[i]);
        ivarInfo->_generic = nx_fetchFirstProtocol(attr);

        NSString *propName = [NSString stringWithCString:name encoding:NSUTF8StringEncoding];
        //CFDictionarySetValue(meta->cf_propertyAndIvars, ivarInfo->_propNameCString, (__bridge_retained void*)ivarInfo);
        //CFDictionarySetValue(meta->propertyAndIvars, (__bridge void*)propName, (__bridge void*)ivarInfo);
        [meta->propertyAndIvars setObject:ivarInfo forKey:propName];

        [meta->propertyNames addObject:propName];
    }

    return meta;
}

inline nx_meta_cache* _Nonnull nx_lookupMetaCache(Class _Nonnull aClass) {
    //    if (!aClass || aClass == NSObject.class) {
    //        return 0;
    //    }
    nx_meta_cache *cache = [metaCache objectForKey:aClass];//[nx_metaCache() objectForKey:aClass];
    if (cache) {

        return cache;

    }else {

        cache = nx_buildMetaCache(aClass);

        [metaCache setObject:cache forKey:(id)aClass];

        //cache->superClass = nx_lookupMetaCache(class_getSuperclass(aClass));

        return cache;
    }
}

#pragma mark - Mapping

@implementation NSString (JSONToObject)

- (id)forkFromClass:(Class)aClass
{
    NSError* error;
    id jsonObj = [NSJSONSerialization JSONObjectWithData:[self dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingFragmentsAllowed error:&error];

    if (!([jsonObj isKindOfClass:[NSArray class]] ||
        [jsonObj isKindOfClass:[NSDictionary class]])) {
        return nil;
    }

    id obj = [jsonObj forkFromClass:aClass];
    return obj;
}

@end

@implementation NSObject (JSONToObject)

+ (void)load {
    if (!metaCache) {
        metaCache = [[NSMutableDictionary alloc] initWithCapacity:16];
        mappingSelector = @selector(propertiesMapping);
    }
}

- (id)realValueForTypeEncode:(const char *)type fromString:(id)value
{
    NSString *value1 = value;

    if (strncmp(type, "B", 1)) {//Bool
        if ([value isKindOfClass:[NSString class]]) {
            value1 = [value lowercaseString];
            if ([value1 isEqualToString:@"true"] || [value1 isEqualToString:@"yes"]) {
                return @(YES);
            }else if ([value1 isEqualToString:@"false"] || [value1 isEqualToString:@"no"]) {
                return @(NO);
            }
        }else if ([value isKindOfClass:[NSNumber class]]) {
            return value;
        }
    }else if (strncmp(type, "", 1)) {
        
    }
    
    return value;
}

- (NSDictionary *)dictionary
{
    NSMutableDictionary *mutableDict = [@{} mutableCopy];
    
    unsigned int iVarCount = 0;
    Ivar *iVarList = class_copyIvarList([self class], &iVarCount);
    
    Ivar iVar;

    for (unsigned int i = 0; i < iVarCount; i++) {
        iVar = iVarList[i];
        if (!iVar) {
            continue;
        }
        const char * varName = ivar_getName(iVar);
        const char * typeEncode = ivar_getTypeEncoding(iVar);
        const char *testing = @encode(NSObject*);

//        id v = object_getIvar(self, iVar);
//        if (v) {
//            [mutableDict setObject:object_getIvar(self, iVar) forKey:[[[NSString alloc] initWithFormat:@"%s", varName] substringFromIndex:1]];
//        }

//        if (typeEncode[0] == '@') {
//            [mutableDict setObject:[object_getIvar(self, iVar) dictionary] forKey:[[[NSString alloc] initWithFormat:@"%s", varName] substringFromIndex:1]];
//        }else {
//            [mutableDict setObject:object_getIvar(self, iVar) forKey:[[[NSString alloc] initWithFormat:@"%s", varName] substringFromIndex:1]];
//        }
    }
    
    return [mutableDict copy];
}

@end

@implementation NSData (JSONToObject)

- (id)forkFromClass:(nonnull Class)aClass
{
    id jsonObj = [NSJSONSerialization JSONObjectWithData:self options:NSJSONReadingAllowFragments error:nil];
    
    if (![NSJSONSerialization isValidJSONObject:jsonObj]) {
        NSLog(@"jsonobj is NOT JSON object.");
        return nil;
    }
    NSArray *obj = nil;
    obj = [jsonObj forkFromClass:aClass];
    return obj;
}

@end

@implementation NSArray (JSONToObject)

- (id)forkFromClass:(nonnull Class)aClass
{
    NSMutableArray *rtn = [[NSMutableArray alloc] initWithCapacity:16];
    
    int idx = 0;
    for (id maybeDict in self) {
        if (!aClass) {
            [rtn addObject:maybeDict];
            continue;
        }

        id value = nil;
        if ([maybeDict isKindOfClass:[NSString class]] ||
            [maybeDict isKindOfClass:[NSNumber class]]) {
            value = maybeDict;
        }else if ([maybeDict isKindOfClass:[NSDictionary class]]) {
            value = [maybeDict forkFromClass:aClass];
        }else {
            [[[NSException alloc] initWithName:XCObjectMappingJSONFormatException reason:@"JSON array must be composed of NSDictionary object for mapping." userInfo:nil] raise];
        }
        [rtn addObject:value];
    }
    return rtn;
}

@end

@implementation NSDictionary (JSONToObject)

- (id)forkFromClass:(nonnull Class)aClass
{   
    id obj = [[aClass alloc] init];

    if (self.count <= 0) {
        return nil;
    }
    [self flushObject:obj];
    
    return obj;
}

- (void)flushObject:(id)obj
{
    Class aClass = object_getClass(obj);
    nx_meta_cache* cache = (nx_meta_cache*)[metaCache objectForKey:aClass];
    __block id value = nil;
    __block id realValue = nil;
    __block id mappedKey = nil;
    __block NSString *propertyKey = nil;
	unsigned int propertyCount = cache->property_count;

#if 1
    //Reading properties mapping.
    NSDictionary *propMapped = nil;
    if ([aClass respondsToSelector:mappingSelector]) {
        propMapped = [aClass propertiesMapping];
    }
#endif

    for (int i = 0; i < propertyCount; i++) {//for-beign
        propertyKey = cache->propertyNames[i];
        //propertyKey = key;
        value = [self objectForKey:propertyKey];
        //value = objValue;

        if (!value || [value isKindOfClass:[NSNull class]]) {
            continue;
            //return;
        }
#if 1
        // map property key
        if (!value && propMapped) {
            mappedKey = [propMapped objectForKey:propertyKey];
            if (mappedKey) {
                value = [self valueForKey:mappedKey];
            }
        }
#endif

        realValue = value;//[self realValueForTypeEncode:typeEncode fromString:value];
        nx_meta_ivar_info *info = [cache->propertyAndIvars objectForKey:propertyKey];
        if (!info) {
            return;
        }
        if ([realValue isKindOfClass:[NSDictionary class]]) {
            if (!info->_ivarClass) {
                continue;
                //return;
            }
            if (![info->_ivarClass isSubclassOfClass:[NSDictionary class]]) {
                //直接保留映射为 className 的情况
                realValue = [realValue forkFromClass:info->_ivarClass];
            }else {
                //直接保留映射为 NSDictionary 的情况
            }
            object_setIvar(obj, info->_ivar, realValue);
        }else if ([realValue isKindOfClass:[NSArray class]]) {
			realValue = [(NSArray *)realValue forkFromClass:info->_ivarClass];
			if (realValue) {
				object_setIvar(obj, info->_ivar, realValue);
			}
        }else {
            const char* typeEncode = ivar_getTypeEncoding(info->_ivar);
            void* p = (__bridge void*)obj;

            if (strcmp(typeEncode, @encode(NSObject*)) == 0 ||
                strcmp(typeEncode, @encode(id)) == 0) {
                object_setIvar(obj, info->_ivar, value);
            }
            else if (strcmp(typeEncode, @encode(BOOL)) == 0) {
                *(BOOL*)((char*)p + info->_offset) = [value boolValue];
            }
            else if (strcmp(typeEncode, @encode(NSInteger)) == 0) {
                *(NSInteger*)((char*)p + info->_offset) = [value integerValue];
            }
            else if (strcmp(typeEncode, @encode(NSUInteger)) == 0) {
                *(NSUInteger*)((char*)p + info->_offset) = [value unsignedIntegerValue];
            }
            else if (strcmp(typeEncode, @encode(double)) == 0) {
                *(double*)((char*)p + info->_offset) = [value doubleValue];
            }
            else if (strcmp(typeEncode, @encode(float)) == 0) {
                *(float*)((char*)p + info->_offset) = [value doubleValue];
            }
            else {
                object_setIvar(obj, info->_ivar, value);
            }
        }
    }//for-end

}

@end
