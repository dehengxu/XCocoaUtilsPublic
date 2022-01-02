//
//  CCommon.h
//  Demo
//
//  Created by NicholasXu on 2020/7/16.
//  Copyright © 2020 Deheng.Xu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

#define SUBCLASSING_FROM_SWIFT __attribute__((objc_subclassing_restricted))

#if __cplusplus
extern "C" {
#endif
    
extern NSString* getEnv(NSString* name);

/**
 Check selector and run block if possible

 return if target, sel, block is nil.

 */
extern void(^checkSelectorAndRunBlock)(_Nullable id target, _Nullable SEL sel, void(^ _Nullable block)(void));

extern void(^syncOnQueue)(_Nullable dispatch_queue_t q, void(^ _Nullable block)(void));

extern void(^asyncOnQueue)(_Nullable dispatch_queue_t q, void(^ _Nullable block)(void));

extern void(^syncOnMain)(void(^ _Nullable block)(void));

extern void(^asyncOnMain)(void(^ _Nullable block)(void));

#if __cplusplus
}
#endif
//@interface CCommon : NSObject
//@end

NS_ASSUME_NONNULL_END
