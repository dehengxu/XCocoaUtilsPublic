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
#import "NSObject+Ext.h"
#import "memory_macros.h"


/*
 URI encoding under rfc3986
 
 https://tools.ietf.org/html/rfc3986#page-12
 */
__unused static NSString * const lowerCase = @"abcdefghijklmnopqrstuvwxyz";
__unused static NSString * const upperCase = @"ABCDEFTHIJKLMNOPQRSTUVWXYZ";
__unused static NSString * const numbers = @"0123456789";
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

@implementation NSString (URI)

- (NSString *)xcup_URLEncoding
{
    //rfc3986: https://tools.ietf.org/html/rfc3986#page-12
    
    if (@available(iOS 9, *)) {
        NSString *rtn = NSStringByCFStringRef(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)self, NULL, (CFStringRef)reserved, kCFStringEncodingUTF8));
        return XAutorelease(rtn);
    }
    
    static NSCharacterSet *charset = nil;
    if (!charset) {
        charset = [NSCharacterSet characterSetWithCharactersInString:reserved];
    }
    return [self stringByAddingPercentEncodingWithAllowedCharacters:charset];
}

- (NSString *)xcup_URLDecoding
{
    if (@available(iOS 7, macOS 10.9, tvOS 9.0, watchOS 2.0, *)) {
        return [self stringByRemovingPercentEncoding];
    }
    
    return [self stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

- (NSString *)xcup_UTF8AddingPercentEscape
{
    if (@available(iOS 2, macOS 10.11, tvOS 9.0, watchOS 2.0, *)) {
        return [self stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    }

    static NSCharacterSet *charset = nil;
    if (!charset) {
        [NSCharacterSet characterSetWithCharactersInString:@""];
    }
    return [self stringByAddingPercentEncodingWithAllowedCharacters:charset];
}

- (NSString *)xcup_UTF8RemovingPercentEscape
{
    if (@available(iOS 2.0, *)) {
        return [self stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    }
    
    return [self stringByRemovingPercentEncoding];
}

@end
