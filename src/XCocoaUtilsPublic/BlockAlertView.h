//
//  BlockAlertView.h
//  ComputeDays
//
//  Created by Deheng.Xu on 13-5-22.
//  Copyright (c) 2013年 Nicholas.Xu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^AlertCancelBlock)(void);
typedef void(^AlertOtherBlock)(int index);

@interface BlockAlertView : UIAlertView<UIAlertViewDelegate>
@property (nonatomic, copy) void(^cancelBlock)(void);
@property (nonatomic, copy) void(^otherBlock)(int index);

+ (id)showAlertViewWithTitle:(NSString *)title message:(NSString *)message cancelBlock:(AlertCancelBlock)cancelBlock otherBlock:(AlertOtherBlock)otherBlock cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION;

+ (id)alertViewWithTitle:(NSString *)title message:(NSString *)message cancelBlock:(AlertCancelBlock)cancelBlock otherBlock:(AlertOtherBlock)otherBlock cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION;

- (id)initWithTitle:(NSString *)title message:(NSString *)message delegate:(id)delegate cancelBlock:(AlertCancelBlock)cancelBlock otherBlock:(AlertOtherBlock)otherBlock cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION;



@end
