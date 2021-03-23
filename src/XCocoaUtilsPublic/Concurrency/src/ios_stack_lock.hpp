//
//  ios_stack_lock.hpp
//  Adpos
//
//  Created by NicholasXu on 2021/3/22.
//  Copyright © 2021 DehengXu. All rights reserved.
//

#ifndef ios_stack_lock_h
#define ios_stack_lock_h

#import <Foundation/Foundation.h>
#import <iostream>

#if __cplusplus
extern "C" {
#endif



#if __cplusplus
}
#endif


namespace nxcxx {
namespace con {

template<typename T>
void GenLock(const T &lock);

template<typename T>
void GenUnLock(const T &lock);

template<typename T>
class NXStackLock {
private:
    T innerLocker;

    //Prevent creating on heap
    void* operator new(size_t);
    void* operator new(size_t, void*);
    void* operator new[](size_t);
    void* operator new[](size_t, void*);
public:

	NXStackLock(const T &lock);
	virtual ~NXStackLock();

};

}
}

#endif /* ios_stack_lock_h */
