//
//  cbench_mark.h
//  AccessTime
//
//  Created by NicholasXu on 2018/12/5.
//  Copyright © 2018 NicholasXu. All rights reserved.
//

#ifndef cbench_mark_h
#define cbench_mark_h

#ifdef __cplusplus
extern "C" {
#endif

#include <stdio.h>

    typedef long benchmark_t;
    
    void benchMark(const char *tag, void (*targetFunction)(benchmark_t num), long times);
    void bench_mark_clock(const char *tag, void (*targetFunction)(benchmark_t num), long times);

#ifdef __cplusplus
};
#endif
#endif /* cbench_mark_h */
