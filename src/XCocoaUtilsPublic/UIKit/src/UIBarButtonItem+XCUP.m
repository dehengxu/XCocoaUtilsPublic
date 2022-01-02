//
//  UIBarButtonItem+XCUP.m
//  XCocoaUtilsPublic
//
//  Created by Deheng Xu on 2020/10/25.
//

#import "UIBarButtonItem+XCUP.h"

CGSize XCUPDefaultBarButtonItemSize = (CGSize){44.0, 44.0};

//@implementation UIBarButtonItem (XCUP)
//
//- (instancetype)initWithXCUPTitle:(NSString *)title target:(id)target selector:(SEL)selector buttonSize:(CGSize)size buttonType:(UIButtonType)type forEvent:(UIControlEvents)event {
//	UIButton *btn = [UIButton buttonWithType:type];
//	CGRect f = {CGPointZero, size};
//	btn.frame = f;
//	[btn setTitle:title forState:UIControlStateNormal];
//	[btn addTarget:target action:selector forControlEvents:event];
//	self = [self initWithCustomView:btn];
//	return self;
//}
//
//- (instancetype)initWithXCUPTitle:(NSString *)title target:(id)target selector:(SEL)selector buttonSize:(CGSize)size buttonType:(UIButtonType)type {
//	return [self initWithXCUPTitle:title target:target selector:selector buttonSize:size buttonType:type forEvent:UIControlEventTouchUpInside];
//}
//
//- (instancetype)initWithXCUPTitle:(NSString *)title target:(id)target selector:(SEL)selector buttonSize:(CGSize)size {
//	return [self initWithXCUPTitle:title target:target selector:selector buttonSize:size buttonType:UIButtonTypeSystem];
//}
//
//- (instancetype)initWithXCUPTitle:(NSString *)title target:(id)target selector:(SEL)selector {
//	return [self initWithXCUPTitle:title target:target selector:selector buttonSize:XCUPDefaultBarButtonItemSize];
//}
//
//- (UIButton *)xcup_customButton {
//	if ([self.customView isKindOfClass:UIButton.class]) {
//		return self.customView;
//	}
//	return nil;
//}
//@end
