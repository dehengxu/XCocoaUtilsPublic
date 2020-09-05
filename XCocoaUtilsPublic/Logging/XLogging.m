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

void UpdateLoggerStatus(NSString *tag, const char *key, NSNumber *value) {
    if (![value isKindOfClass:[NSNumber class]]) {
        return;
    }
    Class c = NSClassFromString([NSString stringWithFormat:@"log_%@_swift", tag]);
    if (c) {
        //TODO: fix this warning
#if __has_feature(objc_arc)
        objc_setAssociatedObject(c, key, value, OBJC_ASSOCIATION_ASSIGN);
#else
        [c setLoggingEnabled:[value boolValue]];
#endif
        //-- Under submodule will not works.
    }

    c = NSClassFromString([NSString stringWithFormat:@"log_%@", tag]);
    if (c) {
#if __has_feature(objc_arc)
        objc_setAssociatedObject(c, key, value, OBJC_ASSOCIATION_ASSIGN);
#else
        [c setLoggingEnabled:[value boolValue]];
#endif
    }
}
