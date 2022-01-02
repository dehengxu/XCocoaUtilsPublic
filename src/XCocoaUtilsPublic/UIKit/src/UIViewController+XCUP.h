//
//  UIViewController+Utils.h
//  MKTest
//
//  Created by Deheng.Xu on 12-11-5.
//  Copyright (c) 2012年 Deheng.Xu. All rights reserved.
//

#if TARGET_OS_IPHONE

#import <UIKit/UIKit.h>

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

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (XCUP)

//+ (NSString *)xibFileNameDefaultSuffix;
//+ (instancetype)viewControllerWithNibName:(NSString *)nibName bundle:(NSBundle *)nibBundleOrNil;

//- (BOOL)isSupportInteractivePopGestureRecognizer;

//- (UINavigationController* __nonnull)xcup_navigationController;

//- (instancetype)xcup_present:(UIViewController*)presentedViewController animated:(BOOL)animated orNeedNavigation:(BOOL)needed completion:(void(^ __nullable)(void))completion;

//- (instancetype)xcup_present:(UIViewController*)presentedViewController animated:(BOOL)animated modalStyle:(UIModalPresentationStyle)presentationStyle transitionStyle:(UIModalTransitionStyle)transitionStyle orNeedNavigation:(BOOL)needed completion:(void(^ __nullable)(void))completion;

//- (instancetype)xcup_present:(UIViewController*)presentedViewController animated:(BOOL)animated completion:(void(^ __nullable)(void))completion;
//- (instancetype)xcup_dismissViewController:(BOOL)animated completion:(void(^ __nullable)(void))completion;

@end

NS_ASSUME_NONNULL_END

#endif
