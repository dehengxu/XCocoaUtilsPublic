//
//  XCUFoundation.m
//  Pods
//
//  Created by NicholasXu on 2020/9/24.
//

#import "XCUFoundation.h"

inline NSString* xcu_NSStringFromBool(BOOL b) {
    return b ? @"YES" : @"NO";
}

inline const char *xcu_CStringFromNSString(NSString *string) {
    return [string cStringUsingEncoding:NSUTF8StringEncoding];
}

@implementation XCUFoundation

@end
