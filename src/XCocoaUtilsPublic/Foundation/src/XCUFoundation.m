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

@implementation NSBundle (XCUP)

- (NSString *)contentStringWithName:(NSString *)fileName extension:(NSString *)extension error:(NSError * _Nullable *)error {
    NSString* path = [self pathForResource:fileName ofType:extension];
    return [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:error];
}

@end
