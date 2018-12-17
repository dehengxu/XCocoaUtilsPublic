//
//  NSString+URI.h
//  XCocoaUtilsPublic
//
//  Created by NicholasXu on 2018/12/17.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (URI)

- (NSString *)xcup_URLEncoding;
- (NSString *)xcup_URLDecoding;
- (NSString *)xcup_UTF8AddingPercentEscape;
- (NSString *)xcup_UTF8RemovingPercentEscape;

@end

NS_ASSUME_NONNULL_END
