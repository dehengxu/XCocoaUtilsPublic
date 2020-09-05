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

//@implementation CCommon
//@end
