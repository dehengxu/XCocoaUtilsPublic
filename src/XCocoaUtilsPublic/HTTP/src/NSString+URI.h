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

NS_ASSUME_NONNULL_BEGIN

@interface NSString (XCUP_URI)

+ (NSCharacterSet *)xcup_reservedCharacters;
+ (NSCharacterSet *)xcup_genericDelimiters;
+ (NSCharacterSet *)xcup_subDelimiters;

//+ (NSString*)xcup_unreservedCharacters;
//+ (NSString*)xcup_lowerCaseCharacters;
//+ (NSString*)xcup_upperCaseCharacters;
//+ (NSString*)xcup_alphaCharacters;
//+ (NSString*)xcup_digitCharacters;

- (NSString*)xcup_URLEncoding;
- (NSString*)xcup_URLDecoding;
- (NSString*)xcup_stringWithHTTP_Scheme;
- (NSString*)xcup_stringWithHTTPS_Scheme;

@end

@interface NSString (XCUP_URL)

- (NSURL * _Nullable)xcup_URL;
- (NSURL * _Nullable)xcup_httpsURL;
- (NSURL * _Nullable)xcup_httpURL;

@end

NS_ASSUME_NONNULL_END
