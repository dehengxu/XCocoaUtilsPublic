//
//  BenchMark.m
//  oc_test
//
//  Created by Deheng Xu on 2018/9/18.
//  Copyright © 2018年 DehengXu. All rights reserved.
//

#import "BenchMark.h"

@implementation BenchMark

+ (instancetype)instanceWithUnit:(BenchMarkTimeUnit)unit
{
    BenchMark *b = [BenchMark new];
    b.unit = unit;
    return b;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _tag = @"BenchMark";
    }
    return self;
}

- (void)benchMarkTag:(NSString *)aTag targetBlock:(nonnull void (^)(void))benchblock repeat:(NSUInteger)times
{
    _tag = aTag;
    printf("[%s]\n", [_tag cStringUsingEncoding:NSUTF8StringEncoding]);
    [self benchMark:benchblock repeat:times];
}

- (void)benchMark:(nonnull void (^)(void))benchblock repeat:(NSUInteger)times
{
    printf("\tRunning:\n");
    NSAssert(times < NSUIntegerMax, @"\"times\" cannot be greater than NSUIntegerMax.");
	NSTimeInterval t0;
	NSDate *date0;
	NSUInteger repeat = times;
	date0 = [NSDate date];
	while(repeat) {
		benchblock();
		repeat--;
	}
	t0 = [[NSDate date] timeIntervalSinceDate:date0];
    
    if (_unit == BenchMark_SEC) {
        printf("\t%s repeat %lu times, time cost:%f(s), single task time cost:%f(s)\n", [_tag cStringUsingEncoding:NSUTF8StringEncoding], (unsigned long)times, t0, (t0 / times));
    }else if (_unit == BenchMark_MSEC) {
        printf("\t%s repeat %lu times, time cost:%f(s), single task time cost:%f(ms)\n", [_tag cStringUsingEncoding:NSUTF8StringEncoding], (unsigned long)times, t0, (t0 * 1e3 / times));
    }else {
        printf("\t%s repeat %lu times, time cost:%f(s), single task time cost:%f(us)\n", [_tag cStringUsingEncoding:NSUTF8StringEncoding], (unsigned long)times, t0, (t0 * 1e6 / times));
    }
    printf("\n");
}

@end
