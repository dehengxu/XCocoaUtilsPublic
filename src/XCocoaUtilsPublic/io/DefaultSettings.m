//
//  DefaultSettings.m
//  TaduUtils
//
//  Created by Deheng.Xu on 12-11-28.
//
//

#import "DefaultSettings.h"

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

- (id)loadSettingValueForKey:(NSString *)theKey
{
    NSUserDefaults *_defaults = [NSUserDefaults standardUserDefaults];
    if ([_defaults valueForKey:theKey]) {
        return [_defaults valueForKey:theKey];
    }
    //load default value
    if ([self respondsToSelector:@selector(loadDefaultSettingValueForKey:)]) {
        return [self loadDefaultSettingValueForKey:theKey];
    }
    return nil;
}

- (void)saveUserDefaultsValue:(id)value forKey:(NSString *)theKey
{
    if (!value || !theKey) {
        return;
    }
    NSUserDefaults *_defaults = [NSUserDefaults standardUserDefaults];
    //NSAssert(theKey != nil, @"key is nil!");
    //NSAssert(value != nil, @"key :%@;  value is '%@'!" , theKey, value);
    [_defaults setValue:value forKey:theKey];
}

- (void)saveUserDefaultsValue:(id)value forKey:(NSString *)theKey immediately:(BOOL)isImmediately
{
    [self saveUserDefaultsValue:value forKey:theKey];
    if (isImmediately) {
        NSUserDefaults *_defaults = [NSUserDefaults standardUserDefaults];
        [_defaults synchronize];
    }
}

- (void)deleteValueForKey:(NSString *)key
{
    NSUserDefaults *_defaults = [NSUserDefaults standardUserDefaults];
    [_defaults removeObjectForKey:key];
}

- (void)deleteValueForKey:(NSString *)key immediately:(BOOL)isImmediately
{
    NSUserDefaults *_defaults = [NSUserDefaults standardUserDefaults];
    [_defaults removeObjectForKey:key];
    if (isImmediately) {
        [_defaults synchronize];
    }
}

- (BOOL)synchronize
{
    NSUserDefaults *_defaults = [NSUserDefaults standardUserDefaults];
    return [_defaults synchronize];
}
@end
