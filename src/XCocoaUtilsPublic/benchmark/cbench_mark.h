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
    
#define printTimespec(t)  printf(#t" tv_sec: %ld, tv_nsec: %ld. \n", t.tv_sec, t.tv_nsec)
    
#define printTimeval(t)  printf(#t" tv_sec: %ld, tv_nsec: %ld. \n", t.tv_sec, t.tv_nsec)
    
    double msec_timespec(struct timespec t0, struct timespec t1);
    
    double msec_timeval(struct timeval t0, struct timeval t1);
    
    void benchMark(const char *tag, void (*targetFunction)(benchmark_t num), long times);
    
    /// bench mark targetFunction
    ///
    /// Define macro named XCUP_TIMING_METHOD 1 or 0 to enable timing with clock or wall-clock
    ///
    /// @param tag string
    /// @param times total times
    void bench_mark_clock(const char *tag, void (*targetFunction)(benchmark_t num), long times);

#ifdef __cplusplus
};
#endif
#endif /* cbench_mark_h */
