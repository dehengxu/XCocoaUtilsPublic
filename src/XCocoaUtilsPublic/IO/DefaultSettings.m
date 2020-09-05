//
//  DefaultSettings.m
//  TaduUtils
//
//  Created by Deheng.Xu on 12-11-28.
//
//

#import "DefaultSettings.h"
#import <XCocoaUtilsPublic/XCUPDebug.h>

@implementation DefaultSettings

static DefaultSettings *__shared_instance = nil;

+ (id)sharedInstance
{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!__shared_instance) {
            __shared_instance = [[self.class alloc] init];
        }
    });
    
    return __shared_instance;
}

#if ARC_DISABLED
- (oneway void)release
{
    
}
#endif

- (void)dealloc
{
#if ARC_DISABLED
    [super dealloc];
#endif
}

- (id)objectForKey:(NSString *)theKey
{
    IsNullAndReturnValue(theKey, nil);
    
    NSUserDefaults *_defaults = [NSUserDefaults standardUserDefaults];
    if ([_defaults objectForKey:theKey]) {
        return [_defaults objectForKey:theKey];
    }
    
    //load default value from delegate
    if ([self.defaultDelegate respondsToSelector:@selector(defaultSettingObjectForKey:)]) {
        return [self.defaultDelegate defaultSettingObjectForKey:theKey];
    }
    return nil;
}

- (void)setObject:(id)value forKey:(NSString *)theKey
{
    IsNullAndReturn(theKey);
    NSUserDefaults *_defaults = [NSUserDefaults standardUserDefaults];
    [_defaults setValue:value forKey:theKey];
}

- (void)setObject:(id)value forKey:(NSString *)theKey immediately:(BOOL)isImmediately
{
    IsNullAndReturn(theKey);
    [self setObject:value forKey:theKey];
    if (isImmediately) {
        [self synchronize];
    }
}

- (void)removeObjectForKey:(NSString *)key
{
    IsNullAndReturn(key);
    NSUserDefaults *_defaults = [NSUserDefaults standardUserDefaults];
    [_defaults removeObjectForKey:key];
}

- (void)removeObjectForKey:(NSString *)key immediately:(BOOL)isImmediately
{
    IsNullAndReturn(key);
    [self removeObjectForKey:key];
    if (isImmediately) {
        [self synchronize];
    }
}

- (BOOL)synchronize
{
    NSUserDefaults *_defaults = [NSUserDefaults standardUserDefaults];
    return [_defaults synchronize];
}
@end
