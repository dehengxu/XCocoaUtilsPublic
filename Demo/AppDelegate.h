//
//  AppDelegate.h
//  Demo
//
//  Created by NicholasXu on 15/9/1.
//  Copyright (c) 2015年 Deheng.Xu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCocoaUtilsPublic/XCocoaUtilsPublic.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) XCUPSafeTimer *timer;
@property (strong, nonatomic) NSTimer *nstimer;

@end

