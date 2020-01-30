//
//  NSData+XCUPCompress.m
//  XCocoaUtilsPublic
//
//  Created by Deheng Xu on 2020/1/30.
//  Copyright © 2020 Deheng.Xu. All rights reserved.
//

#import "NSData+XCUPGzip.h"

#define DATA_CHUNK_SIZE 262144 // Deal with gzipped data in 256KB chunks
#define COMPRESSION_AMOUNT Z_DEFAULT_COMPRESSION

@implementation NSData (XCUPGzip)

- (NSData *)gzipDataError:(NSError *__autoreleasing  _Nullable *)error
{
    if (self.length == 0) return nil;
    NSUInteger halfLength = (self.length >> 1);
    NSMutableData *outputData = [NSMutableData dataWithLength:halfLength];

    z_stream zStream;

    zStream.zalloc = Z_NULL;
    zStream.zfree = Z_NULL;
    zStream.opaque = Z_NULL;
    zStream.avail_in = 0;
    zStream.next_in = 0;
    int status = deflateInit2(&zStream, COMPRESSION_AMOUNT, Z_DEFLATED, (15+16), 8, Z_DEFAULT_STRATEGY);

    zStream.next_in = (Bytef *)self.bytes;
    zStream.avail_in = (unsigned int)self.length;
    zStream.avail_out = 0;

    NSInteger bytesProcessedAlready = zStream.total_out;
    BOOL shouldFinish = YES;
    while (zStream.avail_out == 0) {

        if (zStream.total_out-bytesProcessedAlready >= [outputData length]) {
            [outputData increaseLengthBy:halfLength];
        }

        zStream.next_out = (Bytef*)[outputData mutableBytes] + zStream.total_out-bytesProcessedAlready;
        zStream.avail_out = (unsigned int)([outputData length] - (zStream.total_out-bytesProcessedAlready));
        status = deflate(&zStream, shouldFinish ? Z_FINISH : Z_NO_FLUSH);

        if (status == Z_STREAM_END) {
            break;
        } else if (status != Z_OK) {
            if (error) {
                *error = [NSError errorWithDomain:@"Compress failed." code:status userInfo:nil];
            }
            return nil;
        }
    }

    [outputData setLength: zStream.total_out-bytesProcessedAlready];

    status = deflateEnd(&zStream);

    return outputData;
}

- (NSData *)ungzipDataError:(NSError *__autoreleasing  _Nullable *)error
{
    if (self.length == 0) return nil;

    NSUInteger halfLength = self.length/2;
    NSMutableData *outputData = [NSMutableData dataWithLength:self.length+halfLength];

    int status;
    z_stream zStream;

    // Setup the inflate stream
    zStream.zalloc = Z_NULL;
    zStream.zfree = Z_NULL;
    zStream.opaque = Z_NULL;
    zStream.avail_in = 0;
    zStream.next_in = 0;
    status = inflateInit2(&zStream, (15+32));
    if (status != Z_OK) {
        return nil;
    }

    zStream.next_in = (Bytef*)self.bytes;
    zStream.avail_in = (unsigned int)self.length;
    zStream.avail_out = 0;

    NSInteger bytesProcessedAlready = zStream.total_out;
    while (zStream.avail_in != 0) {

        if (zStream.total_out-bytesProcessedAlready >= [outputData length]) {
            [outputData increaseLengthBy:halfLength];
        }

        zStream.next_out = (Bytef*)[outputData mutableBytes] + zStream.total_out-bytesProcessedAlready;
        zStream.avail_out = (unsigned int)([outputData length] - (zStream.total_out-bytesProcessedAlready));

        status = inflate(&zStream, Z_NO_FLUSH);

        if (status == Z_STREAM_END) {
            break;
        } else if (status != Z_OK) {
            if (error) {
                *error = [NSError errorWithDomain:@"Decompress failed." code:status userInfo:nil];
            }
            return nil;
        }
    }

    // Set real length
    [outputData setLength: zStream.total_out-bytesProcessedAlready];
    return outputData;}

@end
