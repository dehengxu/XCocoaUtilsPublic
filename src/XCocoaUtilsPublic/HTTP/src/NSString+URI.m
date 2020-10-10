//
//  NSString+URI.m
//  XCocoaUtilsPublic
//
//  Created by NicholasXu on 2018/12/17.
//

#import "NSString+URI.h"
#import <AvailabilityInternal.h>
#import <availability.h>
#import "CF_macros.h"
#import "NSObject+XCUP.h"
#import "memory_macros.h"


/*
 URI encoding under rfc3986
 
 https://tools.ietf.org/html/rfc3986#page-12
 */
__unused static NSString * const lowerCase = @"abcdefghijklmnopqrstuvwxyz";
__unused static NSString * const upperCase = @"ABCDEFTHIJKLMNOPQRSTUVWXYZ";
__unused static NSString * const digit = @"0123456789";

/*
 Unreserved Characters
 
 Characters that are allowed in a URI but do not have a reserved
 purpose are called unreserved.  These include uppercase and lowercase
 letters, decimal digits, hyphen, period, underscore, and tilde.
 
 unreserved  = ALPHA / DIGIT / "-" / "." / "_" / "~"
 
 
 
 
 
 Berners-Lee, et al.         Standards Track                    [Page 13]
 
 RFC 3986                   URI Generic Syntax               January 2005
 
 
 URIs that differ in the replacement of an unreserved character with
 its corresponding percent-encoded US-ASCII octet are equivalent: they
 identify the same resource.  However, URI comparison implementations
 do not always perform normalization prior to comparison (see Section
 6).  For consistency, percent-encoded octets in the ranges of ALPHA
 (%41-%5A and %61-%7A), DIGIT (%30-%39), hyphen (%2D), period (%2E),
 underscore (%5F), or tilde (%7E) should not be created by URI
 producers and, when found in a URI, should be decoded to their
 corresponding unreserved characters by URI normalizers.
 */
__unused static NSString * const unreservedSymbols = @"-._~";
//unreserved = lowercase + uppercase + numbers + "-" + "." + "_" + "~"
//static NSString *unreserved = [NSString stringWithFormat:@"%@%@%@-._~", lowerCase, upperCase, numbers];

/*
 Unreserved Characters
 
 Characters that are allowed in a URI but do not have a reserved
 purpose are called unreserved.  These include uppercase and lowercase
 letters, decimal digits, hyphen, period, underscore, and tilde.
 
 unreserved  = ALPHA / DIGIT / "-" / "." / "_" / "~"
 
 */
__unused static NSString * const unreserved = @"abcdefghijklmnopqrstuvwxyzABCDEFTHIJKLMNOPQRSTUVWXYZ0123456789-._~";

/*
 Reserved Characters
 
 URIs include components and subcomponents that are delimited by
 characters in the "reserved" set.  These characters are called
 "reserved" because they may (or may not) be defined as delimiters by
 the generic syntax, by each scheme-specific syntax, or by the
 implementation-specific syntax of a URI's dereferencing algorithm.
 If data for a URI component would conflict with a reserved
 character's purpose as a delimiter, then the conflicting data must be
 percent-encoded before the URI is formed.
 
 Berners-Lee, et al.         Standards Track                    [Page 12]
 
 RFC 3986                   URI Generic Syntax               January 2005
 
 
 reserved    = gen-delims / sub-delims
 
 gen-delims  = ":" / "/" / "?" / "#" / "[" / "]" / "@"
 
 sub-delims  = "!" / "$" / "&" / "'" / "(" / ")"
 / "*" / "+" / "," / ";" / "="
 
 The purpose of reserved characters is to provide a set of delimiting
 characters that are distinguishable from other data within a URI.
 URIs that differ in the replacement of a reserved character with its
 corresponding percent-encoded octet are not equivalent.  Percent-
 encoding a reserved character, or decoding a percent-encoded octet
 that corresponds to a reserved character, will change how the URI is
 interpreted by most applications.  Thus, characters in the reserved
 set are protected from normalization and are therefore safe to be
 used by scheme-specific and producer-specific algorithms for
 delimiting data subcomponents within a URI.
 */
__unused static NSString * const reserved = @":/?#[]@!$&'()*+,;=";
__unused static NSString * const gen_delimiters = @":/?#[]@";
__unused static NSString * const sub_delimiters = @"!$&'()*+,;=";

@implementation NSString (XCUP_URI)

+ (NSCharacterSet *)xcup_reservedCharacters
{
    static NSCharacterSet* charset = nil;
    if (!charset) {
        charset = [NSCharacterSet characterSetWithCharactersInString:reserved];
    }
    return charset;
}

+ (NSCharacterSet *)xcup_genericDelimiters {
    static NSCharacterSet* charset = nil;
    if (!charset) {
        charset = [NSCharacterSet characterSetWithCharactersInString:gen_delimiters];
    }
    return charset;
}

+ (NSCharacterSet *)xcup_subDelimiters {
    static NSCharacterSet* charset = nil;
    if (!charset) {
        charset = [NSCharacterSet characterSetWithCharactersInString:sub_delimiters];
    }
    return charset;
}

+ (NSString *)xcup_unreservedCharacters
{
    static NSString *unreserved;
    if (!unreserved) {
        unreserved = [NSString stringWithFormat:@"%@%@%@%@", lowerCase, upperCase, digit, unreservedSymbols];
    }
    return unreserved;
}

+ (NSString *)xcup_lowerCaseCharacters
{
    return lowerCase;
}

+ (NSString *)xcup_upperCaseCharacters
{
    return upperCase;
}

+ (NSString *)xcup_alphaCharacters
{
    static NSString *alpha;
    if (!alpha) {
        alpha = [NSString stringWithFormat:@"%@%@", lowerCase, upperCase];
    }
    return alpha;
}

+ (NSString *)xcup_digitCharacters
{
    return digit;
}

- (NSString *)xcup_URLEncoding
{
    //rfc3986: https://tools.ietf.org/html/rfc3986#page-12
    if (@available(iOS 9, *)) {
        static NSCharacterSet *charset = nil;
        if (!charset) {
            charset = [NSCharacterSet characterSetWithCharactersInString:reserved];
        }
        return [self stringByAddingPercentEncodingWithAllowedCharacters:charset];
    }
    
    NSString *rtn = NSStringByCFStringRef(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)self, NULL, (CFStringRef)reserved, kCFStringEncodingUTF8));
    return XAutorelease(rtn);
}

- (NSString *)xcup_URLDecoding
{
    if (@available(iOS 7, macOS 10.11, tvOS 9.0, watchOS 2.0, *)) {
        return [self stringByRemovingPercentEncoding];
    }else {
        return [self stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    }
}

- (NSString *)xcup_UTF8AddingPercentEscape
{    
    if (@available(iOS 7, macOS 10.9, tvOS 9.0, watchOS 2.0, *)) {
        static NSCharacterSet *charset = nil;
        if (!charset) {
            charset = [NSCharacterSet characterSetWithCharactersInString:[NSString stringWithFormat:@"%@%@%@%@", lowerCase, upperCase, digit, reserved]];
        }
        return [self stringByAddingPercentEncodingWithAllowedCharacters:charset];
    }
    return [self stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

}

- (NSString *)xcup_UTF8RemovingPercentEscape
{
    if (@available(iOS 7, macOS 10.9, tvOS 9.0, watchOS 2.0, *)) {
        return [self stringByRemovingPercentEncoding];
    }else {
        return [self stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    }
}

- (NSString *)xcup_stringWithHTTP_Scheme {
    static NSString* httpPrefix = @"http://";

    if (self.length < httpPrefix.length) {
        return [NSString stringWithFormat:@"http://%@", self];
    }
    NSString* tmp = [[self substringToIndex:httpPrefix.length] lowercaseString];
    if ([tmp rangeOfString:@"http://"].location == 0) {
        return self;
    }

    return [NSString stringWithFormat:@"http://%@", self];
}

- (NSString *)xcup_stringWithHTTPS_Scheme {
    static NSString* httpsPrefix = @"https://";
    
    if (self.length < httpsPrefix.length) {
        return [NSString stringWithFormat:@"https://%@", self];
    }
    NSString* tmp = [[self substringToIndex:httpsPrefix.length] lowercaseString];
    if ([tmp rangeOfString:@"https://"].location == 0) {
        return self;
    }

    return [NSString stringWithFormat:@"https://%@", self];
}

@end

@implementation NSString (XCUP_URL)

- (NSURL *)xcup_URL
{
    return [NSURL URLWithString:self];
}

- (NSURL *)xcup_httpURL {
    return [[self xcup_stringWithHTTP_Scheme] xcup_URL];
}

- (NSURL *)xcup_httpsURL {
    return [[self xcup_stringWithHTTPS_Scheme] xcup_URL];
}

@end
