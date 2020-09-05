//
//  UIViewController+Utils.m
//  MKTest
//
//  Created by Deheng.Xu on 12-11-5.
//  Copyright (c) 2012年 Deheng.Xu. All rights reserved.
//

#import "UIViewController+XC.h"
#import "NSObject+XCUP.h"
#import "XCUPMacros.h"

#define ASSERT_LOADING  0

#if TARGET_OS_IPHONE

#import <UIKit/UIKit.h>

@implementation UIViewController (XCUP)

+ (NSString *)xibFileNameDefaultSuffix
{
    return ([[[[UIDevice currentDevice] model] lowercaseString] rangeOfString:@"ipad"].length > 0) ? @"iPad" : @"iPhone";
}

+ (instancetype)viewControllerWithNibName:(NSString *)nibName bundle:(NSBundle *)nibBundleOrNil
{
    id rtn = nil;
    NSString *suffix = [self xibFileNameDefaultSuffix];
    
#if ASSERT_LOADING
        NSAssert(([[NSFileManager defaultManager] fileExistsAtPath:[[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@_%@", nibName, suffix] ofType:@"nib"]] == YES), @"Nib file '%@' does not exist!", nibName);
#endif
    if (![[NSFileManager defaultManager] fileExistsAtPath:[[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@_%@", nibName, suffix] ofType:@"nib"]]) {
        rtn = [[self alloc] initWithNibName:nibName bundle:nibBundleOrNil];
    }else {
        rtn = [[self alloc] initWithNibName:[NSString stringWithFormat:@"%@_%@", nibName, suffix] bundle:nibBundleOrNil];
    }
    return XAutorelease(rtn);
}

- (BOOL)isSupportInteractivePopGestureRecognizer
{
    return ([self isKindOfClass:[UINavigationController class]] && [self respondsToSelector:@selector(interactivePopGestureRecognizer)]);
}

- (UINavigationController *)xc_navigationController {
	if (self.navigationController) {
		return self.navigationController;
	}else {
		UINavigationController* nav = [[UINavigationController alloc] initWithRootViewController:self];
		return nav;
	}
}

- (instancetype)xc_present:(UIViewController *)presentedViewController animated:(BOOL)animated needNavigation:(BOOL)needed completion:(void (^)(void))completion {
	if (self.navigationController) {
		[self presentViewController:self.navigationController animated:animated completion:completion];
	}else {
		if (needed) {
			UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:presentedViewController];
			[self presentViewController:nav animated:animated completion:completion];
		}else {
			[self presentViewController:presentedViewController animated:animated completion:completion];
		}
	}
	return self;
}

- (instancetype)xc_present:(UIViewController *)presentedViewController animated:(BOOL)animated completion:(void (^)(void))completion {
	if (presentedViewController.navigationController) {
		[self presentViewController:presentedViewController.navigationController animated:animated completion:completion];
	}else {
		[self presentViewController:presentedViewController animated:animated completion:completion];
	}
	return self;
}

- (instancetype)xc_dismissViewController:(BOOL)animated completion:(void (^)(void))completion {
	if (self.navigationController) {
		[self.navigationController dismissViewControllerAnimated:animated completion:completion];
	}else {
		[self dismissViewControllerAnimated:animated completion:completion];
	}
	return self;
}

@end
#endif
