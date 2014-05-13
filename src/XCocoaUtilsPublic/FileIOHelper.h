//
//  FileIOHelper.h
//  LionRss
//
//  Created by Xu Deheng on 12-3-19.
//  Copyright (c) 2012年 Deheng.Xu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FileIOHelper : NSObject
/**
 *  获取bundle 内的文件路径
 *
 *  @param fileName 文件名
 *
 *  @return 返回路径
 */
+ (NSString *)pathForFileName:(NSString *)fileName;

/**
 *  获取 document 的路径
 *
 *  @return 返回路径
 */
+ (NSString *)documentPath;

/**
 *  获取 library 的路径
 *
 *  @return 返回路径
 */
+ (NSString *)libraryPath;

/**
 *  获取 cache 的路径
 *
 *  @return 返回路径
 */
+ (NSString *)cachePath;

/**
 *  获取 tmp 的路径
 *
 *  @return 返回路径
 */
+ (NSString *)tmpPath;


@end
