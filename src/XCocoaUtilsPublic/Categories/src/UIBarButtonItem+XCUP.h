//
//  UIBarButtonItem+XCUP.h
//  XCocoaUtilsPublic
//
//  Created by Deheng Xu on 2020/10/25.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIBarButtonItem (XCUP)

- (instancetype)initWithXCUPTitle:(NSString*)title target:(id)target selector:(SEL)selector buttonSize:(CGSize)size buttonType:(UIButtonType)type forEvent:(UIControlEvents)event;

/// With default event upInside
/// @param title <#title description#>
/// @param target <#target description#>
/// @param selector <#selector description#>
/// @param size <#size description#>
/// @param type <#type description#>
- (instancetype)initWithXCUPTitle:(NSString*)title target:(id)target selector:(SEL)selector buttonSize:(CGSize)size buttonType:(UIButtonType)type;

/// With default buttonType .system
/// @param title <#title description#>
/// @param target <#target description#>
/// @param selector <#selector description#>
/// @param size <#size description#>
- (instancetype)initWithXCUPTitle:(NSString*)title target:(id)target selector:(SEL)selector buttonSize:(CGSize)size;

/// With default button size: 64x44
/// @param title <#title description#>
/// @param target <#target description#>
/// @param selector <#selector description#>
- (instancetype)initWithXCUPTitle:(NSString*)title target:(id)target selector:(SEL)selector;

- (nullable UIButton *)xcup_customButton;
@end

NS_ASSUME_NONNULL_END
