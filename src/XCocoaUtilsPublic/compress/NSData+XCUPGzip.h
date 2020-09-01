//
//  NSData+XCUPCompress.h
//  XCocoaUtilsPublic
//
//  Created by Deheng Xu on 2020/1/30.
//  Copyright © 2020 Deheng.Xu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <zlib.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSData (XCUPGzip)

- (NSData *)gzipDataError:(NSError **)error;
- (NSData *)ungzipDataError:(NSError **)error;

@end

NS_ASSUME_NONNULL_END
