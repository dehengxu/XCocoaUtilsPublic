//
//  UIFont+Ext.h
//  XUtils
//
//  Created by Deheng.Xu on 13-6-19.
//
//

//#import <Foundation/Foundation.h>

#if __is_target_vendor(apple)

#if __has_include(<TargetConditionals.h>)
#import <TargetConditionals.h>
#endif

#if TARGET_OS_IOS

#import <UIKit/UIKit.h>

@interface UIFont (XCUP)

- (NSDictionary *)fontFamily;

@end

#endif //#if TARGET_OS_IOS

#endif // #if __is_target_vendor(apple)
