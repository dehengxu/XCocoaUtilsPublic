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


@implementation XCObjectMapping

- (id)mapObject:(id)object toClass:(Class)aClass
{
    return [object forkFromClass:aClass];
}

- (id)mapObject:(id)object1 toKindeOfObject:(__autoreleasing id)object2
{
    return [object1 forkFromClass:[object2 class]];
}

@end

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

- (NSString *)fetchFirstProtocolName:(const char *)attribute
{
    char * pbegin = strstr(attribute, "<");
    if (pbegin == NULL) return nil;
    
    char *pend = strstr(attribute, ">");
    if (pend == NULL) return nil;

    unsigned long length = strlen(pbegin) - strlen(pend) - 1;
    
    char *substr = malloc(sizeof(char) * (length + 1));
    __unused char *sub = strncpy(substr, pbegin + 1, length);
    substr[length] = '\0';
    if (substr == NULL) {
        return nil;
    }
    
    NSString* ret = [NSString stringWithCString:substr encoding:NSUTF8StringEncoding];
	free(substr);
	return ret;
}

- (NSDictionary *)propertiesMapping
{
    return nil;
}

@end

@implementation NSData (JSONToObject)

- (id)forkFromClass:(nonnull Class)aClass
{
    id jsonObj = [NSJSONSerialization JSONObjectWithData:self options:NSJSONReadingAllowFragments error:nil];
    //[self objectFromJSONData];
    
    if (![NSJSONSerialization isValidJSONObject:jsonObj]) {
        NSLog(@"jsonobj is NOT JSON object.");
        return nil;
    }
    NSArray *obj = nil;
    obj = [jsonObj forkFromClass:aClass];
    return obj;
//    if ([jsonObj isKindOfClass:[NSArray class]]) {
//        NSArray *jsonArray = jsonObj;
//        NSArray *obj = nil;
//        obj = [jsonArray forkFromClass:aClass];
//        return obj;
//    }
//
//    if ([jsonObj isKindOfClass:[NSDictionary class]]) {
//        NSDictionary *jsonDict = jsonObj;
//
//        id obj = nil;
//        obj = [jsonDict forkFromClass:aClass];
//
//        return obj;
//    }
    
    [[[NSException alloc] initWithName:XCObjectMappingJSONFormatException reason:@"JSON data must be NSDictionary or NSArray object." userInfo:nil] raise];
    
    return nil;
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

    Ivar iVar = NULL;
    id value = nil;
    const char * typeEncode;
    
    NSString *propertyKey = nil;
    unsigned int propertyCount = 0;
    objc_property_t *propertyList = class_copyPropertyList(aClass, &propertyCount);
    objc_property_t property;
    const char *attributes;
    
#if 0
    //Reading properties mapping.
    SEL mappingSelector = @selector(propertiesMapping);
    id properties = nil;
    if ([aClass respondsToSelector:mappingSelector]) {
        Method method = class_getClassMethod(aClass, mappingSelector);
        properties = ((NSDictionary* (*)(Class, Method))method_invoke)(aClass, method);
    }
#endif
    for (int i = 0; i < propertyCount; i++) {
        property = propertyList[i];
        const char *name = property_getName(property);
        unsigned long len = strlen(name);
        char ivar_name[len + 2];
        ivar_name[0] = '_';
        memcpy(ivar_name+1, name, len+1);

        //sprintf(ivar_name, "_%s", name);

        //ivar_name[0] = '\0';
        //strcat(ivar_name, "_");
        //strcat(ivar_name, name);

        propertyKey =
        //[NSString stringWithFormat:@"%s", name];
        //(__bridge_transfer NSString*)CFStringCreateWithCString(kCFAllocatorDefault, name, kCFStringEncodingUTF8);
        [NSString stringWithCString:name encoding:NSUTF8StringEncoding];

        value = [self objectForKey:propertyKey];
        if (!value || [value isKindOfClass:[NSNull class]]) {
            continue;
        }
#if 0
        // map property key
        if (!value && properties && [properties objectForKey:propertyKey]) {
            value = [self valueForKey:[properties objectForKey:propertyKey]];
        }
#endif

        id realValue = value;//[self realValueForTypeEncode:typeEncode fromString:value];
        if ([realValue isKindOfClass:[NSDictionary class]]) {
            iVar = class_getInstanceVariable(aClass, ivar_name);
            typeEncode = ivar_getTypeEncoding(iVar);

            NSString *className = [[NSString stringWithCString:typeEncode encoding:NSUTF8StringEncoding] substringWithRange:NSMakeRange(2, strlen(typeEncode) - 3)];

            if (![NSClassFromString(className) isSubclassOfClass:[NSDictionary class]]) {
                //直接保留映射为 className 的情况
                realValue = [realValue forkFromClass:NSClassFromString(className)];
            }else {
                //直接保留映射为 NSDictionary 的情况
            }
            object_setIvar(obj, iVar, realValue);
        }else if ([realValue isKindOfClass:[NSArray class]]) {
            iVar = class_getInstanceVariable(aClass, ivar_name);
            attributes = property_getAttributes(property);
            NSString *className = [obj fetchFirstProtocolName:attributes];
            if (className.length) {
                realValue = [(NSArray *)realValue forkFromClass:NSClassFromString(className)];
                if (realValue) {
                    object_setIvar(obj, iVar, realValue);
                }
            }
        }else {
            iVar = class_getInstanceVariable(aClass, ivar_name);
            const char* typeEncode = ivar_getTypeEncoding(iVar);
            ptrdiff_t diff = ivar_getOffset(iVar);
            void* p = (__bridge void*)obj;

            if (strcmp(typeEncode, @encode(NSObject*)) == 0) {
                object_setIvar(obj, iVar, value);
            }
            else if (strcmp(typeEncode, @encode(BOOL)) == 0) {
                *(BOOL*)((char*)p + diff) = [value integerValue];
            }
            else if (strcmp(typeEncode, @encode(NSInteger)) == 0) {
                *(NSInteger*)((char*)p + diff) = [value integerValue];
            }
            else if (strcmp(typeEncode, @encode(NSUInteger)) == 0) {
                *(NSUInteger*)((char*)p + diff) = [value unsignedIntegerValue];
            }
            else if (strcmp(typeEncode, @encode(NSTimeInterval)) == 0) {
                *(NSTimeInterval*)((char*)p + diff) = [value doubleValue];
            }
            else if (strcmp(typeEncode, @encode(CGFloat)) == 0) {
                *(CGFloat*)((char*)p + diff) = [value doubleValue];
            }
            else {
                object_setIvar(obj, iVar, value);
            }
        }
    }
}

@end
