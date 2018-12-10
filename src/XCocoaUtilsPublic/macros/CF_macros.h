//
//  CF_macros.h
//  XCocoaUtilsPublic
//
//  Created by NicholasXu on 2018/12/10.
//  Copyright © 2018 Deheng.Xu. All rights reserved.
//

#ifndef CF_macros_h
#define CF_macros_h

#pragma mark - Convert utility.

#define CFStringRefByNSString(str)  ((__bridge CFStringRef)(str))

#define CFMutableStringRefByNSMutableString(str) ((__bridge CFMutableStringRef)(str))

#define CFDataRefByNSData(dat)      ((__bridge CFDataRef)(dat))

#ifndef CFStringWithCstring
#define CFStringWithCstring(cstring) CFStringCreateWithCString(kCFAllocatorDefault, cstring, kCFStringEncodingUTF8)
#endif

#define CFArrayRefByNSArray(arr)    ((__bridge CFArrayRef)(arr))

#define NSArrayByCFArrayRef(cfarr)  ((NSArray *)cfarr)

#define NSMutableArrayByCFMutableArrayRef(cfarr)  ((NSMutableArray *)cfarr)

#if ARC_ENABLED
#define NSStringByCFStringRef(strRef) ((__bridge_transfer NSString*) (strRef))
#else
#define NSStringByCFStringRef(strRef) ((NSString*) (strRef))
#endif

#endif /* CF_macros_h */
