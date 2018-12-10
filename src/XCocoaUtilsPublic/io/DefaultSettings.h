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

/**
 *  Load value from defaultsetting while userdefaults has no value.
 *
 *  @param theKey Key of the value.
 *
 *  @return 如果没有该记录，则返回默认值.
 */
- (id)loadSettingValueForKey:(NSString*)theKey;

/**
 *  Save value into defaultsetting.
 *
 *  @param value  value
 *  @param theKey key
 */
- (void)saveUserDefaultsValue:(id)value forKey:(NSString*)theKey;

/**
 *  Save value into defaultsetting and synchronizing immediately.
 *
 *  @param value         value
 *  @param theKey        key
 *  @param isImmediately 是否立刻保存
 */
- (void)saveUserDefaultsValue:(id)value forKey:(NSString*)theKey immediately:(BOOL)isImmediately;

/**
 *  删除对应键的值
 *
 *  @param key 键
 */
- (void)deleteValueForKey:(NSString *)key;

/**
 *  删除对应键的值
 *
 *  @param key           键
 *  @param isImmediately 是否立即同步
 */
- (void)deleteValueForKey:(NSString *)key immediately:(BOOL)isImmediately;

/**
 *  同步数据到文件
 *
 *  @return 返回是否成功
 */
- (BOOL)synchronize;

@end
