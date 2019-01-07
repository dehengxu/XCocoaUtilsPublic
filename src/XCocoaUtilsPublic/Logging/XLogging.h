//
//  XLogging.h
//  XCocoaUtilsPublic
//
//  Created by Deheng Xu on 2019/1/6.
//  Copyright © 2019 Deheng.Xu. All rights reserved.
//

#ifndef XLogging_h
#define XLogging_h

#include <stdio.h>

#ifdef cpusplus
extern "C" {
#endif

#ifndef TagLogging
	#define TagLogging(TAG, fmt, ...) NSLog(@"<"#TAG"> "fmt, ##__VA_ARGS__)
#endif

#ifndef TagLoggingv
	#define TagLoggingv(TAG, fmt, args) NSLogv([NSString stringWithFormat:@"<"#TAG"> %@", fmt], args)
#endif

#ifndef DeclareNewLog
	#define DeclareNewLog(prefix, tag) extern void prefix##Log(NSString *fmt, ...) NS_FORMAT_FUNCTION(1,2)
#endif

#ifndef DefineNewLog
#define DefineNewLog(prefix, tag) void prefix##Log(NSString *fmt, ...) {\
va_list args; va_start(args, fmt); TagLoggingv(tag, fmt, args); va_end(args);\
}
#endif

#ifndef DefineNewLogWithClass
#define DefineNewLogWithClass(prefix, tag, aClass) void prefix##Log(NSString *fmt, ...) {\
if ([aClass respondsToSelector:@selector(isLoggingEnabled)] && ![aClass isLoggingEnabled]) return;\
va_list args; va_start(args, fmt); TagLoggingv(tag, fmt, args); va_end(args);\
}
#endif

#pragma mark - Logging switcher

#define DeclareLoggingSwitcher()\
+ (BOOL)isLoggingEnabled;\
+ (void)setLoggingEnabled:(BOOL)isEnabled

#define DefineLoggingSwitcher() \
+ (BOOL)isLoggingEnabled\
{\
char * const objKey = "is_logging_enabled";\
id islogging = objc_getAssociatedObject(self, objKey);\
if (!islogging) { return NO; }\
return [islogging boolValue];\
}\
\
+ (void)setLoggingEnabled:(BOOL)isEnabled\
{\
char * const objKey = "is_logging_enabled";\
objc_setAssociatedObject(self, objKey, @(isEnabled), OBJC_ASSOCIATION_ASSIGN);\
}


#ifdef cpusplus
}
#endif

#endif /* XLogging_h */
