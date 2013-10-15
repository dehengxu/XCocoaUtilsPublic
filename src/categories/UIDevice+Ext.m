//
//  UIDevice+Utils.m
//  TaduUtils
//
//  Created by Xu Deheng on 12-4-5.
//  Copyright (c) 2012年 Deheng.Xu. All rights reserved.
//

#if TARGET_OS_IPHONE

#import "UIDevice+Ext.h"

#import "NSString+Ext.h"
#import "FunctionSet.h"

#include <sys/socket.h>
#include <sys/sysctl.h>
#include <net/if.h>
#include <net/if_dl.h>

extern double availableMemory()
{
    vm_statistics_data_t vmStats;
    mach_msg_type_number_t infoCount = HOST_VM_INFO_COUNT;
    kern_return_t kernReturn = host_statistics(mach_host_self(),
                                               HOST_VM_INFO,
                                               (host_info_t)&vmStats,
                                               &infoCount);
    if (kernReturn != KERN_SUCCESS) {
        return NSNotFound;
    }
    return ((vm_page_size *vmStats.free_count) / 1024.0) / 1024.0;
}

extern double usedMemory()
{
    task_basic_info_data_t taskInfo;
    mach_msg_type_number_t infoCount = TASK_BASIC_INFO_COUNT;
    kern_return_t kernReturn = task_info(mach_task_self(),
                                         TASK_BASIC_INFO,
                                         (task_info_t)&taskInfo,
                                         &infoCount);
    if (kernReturn != KERN_SUCCESS
        ) {
        return NSNotFound;
    }
    return taskInfo.resident_size / 1024.0 / 1024.0;
}

extern void enableLogFile()
{
    NSDate * date = [NSDate date];
    
    NSString *logFileRootDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSLog(@"logFilePath :%@", logFileRootDir);
    NSString *format = @"yyyy-MM-dd_H-mm-ss";
    
    NSDateFormatter * dateFormatter = XAutorelease([NSDateFormatter new]);
	[dateFormatter setLocale:[NSLocale currentLocale]];
    /* format example:
        [formatter setDateFormat:@"yyyy-MM-dd_H:mm:ss"];
        [formatter setDateFormat:@"yyyyMMddHmmss"];
     */
    [dateFormatter setDateFormat:format];
    
    NSString * logName = [dateFormatter stringFromDate:date];
    NSLog(@"logName :%@", logName);
    FILE *file = freopen([[NSString stringWithFormat:@"%@/%@_%@", logFileRootDir, logName, @"TADU.log"] cStringUsingEncoding:NSASCIIStringEncoding], "w+", stderr);
    printf("file :%u\n", (unsigned int)file);
    printf("%s\n", __FUNCTION__);
}

extern void enableLogFileWithPath(NSString *path)
{
    FILE *file = freopen([path cStringUsingEncoding:NSASCIIStringEncoding], "w+", stderr);
    printf("file :%u\n", (unsigned int)file);
    printf("%s\n", __FUNCTION__);
}

@interface UIDevice (_private_)

- (void)_deviceMemoryWarning;
- (void)_simulatorMemoryWarning;

@end

@implementation UIDevice (Ext)
/*ios 无线网卡 mac 地址*/
+ (NSString *) macaddress
{
    
    int mib[6];
    size_t len;
    char *buf;
    unsigned char *ptr;
    struct if_msghdr *ifm;
    struct sockaddr_dl *sdl;
    
    mib[0] = CTL_NET;
    mib[1] = AF_ROUTE;
    mib[2] = 0;
    mib[3] = AF_LINK;
    mib[4] = NET_RT_IFLIST;
    
    if ((mib[5] = if_nametoindex("en0")) == 0) {
        printf("Error: if_nametoindex error\n");
        return NULL;
    }
    
    if (sysctl(mib, 6, NULL, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 1\n");
        return NULL;
    }
    
    if ((buf = malloc(len)) == NULL) {
        printf("Could not allocate memory. error!\n");
        return NULL;
    }
    
    if (sysctl(mib, 6, buf, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 2");
        free(buf);
        return NULL;
    }
    
    ifm = (struct if_msghdr *)buf;
    sdl = (struct sockaddr_dl *)(ifm + 1);
    ptr = (unsigned char *)LLADDR(sdl);
    NSString *outstring = [NSString stringWithFormat:@"%02X:%02X:%02X:%02X:%02X:%02X",
                           *ptr, *(ptr+1), *(ptr+2), *(ptr+3), *(ptr+4), *(ptr+5)];
    free(buf);
    
    return outstring;
}

+ (double)TDAvailableMemory
{
    vm_statistics_data_t vmStats;
    mach_msg_type_number_t infoCount = HOST_VM_INFO_COUNT;
    kern_return_t kernReturn = host_statistics(mach_host_self(),
                                               HOST_VM_INFO,
                                               (host_info_t)&vmStats,
                                               &infoCount);
    if (kernReturn != KERN_SUCCESS) {
        return NSNotFound;
    }
    
    return ((vm_page_size *vmStats.free_count) / 1024.0) / 1024.0;
}

+ (double)TDUsedMemory
{
    task_basic_info_data_t taskInfo;
    mach_msg_type_number_t infoCount = TASK_BASIC_INFO_COUNT;
    kern_return_t kernReturn = task_info(mach_task_self(),
                                         TASK_BASIC_INFO,
                                         (task_info_t)&taskInfo,
                                         &infoCount);
    
    if (kernReturn != KERN_SUCCESS) {
        return NSNotFound;
    }
    
    return taskInfo.resident_size / 1024.0 / 1024.0;
}

/* ios 设备唯一标识*/
- (NSString *)xUniqueIdentifier
{
    NSLog(@"mac :%@", [UIDevice macaddress]);
    //return [[@"AA:BB:CC:DD:EE:FF" md5Digest] uppercaseString];
    return  [[[UIDevice macaddress] md5Digest] uppercaseString];
}

#pragma mark - device os , hardware version .

- (BOOL)isIPhone
{
    return [[[self model] lowercaseString] rangeOfString:@"iphone"].length > 0;
}

- (BOOL)isIPad
{
    return [[[self model] lowercaseString] rangeOfString:@"ipad"].length > 0;
}

- (BOOL)isIPod
{
    return [[[self model] lowercaseString] rangeOfString:@"ipod"].length > 0;
}

- (BOOL)isSimulator
{
    return [[[self model] lowercaseString] rangeOfString:@"simulator"].length > 0;
}

- (CGFloat)osVersion
{
    return [self systemVersion].floatValue;
}

#pragma mark - debug for memory

- (void)manualMemoryWarning
{
    NSLog(@"%s", __FUNCTION__);
    //    if (isSimulator()) {
    //        [self _simulatorMemoryWarning];
    //    }else {
    [self _deviceMemoryWarning];
    //    }
}

#pragma mark - private method

- (void)_deviceMemoryWarning
{
#if DEBUG || TARGET_IPHONE_SIMULATOR
    if ([[UIApplication sharedApplication] respondsToSelector:NSSelectorFromString(@"_performMemoryWarning")]) {
        [[UIApplication sharedApplication] performSelector:NSSelectorFromString(@"_performMemoryWarning")];
    }
#endif
}

- (void)_simulatorMemoryWarning
{
    //UIApplicationDidReceiveMemoryWarningNotification
    //    CFNotificationCenterPostNotification(CFNotificationCenterGetDarwinNotifyCenter(), (CFStringRef)@"UISimulatedMemoryWariningNotification", NULL, NULL, true);
    //    [[NSNotificationCenter defaultCenter] postNotificationName:@"UISimulatedMemoryWariningNotification" object:nil];
}

@end

#endif
