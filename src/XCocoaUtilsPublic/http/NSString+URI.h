//
//  NSString+URI.h
//  XCocoaUtilsPublic
//
//  Created by NicholasXu on 2018/12/17.
//
//  URI Encoding : https://tools.ietf.org/html/rfc3986#page-12
//
//  CFURLCreateStringByReplacingPercentEscapes

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (URI)

+ (NSString *)xcup_reservedCharacters;
+ (NSString *)xcup_unreservedCharacters;
+ (NSString *)xcup_lowerCaseCharacters;
+ (NSString *)xcup_upperCaseCharacters;
+ (NSString *)xcup_alphaCharacters;
+ (NSString *)xcup_digitCharacters;

- (NSString *)xcup_URLEncoding;
- (NSString *)xcup_URLDecoding;
- (NSString *)xcup_UTF8AddingPercentEscape;
- (NSString *)xcup_UTF8RemovingPercentEscape;

@end

NS_ASSUME_NONNULL_END
