//
//  cbench_mark.c
//  AccessTime
//
//  Created by NicholasXu on 2018/12/5.
//  Copyright © 2018 NicholasXu. All rights reserved.
//

#include "cbench_mark.h"
#include <stddef.h>
#include <stdio.h>
#include <time.h>
#include <sys/time.h>
#include <assert.h>

double msec_timespec(struct timespec t0, struct timespec t1) {
    double dt = (t1.tv_sec - t0.tv_sec) * 1000.0 + ((t1.tv_nsec - t0.tv_nsec) / 1000000.0);
    return dt;
}

double msec_timeval(struct timeval t0, struct timeval t1) {
    double dt = (t1.tv_sec - t0.tv_sec) * 1000.0  + (t1.tv_usec - t0.tv_usec) / 1000.0;
    return dt;
}

void benchMark(const char *tag, void (*targetFunction)(benchmark_t num), long times)
{
    if (NULL == targetFunction) {
        return;
    }

    struct timeval t0, t1;
    gettimeofday(&t0, 0);
    for(benchmark_t i = 0; i < times; i++) {
        targetFunction(i);
    }
    gettimeofday(&t1, 0);
    //long dt = (t1.tv_sec - t0.tv_sec) * 1e6  + (t1.tv_usec - t0.tv_usec);
    double dt_ms = msec_timeval(t0, t1);//dt / 1000.0;
    printf("%s\n", tag);
    printf("\tBench repeat %lu times, cast total time :%f(ms), single task cost time :%f(ms)\n", (unsigned long)times, dt_ms, (dt_ms / times ));
}

#define XCUP_TIMING_METHOD 0

/// time units: s(seconds), ms(milliseconds), us(microseconds), ns(nanoseconds)
/// @param tag string
/// @param times total times
void bench_mark_clock(const char *tag, void (*targetFunction)(benchmark_t num), long times)
{
    if (NULL == targetFunction) return;
    
    //Timing prepare
#if XCUP_TIMING_METHOD
    clockid_t clockid = CLOCK_REALTIME;
    struct timespec t0, t1;
    struct timespec res;
    clock_getres(clockid, &res);
#else
    struct timeval t0, t1;
#endif
    
    //Start timing
#if DEBUG && XCUP_TIMING_METHOD
    printTimespec(res);
    clock_gettime(clockid, &t0);
#else
    gettimeofday(&t0, 0);
#endif

    for (benchmark_t i = 0; i < times; i++) {
        targetFunction(i);
    }
    //End timing
#if XCUP_TIMING_METHOD
    clock_gettime(clockid, &t1);
#else
    gettimeofday(&t1, 0);
#endif
    
    //Delta of time
    double dt = 0.0;
#if XCUP_TIMING_METHOD
    dt = msec_timespec(t0, t1);
#else
    dt = msec_timeval(t0, t1);
#endif
    
    printf("\tBench repeat %lu times, cast total time :%f(ms), single task cost time :%f(ms)\n", (unsigned long)times, dt, (dt / times ));

}
