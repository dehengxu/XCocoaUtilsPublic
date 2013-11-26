//
//  NameValuePaire.m
//  XUtils
//
//  Created by Xu Deheng on 12-5-14.
//  Copyright (c) 2012年 __MyCompany__ All rights reserved.
//

#import "NameValuePaire.h"
#import "FunctionSet.h"

@implementation NameValuePaire
@synthesize name;
@synthesize value;

+ (NameValuePaire *)nameValuePaireWithValue:(NSString *)theValue andName:(NSString *)theName
{
    NameValuePaire *pp = [self new];
    pp.name = theName;
    pp.value = theValue;
    return XAutorelease(pp);
}

+ (NameValuePaire *)nameValueFromString:(NSString *)theString
{
    NameValuePaire *pp = nil;
    NSArray *pairdata = [theString componentsSeparatedByString:@"="];
    if (pairdata.count == 0) {
        //不符合pair标准
        return nil;
    }
    
    pp = XAutorelease([self new]);
    if (pairdata.count > 0) {
        pp.name = [pairdata objectAtIndex:0];
    }

    if (pairdata.count > 1) {
        pp.value = [pairdata objectAtIndex:1];
    }
    if (pp.value == nil) {
        pp.value = [NSString stringWithFormat:@""];
    }
    return pp;
}

+ (NSArray *)nameValuesFromParamsString:(NSString *)theParamsString
{
    NSMutableArray *rtn = [NSMutableArray arrayWithCapacity:8];
    NSArray *paramsData = [theParamsString componentsSeparatedByString:@"&"];
    for (NSString *paramstr_ in paramsData) {
        NameValuePaire *paire_ = [NameValuePaire nameValueFromString:paramstr_];
        [rtn addObject:paire_];
    }
    return rtn;
}

- (BOOL)isEqual:(NameValuePaire*)object
{
    if ([object isKindOfClass:self.class]) {
        return ([[object name] isEqualToString:self.name] && [[object value] isEqualToString:self.value]);
    }else {
        return NO;
    }
}

#if !ARC_ENABLED
- (void)dealloc
{
    [name release];
    [value release];
    [super dealloc];
}
#endif

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@=%@", self.name, self.value];
}

- (NSString *)urlEncodedPaireString
{
    return [NSString stringWithFormat:@"%@=%@", [name urlEncoding], [value urlEncoding]];
}

- (NSString *)urlDecodedPaireString
{
    return [NSString stringWithFormat:@"%@=%@", [name urlDecoding], [value urlDecoding]];
}

- (NameValuePaire *)urlEncodedPaire
{
    return [NameValuePaire nameValueFromString:[self urlEncodedPaireString]];
}

- (NameValuePaire *)urlDecodedPaire
{
    return [NameValuePaire nameValueFromString:[self urlDecodedPaireString]];
}

- (void)URLEncoding
{
    [self XRetain];
    value = [value urlEncoding];
    name = [name urlEncoding];
    [self XRelease];
}

- (void)URLDecoding
{
    [self XRetain];
    value = [value urlDecoding];
    name = [name urlDecoding];
    [self XRelease];
}

- (NSString *)stringOfPair
{
    return [NSString stringWithFormat:@"%@=%@", name, value];
}

@end


@implementation NSMutableArray (NameValuePaire)

- (void)setValue:(NSString *)theValue forName:(NSString *)theName
{
    if (theName == nil || theValue == nil) {
        return;
    }
    
    NameValuePaire *paire_ = [NameValuePaire nameValuePaireWithValue:theValue andName:theName];
    if (self.count == 0) {
        [self addObject:paire_];
        return;
    }
    
    BOOL contains_ = NO;
    for (NameValuePaire *checker_ in self) {
        contains_ = [checker_ isEqual:paire_];
        if (contains_) {//已经存在
            break;
        }
    }
    if (!contains_) {
        [self addObject:paire_];
    }
}

@end

