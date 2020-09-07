//
//  UIAlertView+Util.m
//  iSensorTest
//
//  Created by Deheng.Xu on 13-4-26.
//  Copyright (c) 2013年 Nicholas.Xu. All rights reserved.
//

#import "UIAlertView+XCUP.h"

#import "../../Macros/src/memory_macros.h"

#if TARGET_OS_IPHONE

@implementation UIAlertView (XCUP)

+ (void)showAlertViewWithTitle:(NSString *)title message:(NSString *)message delegate:(id<UIAlertViewDelegate>)delegate cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ...
{
    UIAlertView *alert = [self alertViewWithTitle:title message:message delegate:delegate cancelButtonTitle:cancelButtonTitle otherButtonTitles:otherButtonTitles, nil];
    dispatch_async(dispatch_get_main_queue(), ^{
        [alert show];
    });
}

+ (UIAlertView *)alertViewWithTitle:(NSString *)title message:(NSString *)message delegate:(id <UIAlertViewDelegate>)delegate cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ...
{
    id alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:delegate cancelButtonTitle:cancelButtonTitle otherButtonTitles:otherButtonTitles, nil];
    return XAutorelease(alert);
}

@end

#endif
