//
//  UIViewController+Utils.m
//  MKTest
//
//  Created by Deheng.Xu on 12-11-5.
//  Copyright (c) 2012年 Deheng.Xu. All rights reserved.
//

#import "UIViewController+XCUP.h"
#import "NSObject+XCUP.h"
#import "XCUPMacros.h"

#define ASSERT_LOADING  0

#if TARGET_OS_IPHONE

#import <UIKit/UIKit.h>

@implementation UIViewController (XCUP)

//+ (NSString *)xibFileNameDefaultSuffix
//{
//    return ([[[[UIDevice currentDevice] model] lowercaseString] rangeOfString:@"ipad"].length > 0) ? @"iPad" : @"iPhone";
//}

//+ (instancetype)viewControllerWithNibName:(NSString *)nibName bundle:(NSBundle *)nibBundleOrNil
//{
//    id rtn = nil;
//    NSString *suffix = [self xibFileNameDefaultSuffix];
//    
//#if ASSERT_LOADING
//        NSAssert(([[NSFileManager defaultManager] fileExistsAtPath:[[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@_%@", nibName, suffix] ofType:@"nib"]] == YES), @"Nib file '%@' does not exist!", nibName);
//#endif
//    if (![[NSFileManager defaultManager] fileExistsAtPath:[[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@_%@", nibName, suffix] ofType:@"nib"]]) {
//        rtn = [[self alloc] initWithNibName:nibName bundle:nibBundleOrNil];
//    }else {
//        rtn = [[self alloc] initWithNibName:[NSString stringWithFormat:@"%@_%@", nibName, suffix] bundle:nibBundleOrNil];
//    }
//    return XAutorelease(rtn);
//}

//- (BOOL)isSupportInteractivePopGestureRecognizer
//{
//    return ([self isKindOfClass:[UINavigationController class]] && [self respondsToSelector:@selector(interactivePopGestureRecognizer)]);
//}

//- (UINavigationController *)xcup_navigationController {
//	if (self.navigationController) {
//		return self.navigationController;
//	}else {
//		UINavigationController* nav = [[UINavigationController alloc] initWithRootViewController:self];
//		return nav;
//	}
//}

//- (instancetype)xcup_present:(UIViewController *)presentedViewController animated:(BOOL)animated orNeedNavigation:(BOOL)needed completion:(void (^)(void))completion {
//	if (self.navigationController) {
//		if (needed) {
//			[self.navigationController pushViewController:presentedViewController animated:animated];
//		}else {
//			[self presentViewController:presentedViewController animated:animated completion:completion];
//		}
//	}else {
//		if (needed) {
//            if ([self isKindOfClass:UINavigationController.class]) {
//                [(UINavigationController*) self pushViewController:presentedViewController animated:animated];
//            }else {
//                UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:presentedViewController];
//                [self presentViewController:nav animated:animated completion:completion];
//            }
//		}else {
//			[self presentViewController:presentedViewController animated:animated completion:completion];
//		}
//	}
//	return self;
//}

//- (instancetype)xcup_present:(UIViewController *)presentedViewController animated:(BOOL)animated modalStyle:(UIModalPresentationStyle)presentationStyle transitionStyle:(UIModalTransitionStyle)transitionStyle orNeedNavigation:(BOOL)needed completion:(void (^)(void))completion {
//	if (self.navigationController) {
//		if (needed) {
//			[self.navigationController pushViewController:presentedViewController animated:animated];
//		}else {
//			presentedViewController.modalPresentationStyle = presentationStyle;
//			presentedViewController.modalTransitionStyle = transitionStyle;
//			[self presentViewController:presentedViewController animated:animated completion:completion];
//		}
//	}else {
//		if (needed) {
//			if ([self isKindOfClass:UINavigationController.class]) {
//				[(UINavigationController*) self pushViewController:presentedViewController animated:animated];
//			}else {
//				UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:presentedViewController];
//				nav.modalPresentationStyle = presentationStyle;
//				nav.modalTransitionStyle = transitionStyle;
//				[self presentViewController:nav animated:animated completion:completion];
//			}
//		}else {
//			[self presentViewController:presentedViewController animated:animated completion:completion];
//		}
//	}
//	return self;
//}

//- (instancetype)xcup_present:(UIViewController *)presentedViewController animated:(BOOL)animated completion:(void (^)(void))completion {
//	if (presentedViewController.navigationController) {
//		[self presentViewController:presentedViewController.navigationController animated:animated completion:completion];
//	}else {
//		[self presentViewController:presentedViewController animated:animated completion:completion];
//	}
//	return self;
//}

//- (instancetype)xcup_dismissViewController:(BOOL)animated completion:(void (^)(void))completion {
//	if (self.navigationController) {
//		[self.navigationController dismissViewControllerAnimated:animated completion:completion];
//	}else {
//		[self dismissViewControllerAnimated:animated completion:completion];
//	}
//	return self;
//}

@end
#endif
