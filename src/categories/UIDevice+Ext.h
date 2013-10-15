//
//  UIDevice+Utils.h
//  TaduUtils
//
//  Created by Xu Deheng on 12-4-5.
//  Copyright (c) 2012年 Deheng.Xu. All rights reserved.
//

#if TARGET_OS_IPHONE

#import <UIKit/UIKit.h>

#import <mach/mach.h>

extern double availableMemory();
extern double usedMemory();
extern void enableLogFile();
extern void enableLogFileWithPath(NSString *path);

@interface UIDevice (Ext)

/*ios 无线网卡 mac 地址*/
+ (NSString *) macaddress;
/* 可用内存 (MB)*/
+ (double)TDAvailableMemory;
/* 已用内存 (MB)*/
+ (double)TDUsedMemory;

- (BOOL)isIPhone;
- (BOOL)isIPad;
- (BOOL)isIPod;
- (BOOL)isSimulator;

/* ios 设备唯一标识*/
- (NSString *)xUniqueIdentifier;

- (CGFloat)osVersion;

- (void)manualMemoryWarning;


@end

#endif
