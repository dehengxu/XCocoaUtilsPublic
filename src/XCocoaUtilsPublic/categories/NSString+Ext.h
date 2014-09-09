//
//  NSString+Utils.h
//  WebViewCache
//
//  Created by Xu Nicholas on 11-7-3.
//  Copyright 2011年 Deheng.Xu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonHMAC.h>

extern NSString* NSStringFromBool(BOOL bValue);

extern const char *CStringFromNSString(NSString *string);

@interface NSString (Ext)

+ (NSString*)stringWithData:(NSData *)data usingEncoding:(NSStringEncoding)encoding;

- (NSString*)md5Digest;
- (NSString *)urlEncoding;
- (NSString *)urlDecoding;
- (NSURL*)URL;
- (NSString*)urlString;
- (NSString*)urlParamsString;

- (NSURL*)HTTPURL;
- (NSString*)httpUrl;
- (NSString*)replaceSpecialCharacters;

- (NSDate*)date;
- (NSDate *)dateWithFormatString:(NSString *)formatString;
- (NSString *)stringByRemoveHTMLTags;
- (NSString *)stringByRemoveHTMLTag:(NSString *)tag;

@end

@interface NSMutableString (Utils)

- (void)appendLineString:(NSString*)string;
- (void)appendLineFormat:(NSString*)format, ...;
- (void)appendURLParameter:(NSString*)string;
- (void)appendPOSTFormat:(NSString*)format, ...;

@end

