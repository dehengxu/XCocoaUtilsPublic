//
//  NSString+Utils.m
//  WebViewCache
//
//  Created by Xu Nicholas on 11-7-3.
//  Copyright 2011年 Deheng.Xu. All rights reserved.
//

#import "NSString+Ext.h"
#import "NSObject+Ext.h"
#import "FunctionSet.h"
#import "RegexKitLite.h"

extern inline NSString* NSStringFromBool(BOOL bValue)
{
    return (NSString *)(bValue ? @"YES" : @"NO");
}

extern inline const char *CStringFromNSString(NSString *string)
{
    return [string cStringUsingEncoding:NSUTF8StringEncoding];
}

@implementation NSString (Ext)

- (NSString*)md5Digest
{
	const char* cStr = [self UTF8String];
	unsigned char result[CC_MD5_DIGEST_LENGTH] = {
		0,
	};
	CC_MD5(cStr, strlen(cStr), (unsigned char *)result);
	
	return [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
			result[0], result[1], result[2], result[3],
			result[4], result[5], result[6], result[7],
			result[8], result[9], result[10], result[11],
			result[12], result[13], result[14], result[15]];
}

+ (NSString *)stringWithData:(NSData *)data usingEncoding:(NSStringEncoding)encoding
{
    return XAutorelease([[NSString alloc] initWithData:data encoding:encoding]);
}

+ (NSArray *)dateFormatters
{
    if (dateformatters == nil) {
        //Mon, 23 Sep 2013 16:07:35 +0800
		dateformatters = [[NSArray alloc] initWithObjects:
						  @"EEE, dd MMM yyyy hh:mm:ss z",
                          @"EEE, dd MMM yyyy HH:mm:ss Z",
						  @"EEE, dd MMM yyyy h:m:s z",
						  @"EEE, dd MMM yyyy H:m:s z",
						  @"EEE, d MMM yyyy HH:m:s z",
						  @"EEE, dd MMM yyyy",
						  @"EEE, MMM dd yyyy hh:mm:ss",
						  @"EEE, MMM dd yyyy H:mm:ss",
						  @"EEE, MMM dd yyyy H:mm:ss",
						  @"yyyy-mm-dd hh:mm:ss",
						  @"yyyy-mm-dd HH:mm:ss",
						  @"yyyy-mm-dd hh:mm:ss EEE",
						  nil];
	}
    return dateformatters;
}

- (NSString *)urlEncoding
{
    NSString *rtn = NSStringByCFStringRef(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)self, NULL, (CFStringRef)@"!*'();:@&=+$,/?%#[]", kCFStringEncodingUTF8));
    return XAutorelease(rtn);
}

- (NSString *)urlDecoding
{
    return [self stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

- (NSURL *)URL
{
    return [NSURL URLWithString:self];
}

- (NSString *)urlString
{
    NSArray *result = [self componentsSeparatedByString:@"?"];
    if (result.count > 0) {
        return [result objectAtIndex:0];
    }
    return nil;
}

- (NSString *)urlParamsString
{
    NSArray *result = [self componentsSeparatedByString:@"?"];
    if (result.count > 1) {
        return [result lastObject];
    }
    return nil;
}

- (NSURL *)HTTPURL
{
    return [[self httpUrl] URL];
}

- (NSString *)httpUrl
{
    static NSString *scheme = @"http://";
    static NSString *schemeS = @"https://";
    
    BOOL hasHttp = NO, hasHttps = NO;
    
    if ([self rangeOfString:schemeS].location == 0) {
        hasHttps = YES;
    }
    if (!hasHttps && [self rangeOfString:scheme].location == 0) {
        hasHttp = YES;
    }
    if (!hasHttp && !hasHttps && self.length > 0) {
        return [NSString stringWithFormat:@"http://%@", self];
    }
    return self;
}

// Use regexKitLite
//- (NSString *)httpUrl
//{
//    static NSString *scheme = @"^(http://){1}";
//    static NSString *schemes =  @"^(https://){1}";
//    BOOL hasHttp = NO, hasHttps = NO;
//
//    if ([self stringByMatching:schemes]) {
//        hasHttps = YES;
//    }
//    if (!hasHttps && [self stringByMatching:scheme]) {
//        hasHttp = YES;
//    }
//    if (!hasHttp && !hasHttps && self.length > 0) {
//        return [NSString stringWithFormat:@"http://%@", self];
//    }
//    return self;
//}


const static NSDictionary *specialChars = nil;
- (NSString *)replaceSpecialCharacters
{
    if (specialChars == nil) {
        specialChars = @{
                        @"&nbsp":@" ", @"&lt;":@"<", @"&gt;":@">",
                        @"&amp;":@"&", @"&quot;":@"\"",
                        
                        //
                        @"&#160;":@" "
                        };
#if !ARC_ENABLED
        [specialChars retain];
#endif
    }
    NSArray *theKeys = [specialChars allKeys];
    NSString *tmp = self;
    for (NSString *key in theKeys) {
        tmp = [tmp stringByReplacingOccurrencesOfString:key withString:[specialChars objectForKey:key]];
    }
    return tmp;
}

static NSArray *dateformatters = nil;
static NSDateFormatter *formatter = nil;
- (NSDate*)date
{
	NSDate *date = nil;
	
	for (int i = 0; i < [[NSString dateFormatters] count]; i++) {
		date = [self dateWithFormatString:[[NSString dateFormatters] objectAtIndex:i]];
		if (date) {
			break;
		}
	}

	return date;
}


/**
 Reference: http://www.w3.org/QA/Tips/iso-date
 */
- (NSDate *)dateWithFormatString:(NSString *)formatString
{
    if (dateformatters == nil) {
        //Mon, 23 Sep 2013 16:07:35 +0800
		dateformatters = [[NSArray alloc] initWithObjects:
						  @"EEE, dd MMM yyyy hh:mm:ss z",
                          @"EEE, dd MMM yyyy HH:mm:ss Z",
						  @"EEE, dd MMM yyyy h:m:s z",
						  @"EEE, dd MMM yyyy H:m:s z",
						  @"EEE, d MMM yyyy HH:m:s z",
						  @"EEE, dd MMM yyyy",
						  @"EEE, MMM dd yyyy hh:mm:ss",
						  @"EEE, MMM dd yyyy H:mm:ss",
						  @"EEE, MMM dd yyyy H:mm:ss",
						  @"yyyy-mm-dd hh:mm:ss",
						  @"yyyy-mm-dd HH:mm:ss",
						  @"yyyy-mm-dd hh:mm:ss EEE",
						  nil];
	}
    if (formatter == nil) {
        formatter =  [[NSDateFormatter alloc] init];
        [formatter setLocale:[[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"] autorelease]];
    }
    
    [formatter setDateFormat:formatString];
    return [formatter dateFromString:self];
}

- (NSString *)stringByRemoveHTMLTags
{
    NSString *tmp = [self stringByReplacingOccurrencesOfString:@"\n" withString:@""];

    tmp = [tmp stringByReplacingOccurrencesOfRegex:@"<.[^>]*>" withString:@""];
//    tmp = [tmp stringByReplacingOccurrencesOfRegex:@"</.>" withString:@""];
    
//    tmp = [tmp stringByRemoveHTMLTag:@"p"];
//    tmp = [tmp stringByRemoveHTMLTag:@"img"];
//    tmp = [tmp stringByRemoveHTMLTag:@"a"];
//    tmp = [tmp stringByRemoveHTMLTag:@"div"];
//    tmp = [tmp stringByRemoveHTMLTag:@"br"];
//    tmp = [tmp stringByRemoveHTMLTag:@"em"];
//    tmp = [tmp stringByRemoveHTMLTag:@"table"];
//    tmp = [tmp stringByRemoveHTMLTag:@"h1"];
//    tmp = [tmp stringByRemoveHTMLTag:@"h2"];
//    tmp = [tmp stringByRemoveHTMLTag:@"h3"];
//    tmp = [tmp stringByRemoveHTMLTag:@"h4"];
//    tmp = [tmp stringByRemoveHTMLTag:@"td"];
    
//    tmp = [tmp stringByReplacingOccurrencesOfRegex:@"<p[^>]*>" withString:@""];
//    tmp = [tmp stringByReplacingOccurrencesOfRegex:@"</p>" withString:@""];
//    tmp = [tmp stringByReplacingOccurrencesOfRegex:@"<img[^>]*>" withString:@""];
//    tmp = [tmp stringByReplacingOccurrencesOfRegex:@"</img>" withString:@""];
//    tmp = [tmp stringByReplacingOccurrencesOfRegex:@"<a[^>]*>" withString:@""];
//    tmp = [tmp stringByReplacingOccurrencesOfRegex:@"</a>" withString:@""];
//    tmp = [tmp stringByReplacingOccurrencesOfRegex:@"<div[^>]*>" withString:@""];
//    tmp = [tmp stringByReplacingOccurrencesOfRegex:@"</div>" withString:@""];
//    tmp = [tmp stringByReplacingOccurrencesOfRegex:@"<br[^>]*>" withString:@""];
//    tmp = [tmp stringByReplacingOccurrencesOfRegex:@"</br>" withString:@""];
//    tmp = [tmp stringByReplacingOccurrencesOfRegex:@"<em[^>]*>" withString:@""];
//    tmp = [tmp stringByReplacingOccurrencesOfRegex:@"</em>" withString:@""];
//    tmp = [tmp stringByReplacingOccurrencesOfRegex:@"<table[^>]*>" withString:@""];
//    tmp = [tmp stringByReplacingOccurrencesOfRegex:@"</table>" withString:@""];

    return tmp;
}

- (NSString *)stringByRemoveHTMLTag:(NSString *)tag
{
    NSString *tmp = self;
    tmp = [tmp stringByReplacingOccurrencesOfRegex:[NSString stringWithFormat:@"<%@[^>]*>", tag] withString:@""];
    tmp = [tmp stringByReplacingOccurrencesOfRegex:[NSString stringWithFormat:@"</%@>", tag] withString:@""];
    return tmp;
}

@end


@implementation NSMutableString (Utils)

- (void)appendLineString:(NSString *)string
{
    [self appendLineFormat:@"%@", string];
}

- (void)appendLineFormat:(NSString *)format, ...
{
    assert(format);
    
    va_list args;
    NSMutableString *rtn = nil;
    va_start(args, format);
    rtn = [[[NSMutableString alloc] initWithFormat:format arguments:args] autorelease];
    va_end(args);
    [rtn appendString:@"\n"];
    
    [self appendString:rtn];
}

- (void)appendURLParameter:(NSString *)string
{
    NSUInteger _segs = [self componentsSeparatedByString:@"?"].count;
    if (_segs > 2) {
        [self appendFormat:@"&%@", string];
    }else {
        if (_segs == 1) {
            [self appendFormat:@"?%@", string];
        }else if ([self hasSuffix:@"?"]) {
            [self appendFormat:@"%@", string];
        }else if ([self hasSuffix:@"&"]) {
            [self appendFormat:@"%@", string];
        }else {
            [self appendFormat:@"&%@", string];
        }
    }
}

- (void)appendPOSTFormat:(NSString *)format, ...
{
    //
    va_list args;
    NSMutableString *string = nil;
    va_start(args, format);
    string = [[[NSMutableString alloc] initWithFormat:format arguments:args] autorelease];
    va_end(args);
    
    if (string.length == 0) {
        return;
    }
    
    NSUInteger _segs = [self componentsSeparatedByString:@"&"].count;
    if (_segs > 2) {
        [self appendFormat:@"&%@", string];
    }else {
        if (self.length == 0) {//空字符串
            [self appendFormat:@"%@", string];
        }else if (_segs == 1) {
            [self appendFormat:@"&%@", string];
        }else if ([self hasSuffix:@"&"]) {
            [self appendFormat:@"%@", string];
        }else {
            [self appendFormat:@"&%@", string];
        }
    }
}

@end


