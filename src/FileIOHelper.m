//
//  FileIOHelper.m
//  LionRss
//
//  Created by Xu Deheng on 12-3-19.
//  Copyright (c) 2012年 Deheng.Xu. All rights reserved.
//

#import "FileIOHelper.h"

@implementation FileIOHelper

+ (NSString *)pathForFileName:(NSString *)fileName
{
    if (fileName.length == 0) {
        return nil;
    }
    NSString *ext = [fileName pathExtension];
    return [[NSBundle mainBundle] pathForResource:[fileName substringToIndex:fileName.length - ext.length - 1] ofType:ext];
}

+ (NSString *)documentPath
{
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}

+ (NSString *)libraryPath
{
    return [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject];
}

+ (NSString *)cachePath
{
    return [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
}

+ (NSString *)tmpPath
{
    return NSTemporaryDirectory();
}

@end
