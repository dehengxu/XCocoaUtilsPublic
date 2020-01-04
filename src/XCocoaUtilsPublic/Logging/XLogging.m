//
//  XLogging.c
//  XCocoaUtilsPublic
//
//  Created by Deheng Xu on 2019/1/6.
//  Copyright © 2019 Deheng.Xu. All rights reserved.
//

#include "XLogging.h"

void UpdateLoggerStatus(NSString *tag, const char *key, id value);

void EnableLogger(NSString *tag) {
    UpdateLoggerStatus(tag, "is_logging_enabled", @(true));
}

void DisableLogger(NSString *tag) {
    UpdateLoggerStatus(tag, "is_logging_enabled", @(false));
}

void UpdateLoggerStatus(NSString *tag, const char *key, id value) {
    if (![value isKindOfClass:[NSNumber class]]) {
        return;
    }
    Class c = NSClassFromString([NSString stringWithFormat:@"log_%@_swift", tag]);
    if (c) {
        objc_setAssociatedObject(c, key, value, OBJC_ASSOCIATION_ASSIGN);
    }

    c = NSClassFromString([NSString stringWithFormat:@"log_%@", tag]);
    if (c) {
        objc_setAssociatedObject(c, key, value, OBJC_ASSOCIATION_ASSIGN);
    }
}
