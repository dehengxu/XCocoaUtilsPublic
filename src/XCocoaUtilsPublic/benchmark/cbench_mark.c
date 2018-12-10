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
    double dt = (int64_t)t1.tv_usec - (int64_t)t0.tv_usec;
    printf("%s\n", tag);
    printf("\tBench repeat %lu times, cast total time :%f(ms), single task cost time :%f(ms)\n", (unsigned long)times, dt * 1e0, (dt * 1e0 / times ));
}

void bench_mark_clock(const char *tag, void (*targetFunction)(benchmark_t num), long times)
{
    if (NULL == targetFunction) return;
    
    
    struct timespec timespec1, timespec2;
    
    clockid_t clockid = _CLOCK_REALTIME;

    if (__builtin_available(iOS 10.0, *)) {
        clock_gettime(clockid, &timespec1);
    } else {
        // Fallback on earlier versions
    }
    for (benchmark_t i = 0; i < times; i++) {
        targetFunction(i);
    }
    if (__builtin_available(iOS 10.0, *)) {
        clock_gettime(clockid, &timespec2);
    } else {
        // Fallback on earlier versions
    }
    
    double dt = timespec2.tv_nsec - timespec1.tv_nsec;
    printf("\tBench repeat %lu times, cast total time :%f(ms), single task cost time :%f(ms)\n", (unsigned long)times, dt * 1e-9, (dt * 1e-9 / times ));

}
