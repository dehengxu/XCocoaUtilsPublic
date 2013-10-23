//
//  FileIOHelper.h
//  LionRss
//
//  Created by Xu Deheng on 12-3-19.
//  Copyright (c) 2012年 Deheng.Xu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FileIOHelper : NSObject

+ (NSString *)pathForFileName:(NSString *)fileName;

+ (NSString *)documentPath;

+ (NSString *)libraryPath;

+ (NSString *)cachePath;

+ (NSString *)tmpPath;


@end
