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

#import <UIKit/UIKit.h>

#define ASSERT_LOADING  0

#if TARGET_OS_IPHONE

@implementation UIViewController (XCUP)

+ (NSString *)xibFileNameDefaultSuffix
{
    return ([[[[UIDevice currentDevice] model] lowercaseString] rangeOfString:@"ipad"].length > 0) ? @"iPad" : @"iPhone";
}

+ (id)viewControllerWithNibName:(NSString *)nibName bundle:(NSBundle *)nibBundleOrNil
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

@end
#endif
