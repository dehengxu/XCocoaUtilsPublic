//
//  main.m
//  DemoMacOSCmd
//
//  Created by NicholasXu on 2020/6/15.
//  Copyright © 2020 Deheng.Xu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <XCocoaUtilsPublic/XCUPIO.h>
#import <XCocoaUtilsPublic/XLogging.h>
#import <XCocoaUtilsPublic/XCUPBenchmark.h>
#import <XCocoaUtilsPublic/XCUPHttp.h>
#import <XCocoaUtilsPublic/NSData+XCUPGzip.h>

NSDictionary *data;

void testKeyPath(benchmark_t b) {
    [data valueForKeyPath:@"data"];
}

void testKey(benchmark_t b) {
    [data valueForKey:@"data"];
}


int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        CLog(@"Hello, World!");
        const long max = 1024 * 1024 * 32;
        data = @{
            @"count":@(10),
            @"data" : @{
                    @"name": @"Nk",
            }
        };
        
        //benchMark("KeyPath data.name", testKeyPath, max);
        bench_mark_clock("KeyPath data.name", testKeyPath, max);
        //benchMark("Key", testKey, max);
        NSString *urlEncoded = @"%12%09%08%9C%F8%E8%C8%FC%09%20O%18%AF*";
        urlEncoded = @"%12%09%08%9C%F8%E8%C8%FC%09%20O%18%AF*|%12%09%08%9C%F8%E8%C8%FC%09%20O%18%AF*|%12%09%08%9C%F8%E8%C8%FC%09%20O%18%AF*";
        NSData *strData = [urlEncoded dataUsingEncoding:NSUTF8StringEncoding];
        {
            NSError *error = nil;
            NSData *gziped = [strData gzipDataError:&error];
            if (!error) {
                CLog(@"%lu / %lu, compress ratio: %f", gziped.length, strData.length, gziped.length * 1.0 / strData.length);
            }
        }
        //CLog(@"url dec :%@", [urlEncoded xcup_URLDecoding]);
        DefaultSettings *settings = [DefaultSettings sharedInstance];
        [settings setObject:@(7) forKey:@"num" immediately:true];
        //[settings setObject:nil forKey:@"num" immediately:true];
        [settings removeObjectForKey:@"num"];
        id n = [settings objectForKey:@"num"];
        CLog(@"n :%@", n);
        
    }
    return 0;
}
