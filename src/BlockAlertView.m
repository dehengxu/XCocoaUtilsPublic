//
//  BlockAlertView.m
//  ComputeDays
//
//  Created by Deheng.Xu on 13-5-22.
//  Copyright (c) 2013年 Nicholas.Xu. All rights reserved.
//

#import "BlockAlertView.h"

#import "UIAlertView+Ext.h"

@implementation BlockAlertView

+ (id)alertViewWithTitle:(NSString *)title message:(NSString *)message cancelBlock:(AlertCancelBlock)cancelBlock otherBlock:(AlertOtherBlock)otherBlock cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ...
{
    BlockAlertView *alert = [[BlockAlertView alloc] initWithTitle:title message:message delegate:nil cancelBlock:cancelBlock otherBlock:otherBlock cancelButtonTitle:cancelButtonTitle otherButtonTitles:otherButtonTitles, nil];
    alert.delegate = alert;
    return alert;
}

+ (id)showAlertViewWithTitle:(NSString *)title message:(NSString *)message cancelBlock:(AlertCancelBlock)cancelBlock otherBlock:(AlertOtherBlock)otherBlock cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ...
{
    BlockAlertView *alert = [self alertViewWithTitle:title message:message cancelBlock:cancelBlock otherBlock:otherBlock cancelButtonTitle:cancelButtonTitle otherButtonTitles:otherButtonTitles, nil];
    if (![NSThread isMainThread]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [alert show];
        });
    }else {
        [alert show];
    }
    return alert;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithTitle:(NSString *)title message:(NSString *)message delegate:(id)delegate cancelBlock:(AlertCancelBlock)cancelBlock otherBlock:(AlertOtherBlock)otherBlock cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ...
{
    self = [super initWithTitle:title message:message delegate:nil cancelButtonTitle:cancelButtonTitle otherButtonTitles:otherButtonTitles, nil];
    
    if (self) {
        self.delegate = self;
        self.cancelBlock = cancelBlock;
        self.otherBlock = otherBlock;
    }
    
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (self.cancelBlock) {
        self.cancelBlock();
    }
    if (self.otherBlock) {
        self.otherBlock(buttonIndex);
    }
}

@end
