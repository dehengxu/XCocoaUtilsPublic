//
//  AppDelegate.m
//  Demo
//
//  Created by NicholasXu on 15/9/1.
//  Copyright (c) 2015年 Deheng.Xu. All rights reserved.
//

#import "AppDelegate.h"
#import "Logs.h"
#import <XCocoaUtilsPublic/XCocoaUtilsPublic.h>
#import <objc/runtime.h>
#import <XCocoaUtilsPublic/NSData+XCUPGzip.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.

    EnableLogger(@"app");
    EnableLogger(@"mainvc");
    //DisableLogger(@"app");

//    [log_app setLoggingEnabled:1];
//    [log_mainvc setLoggingEnabled:1];
    
	appLog(@"%s", __func__);
    appLog(@"JS: %@", JS_HTML_OUTER);
    //appLog(@"XCocoaUtilsPublic_iOSVersionNumber: %s", XCocoaUtilsPublic_iOSVersionString);
    appLog(@"title: %@", [@"title" localizedString]);
    
    //NSLog(@"ver: %f", XCocoaUtilsPublic_iOSVersionNumber);
    //NSLog(@"ver: %s", XCocoaUtilsPublic_iOSVersionString);
    
    self.timer = [XCUPSafeTimer repeatTimerWithInterval:1.0 duration:4.0 block:^(NSTimer * _Nonnull t, BOOL end) {
        NSLog(@"t: %@", t);
        self.timer = nil;
    }];

    NSLog(@"doc:%@", FileIOHelper.documentPath);
    FileIOHelper *io = [[FileIOHelper alloc] initWithRoot:[FileIOHelper.documentPath stringByAppendingPathComponent:@"data/imgs"] ];
    NSLog(@"io path :%@", io.path);
    NSString *uuid = [[NSUUID UUID] UUIDString];
    [io saveData:[@"ss" dataUsingEncoding:NSUTF8StringEncoding] forSubPath:[NSString stringWithFormat:@"ipicker/local/%@", uuid]];
    NSLog(@"root: %@", io.path);
    [io cleanAll];

    NSData *dt = nil;

//    UIImage *img = [UIImage imageNamed:@"erik-unsplash.jpg"];
//    CGFloat ratio = 0.7;
//    for (int i = 0; i < 1; i++) {
//        dt = UIImageJPEGRepresentation(img, ratio);
//        //[NSData dataWithContentsOfFile:[NSBundle.mainBundle pathForResource:@"erik" ofType:@""]];
//        //[NSData dataWithContentsOfFile:[NSBundle.mainBundle pathForResource:@"erik-unsplash" ofType:@"jpg"]];
//        //dt = [@"HeyJude." dataUsingEncoding:NSUTF8StringEncoding];
//        NSLog(@"%d dt: %lu", i, [dt length]);
//        img = [UIImage imageWithData:dt];
//        //ratio = 1.0;
//    }

    dt =
    //[@"HeyJude." dataUsingEncoding:NSUTF8StringEncoding];
    [NSData dataWithContentsOfFile:[NSBundle.mainBundle pathForResource:@"dat" ofType:@"txt"]];

    NSLog(@"dt: %lu", dt.length);
    NSError *err = nil;
    dt = [dt xcup_gzipDataError:&err];
    if (err) {
        NSLog(@"err: %@", err);
    }else {
        NSLog(@"dt: %lu", dt.length);
    }
    NSLog(@"dt gziped:\n%@", [NSString stringWithData:dt usingEncoding:NSUTF8StringEncoding]);

    err = nil;
    dt = [dt xcup_ungzipDataError:&err];
    if (err) {
        NSLog(@"err: %@", err);
    }else {
        NSLog(@"dt: %lu", dt.length);
    }

    NSLog(@"dt decompressed:\n%@", [NSString stringWithData:dt usingEncoding:NSUTF8StringEncoding]);

#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_10_0
    os_log_t log = OS_LOG_DEFAULT;
    os_log_info(log, "os log ..%s", __func__);
    os_log_error(log, "os log ..%s", __func__);
#else

#endif
    return YES;
}

- (void)handleTimer:(NSTimer *)timer
{

}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
	appLog(@"%s", __func__);
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
