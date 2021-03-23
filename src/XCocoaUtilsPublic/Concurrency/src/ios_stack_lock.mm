//
//  ios_stack_lock.cpp
//
//  Created by NicholasXu on 2021/3/22.
//  Copyright © 2021 DehengXu. All rights reserved.
//

#include <stdio.h>
#import <mach/mach.h>
#include "ios_stack_lock.hpp"

template<>
void nxcxx::con::GenLock(dispatch_semaphore_t __strong const &lock) {
	dispatch_semaphore_wait(lock, DISPATCH_TIME_FOREVER);
}

template<>
void nxcxx::con::GenUnLock(dispatch_semaphore_t __strong const &lock) {
	dispatch_semaphore_signal(lock);
}

template<>
void nxcxx::con::GenLock(NSLock* __strong const  &lock) {
	[lock lock];
}

template<>
void nxcxx::con::GenUnLock(NSLock* __strong const &lock) {
	[lock unlock];
}

// dispatch_semaphore_t 特化
template<>
nxcxx::con::NXStackLock<dispatch_semaphore_t>::NXStackLock(dispatch_semaphore_t __strong const &lock):innerLocker(lock) {
    dispatch_semaphore_wait(innerLocker, DISPATCH_TIME_FOREVER);
}

template<>
nxcxx::con::NXStackLock<dispatch_semaphore_t>::~NXStackLock() {
	if (innerLocker) dispatch_semaphore_signal(innerLocker);
}

/// NSLock* 特化
template<>
nxcxx::con::NXStackLock<NSLock*>::NXStackLock(NSLock* __strong const &lock):innerLocker(lock) {
    [innerLocker lock];
}

template<>
nxcxx::con::NXStackLock<NSLock*>::~NXStackLock() {
    if (innerLocker) [innerLocker unlock];
}

/// NSLock* 特化
template<>
nxcxx::con::NXStackLock<semaphore_t>::NXStackLock(semaphore_t const &lock):innerLocker(lock) {
	semaphore_wait(lock);
}

template<>
nxcxx::con::NXStackLock<semaphore_t>::~NXStackLock() {
	semaphore_signal(innerLocker);
}
