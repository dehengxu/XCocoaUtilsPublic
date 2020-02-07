//
//  FileIOHelper.m
//  LionRss
//
//  Created by Xu Deheng on 12-3-19.
//  Copyright (c) 2012年 Deheng.Xu. All rights reserved.
//

#import "FileIOHelper.h"

@interface FileIOHelper ()
@property (atomic, copy) NSString *path;

@end

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

- (instancetype)initWithRoot:(NSString *)rootPath
{
    self = [super init];
    if (self) {
        self.path = rootPath;
        NSError *fileErr = nil;
        BOOL res = false;
        if (![NSFileManager.defaultManager fileExistsAtPath:self.path isDirectory:0]) {
            res = [NSFileManager.defaultManager createDirectoryAtPath:self.path withIntermediateDirectories:YES attributes:nil error:&fileErr];
            if (!res) {
                NSLog(@"%@ is not exist, create failed. error: %@", self.path, fileErr);
            }
        }
    }
    return self;
}



- (void)saveData:(NSData *)data forSubPath:(NSString *)subpath
{
    //NSFileAttributeKey
    BOOL res = NO, isDir = NO;
    NSError *err = nil;
    NSString *dest = [self.path stringByAppendingPathComponent:subpath];
    NSURL *fileURL = [NSURL fileURLWithPath:dest];
    NSURL *tmp = fileURL.URLByDeletingLastPathComponent;
    if (data) {
        if (![NSFileManager.defaultManager fileExistsAtPath:tmp.absoluteString isDirectory:&isDir]) {
            [NSFileManager.defaultManager createDirectoryAtURL:tmp withIntermediateDirectories:YES attributes:nil error:&err];
        }
        res = [NSFileManager.defaultManager createFileAtPath:dest contents:data attributes:@{}];
    }else {
        [NSFileManager.defaultManager removeItemAtPath:[self.path stringByAppendingPathComponent:subpath] error:&err];
    }
    NSLog(@"%@, err: %@", res?@"YES":@"NO", err);
}

- (void)removePath:(NSString *)subpath error:(NSError **)error
{
    BOOL isDir = NO;
    if ([NSFileManager.defaultManager fileExistsAtPath:subpath isDirectory:&isDir]) {
        if (![NSFileManager.defaultManager removeItemAtPath:subpath error:error]) {
            NSLog(@"Remove%@ \"%@\" failed, error: %@", isDir?@" directory":@"", subpath, *error);
        }
    }
}

- (NSData *)dataForSubPath:(NSString *)subpath
{
    BOOL isDir = NO;
    NSString *dest = [self.path stringByAppendingPathComponent:subpath];
    if ([NSFileManager.defaultManager fileExistsAtPath:dest isDirectory:&isDir] && !isDir) {
        return [NSData dataWithContentsOfFile:dest];
    }
    return nil;
}

- (void)cleanAll
{
    NSError *err = nil;
    [self removePath:self.path error:&err];
}

@end
