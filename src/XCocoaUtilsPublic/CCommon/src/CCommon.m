//
//  CCommon.m
//  Demo
//
//  Created by NicholasXu on 2020/7/16.
//  Copyright © 2020 Deheng.Xu. All rights reserved.
//

#import "CCommon.h"

NSString* getEnv(NSString* name) {
    const char* env = getenv([name cStringUsingEncoding:NSUTF8StringEncoding]);
    if (env != NULL && strlen(env) > 0) {
        return [NSString stringWithCString:env encoding:NSUTF8StringEncoding];
    }
    return @"";
}

void(^checkSelectorAndRunBlock)(id, SEL, void(^)(void)) = ^(id object, SEL sel, void(^b)(void)) {
	if (!b || !object || !sel) return;
	if ([object respondsToSelector:sel]) {
		b();
	}
};

void(^syncOnQueue)(dispatch_queue_t q, void(^block)(void)) = ^(dispatch_queue_t q, void(^block)(void)) {
	if (!q || !block) return;
	dispatch_queue_t current = dispatch_get_current_queue();
//    if (current == q) {
//        block();
//    }else {
		dispatch_sync(q, block);
//    }
};

void(^asyncOnQueue)(dispatch_queue_t q, void(^block)(void)) = ^(dispatch_queue_t q, void(^block)(void)) {
	if (!q || !block) return;
	dispatch_async(q, block);
};

void(^syncOnMain)(void(^ _Nullable block)(void)) = ^(void(^block)(void)) {
	if (!block) return;
	if (![NSThread isMainThread]) {
		dispatch_sync(dispatch_get_main_queue(), block);
	}else {
		block();
	}
};

void(^asyncOnMain)(void(^block)(void)) = ^(void(^block)(void)) {
	if (!block) return;
	dispatch_async(dispatch_get_main_queue(), block);
};

//@implementation CCommon
//@end
