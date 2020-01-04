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
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_10_0
    os_log_t log = OS_LOG_DEFAULT;
    os_log_info(log, "os log ..%s", __func__);
    os_log_error(log, "os log ..%s", __func__);
#else
    NSLog(@"");
#endif
    return YES;
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
