//
//  DefaultSettings.h
//  TaduUtils
//
//  Created by Deheng.Xu on 12-11-28.
//
//

@protocol DefaultSettingsProtocol <NSObject>

@optional
- (id)loadDefaultSettingValueForKey:(NSString *)theKey;

@end

#import <Foundation/Foundation.h>

@interface DefaultSettings : NSObject<DefaultSettingsProtocol>

+ (id)sharedInstance;

//load value from defaultsetting while userdefaults has no value.
- (id)loadSettingValueForKey:(NSString*)theKey;
//save value into defaultsetting.
- (void)saveUserDefaultsValue:(id)value forKey:(NSString*)theKey;
//save value into defaultsetting and synchronizing immediately.
- (void)saveUserDefaultsValue:(id)value forKey:(NSString*)theKey immediately:(BOOL)isImmediately;

- (void)deleteValueForKey:(NSString *)key;
- (void)deleteValueForKey:(NSString *)key immediately:(BOOL)isImmediately;
//synchronize data to file.
- (BOOL)synchronize;

@end
