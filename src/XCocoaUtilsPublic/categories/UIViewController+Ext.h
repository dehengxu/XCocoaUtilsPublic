//
//  UIViewController+Utils.h
//  MKTest
//
//  Created by Deheng.Xu on 12-11-5.
//  Copyright (c) 2012年 Deheng.Xu. All rights reserved.
//

#if TARGET_OS_IPHONE

#import <UIKit/UIKit.h>
#import "FunctionSet.h"
/* Fix: Implicit declaration of method 'osVersion' in C99 */
//#import "UIDevice+Ext.h"

#define VIEW_DID_UNLOAD_FUNCTION()   do{\
if ([[[UIDevice currentDevice] systemVersion] floatValue] < 6.0) {\
if ([self isViewLoaded] && ![[self view] window]) {\
[self viewDidUnload];\
}\
}\
}\
while(0)

@interface UIViewController (Ext)

+ (NSString *)xibFileNameDefaultSuffix;
+ (id)viewControllerWithNibName:(NSString *)nibName bundle:(NSBundle *)nibBundleOrNil;

- (BOOL)isSupportInteractivePopGestureRecognizer;

@end

#endif
