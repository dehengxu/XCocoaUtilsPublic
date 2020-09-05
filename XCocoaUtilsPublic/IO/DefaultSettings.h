//
//  DefaultSettings.h
//  TaduUtils
//
//  Created by Deheng.Xu on 12-11-28.
//
//

#import <Foundation/Foundation.h>
#import <Availability.h>

@protocol DefaultSettingsProtocol <NSObject>

@required
- (id)defaultSettingObjectForKey:(NSString *)key;

@end

#import <Foundation/Foundation.h>

@interface DefaultSettings : NSObject

@property (nonatomic, weak) id<DefaultSettingsProtocol> defaultDelegate;

+ (id)sharedInstance;

/**
 *  Load value from defaultsetting while userdefaults has no value.
 *
 *  @param theKey Key of the value.
 *
 *  @return 如果没有该记录，则返回默认值.
 */
- (id)objectForKey:(NSString*)theKey;

/**
 *  Save value into defaultsetting.
 *
 *  @param value  value
 *  @param theKey key
 */
- (void)setObject:(id)value forKey:(NSString*)theKey;

/**
 *  Save value into defaultsetting and synchronizing immediately.
 *
 *  @param value         value
 *  @param theKey        key
 *  @param isImmediately 是否立刻保存
 */
- (void)setObject:(id)value forKey:(NSString*)theKey immediately:(BOOL)isImmediately;

/**
 *  删除对应键的值
 *
 *  @param key 键
 */
- (void)removeObjectForKey:(NSString *)key;

/**
 *  删除对应键的值
 *
 *  @param key           键
 *  @param isImmediately 是否立即同步
 */
- (void)removeObjectForKey:(NSString *)key immediately:(BOOL)isImmediately;

/**
 *  同步数据到文件
 *
 *  @return 返回是否成功
 */
- (BOOL)synchronize;

@end
