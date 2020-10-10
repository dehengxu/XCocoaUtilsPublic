//
//  NSData+String.h
//  XUtils
//
//  Created by Xu Deheng on 12-5-10.
//  Copyright (c) 2012年 __MyCompany__ All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (XCUString)
- (NSString *)xcup_utf8String;
- (NSString *)xcup_stringByEncoding:(NSStringEncoding)encoding;
@end
