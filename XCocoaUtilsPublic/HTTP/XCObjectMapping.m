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
    id jsonObj = [NSJSONSerialization JSONObjectWithData:[self dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:nil];
    //[self objectFromJSONString];
    if (![NSJSONSerialization isValidJSONObject:jsonObj]) {
        NSLog(@"jsonobj is NOT JSON object.");
        return nil;
    }
    
    if ([jsonObj isKindOfClass:[NSArray class]]) {
        NSArray *jsonArray = jsonObj;
        NSArray *obj = nil;
        obj = [jsonArray forkFromClass:aClass];
        return obj;
    }
    
    if ([jsonObj isKindOfClass:[NSDictionary class]]) {
        NSDictionary *jsonDict = jsonObj;
        
        id obj = nil;
        obj = [jsonDict forkFromClass:aClass];
        
        return obj;
    }
    
    
    [[[NSException alloc] initWithName:XCObjectMappingJSONFormatException reason:@"JSON data must be NSDictionary or NSArray object." userInfo:nil] raise];
    
    return jsonObj;
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
        const char * varName = ivar_getName(iVar);
        const char * typeEncode = ivar_getTypeEncoding(iVar);
        if (typeEncode[0] == '@') {
            [mutableDict setObject:[object_getIvar(self, iVar) dictionary] forKey:[[[NSString alloc] initWithFormat:@"%s", varName] substringFromIndex:1]];
        }else {
            [mutableDict setObject:object_getIvar(self, iVar) forKey:[[[NSString alloc] initWithFormat:@"%s", varName] substringFromIndex:1]];
        }
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
    
    return [NSString stringWithCString:substr encoding:NSUTF8StringEncoding];
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
    if ([jsonObj isKindOfClass:[NSArray class]]) {
        NSArray *jsonArray = jsonObj;
        NSArray *obj = nil;
        obj = [jsonArray forkFromClass:aClass];
        return obj;
    }
    
    if ([jsonObj isKindOfClass:[NSDictionary class]]) {
        NSDictionary *jsonDict = jsonObj;
        
        id obj = nil;
        obj = [jsonDict forkFromClass:aClass];
        
        return obj;
    }
    
    [[[NSException alloc] initWithName:XCObjectMappingJSONFormatException reason:@"JSON data must be NSDictionary or NSArray object." userInfo:nil] raise];
    
    return nil;
}

@end

@implementation NSArray (JSONToObject)

- (id)forkFromClass:(nonnull Class)aClass
{
    NSMutableArray *rtn = [[NSMutableArray alloc] initWithArray:self];
    
    int idx = 0;
    for (id dict in self) {
        
        id value = nil;
        
        if ([dict isKindOfClass:[NSString class]] ||
            [dict isKindOfClass:[NSNumber class]]) {
            value = dict;
        }else if ([dict isKindOfClass:[NSDictionary class]]) {
            value = [dict forkFromClass:aClass];
        }else {
            [[[NSException alloc] initWithName:XCObjectMappingJSONFormatException reason:@"JSON array must be composed of NSDictionary object for mapping." userInfo:nil] raise];
        }
        rtn[idx] = value;
        idx ++;
    }
    return rtn;
}

@end

@implementation NSDictionary (JSONToObject)

- (id)forkFromClass:(nonnull Class)aClass
{   
    id obj = [[aClass alloc] init];
    
    if (self.allKeys.count <= 0) {
        return nil;
    }
    [self flushObject:obj];
    
    return obj;
}

- (void)flushObject:(id)obj
{
    Class aClass = [obj class];
    unsigned int varCount = 0;
    
    __unused Ivar *pVarList = class_copyIvarList(aClass, &varCount);
    
    Ivar iVar = NULL;
    NSString *propertyKey = nil;
    id value = nil;
    const char * typeEncode;
    
    unsigned int propertyCount = 0;
    objc_property_t *propertyList = class_copyPropertyList(aClass, &propertyCount);
    objc_property_t property;
    const char *attributes;
    
    //Reading properties mapping.
    SEL mappingSelector = @selector(propertiesMapping);
    id properties = nil;
    if ([aClass respondsToSelector:mappingSelector]) {
        Method method = class_getClassMethod(aClass, mappingSelector);
        properties = ((NSDictionary* (*)(Class, Method))method_invoke)(aClass, method);
    }
    
    for (int i = 0; i < propertyCount; i++) {
        property = propertyList[i];
        const char *name = property_getName(property);
        
        unsigned long len = strlen(name);
        char *ivar_name = malloc(sizeof(char) * (len + 2));
        ivar_name[0] = '\0';
        strcat(ivar_name, "_");
        strcat(ivar_name, name);
        
        iVar = class_getInstanceVariable(aClass, ivar_name);
        typeEncode = ivar_getTypeEncoding(iVar);
        propertyKey = [NSString stringWithCString:name encoding:NSUTF8StringEncoding];
        attributes = property_getAttributes(property);
        value = [self valueForKey:propertyKey];
        
        if (properties && [properties objectForKey:propertyKey] && !value) {
            value = [self valueForKey:[properties objectForKey:propertyKey]];
        }
        
        free(ivar_name);
        
        if (!value || [value isKindOfClass:[NSNull class]]) {
            continue;
        }
        
        //NSLog(@"key :%@, type: %@; value :%@", propertyKey, [value class], value);
        
        id realValue = value;//[self realValueForTypeEncode:typeEncode fromString:value];
        
        if ([realValue isKindOfClass:[NSDictionary class]]) {
            NSString *className = [[NSString stringWithCString:typeEncode encoding:NSUTF8StringEncoding] substringWithRange:NSMakeRange(2, strlen(typeEncode) - 3)];
            
            if (![NSClassFromString(className) isSubclassOfClass:[NSDictionary class]]) {
                //直接保留映射为 className 的情况
                realValue = [realValue forkFromClass:NSClassFromString(className)];
            }else {
                //直接保留映射为 NSDictionary 的情况
            }

            [obj setValue:realValue forKey:propertyKey];
        }else if ([realValue isKindOfClass:[NSArray class]]) {
            NSString *className = [obj fetchFirstProtocolName:attributes];
            realValue = [(NSArray *)realValue forkFromClass:NSClassFromString(className)];
            if (realValue) {
                //[obj setValue:realValue forKey:propertyKey];
                object_setIvar(obj, iVar, realValue);
            }
        }else {
            [obj setValue:value forKey:propertyKey];
            //object_setIvar(obj, iVar, realValue);
        }
    }
}

@end
