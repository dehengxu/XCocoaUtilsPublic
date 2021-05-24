//
//  compiler_macros.h
//  XCocoaUtilsPublic
//
//  Created by NicholasXu on 2020/6/28.
//  Copyright © 2020 Deheng.Xu. All rights reserved.
//

#ifndef compiler_macros_h
#define compiler_macros_h

#pragma mark - Extern

#if !defined(c_extern)
	#if defined(__cplusplus)
		#define c_extern extern "C"
	#else
		#define c_extern
	#endif
#endif

#if !defined(C_EXTERN_BEGIN) || !defined(C_EXTERN_END)
	#if defined(__cplusplus)
		#define C_EXTERN_BEGIN extern "C" {
		#define C_EXTERN_END }
	#else
		#define C_EXTERN_BEGIN
		#define C_EXTERN_END
	#endif
#endif

#if !defined(XCUP_EXTERN_BEGIN) || !defined(XCUP_EXTERN_END)
	#if defined(__cplusplus)
		#define XCUP_EXTERN_BEGIN extern "C" {
		#define XCUP_EXTERN_END }
	#else
		#define XCUP_EXTERN_BEGIN
		#define XCUP_EXTERN_END
	#endif
#endif

#ifndef XCUP_STRINGIFY
#define XCUP_STRINGIFY(x) #x //Convert symbol to literal string
#endif

#pragma mark - compiler attributes annotations

#ifndef XCUP_ATTRIBUTE
#define XCUP_ATTRIBUTE(x) __attribute__(x)
#endif

#ifndef XCUP_WARN_UNUSED_RESULT
#define XCUP_WARN_UNUSED_RESULT __attribute__((warn_unused_result))
#endif

#pragma mark - compiler deprecated annotations

#ifndef XCUP_DEPRECATED_MSG
#define XCUP_DEPRECATED_MSG(x) __deprecated_msg(x)
#endif

#ifndef XCUP_CLANG_PUSH
#define XCUP_CLANG_PUSH _Pragma("clang diagnostic push")
#endif

#ifndef XCUP_CLANG_POP
#define XCUP_CLANG_POP _Pragma("clang diagnostic pop")
#endif

#define XCUP_PRAGMA(y) _Pragma(#y) // equals to _Pragma("clang diagnostic ignored ...");

#ifndef XCUP_CLANG_IGNORE
#define XCUP_CLANG_IGNORE(msg) _Pragma(XCUP_STRINGIFY(clang diagnostic ignored #msg))
#endif

#endif /* compiler_macros_h */
