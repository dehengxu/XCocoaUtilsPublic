//
//  BenchMark.h
//  oc_test
//
//  Created by Deheng Xu on 2018/9/18.
//  Copyright © 2018年 DehengXu. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    BenchMark_SEC = 0,
    BenchMark_MSEC,
    BenchMark_USEC
} BenchMarkTimeUnit;

@interface BenchMark : NSObject

@property (assign, nonatomic) BenchMarkTimeUnit unit;
@property (readonly, copy, nonatomic) NSString * _Nullable tag;

+ (instancetype _Nullable )instanceWithUnit:(BenchMarkTimeUnit)unit;

- (void)benchMarkTag:(NSString *_Nullable)aTag targetBlock:(nonnull void(^)(void))benchblock repeat:(NSUInteger)times;
- (void)benchMark:(nonnull void(^)(void))benchblock repeat:(NSUInteger)times;


@end
