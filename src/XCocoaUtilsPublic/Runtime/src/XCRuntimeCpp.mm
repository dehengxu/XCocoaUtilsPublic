//
//  XCRuntimeCpp.m
//  XCocoaUtilsPublic
//
//  Created by NicholasXu on 2021/5/15.
//

#import "XCRuntimeCpp.h"

template<>
void nxcxx::objc::nx_copyClassMetaInfoList(Class aClass, unsigned int *count, objc_property_t **dest) {
    if (!count) return;
    unsigned int c = 0;
    *dest = class_copyPropertyList(aClass, &c);
    *count = c;
#if DEBUG
    for(int i = 0; i < c; i++) {
        const char* name = property_getName((*dest)[i]);
        NSLog(@"property name: %s", name);
    }
#endif
}

template<>
void nxcxx::objc::nx_copyClassMetaInfoList(Class aClass, unsigned int *count, Ivar **dest) {
    if (!count) return;
    unsigned int c = 0;
    *dest = class_copyIvarList(aClass, &c);
    *count = c;
#if DEBUG
    for(int i = 0; i < c; i++) {
        const char* name = ivar_getName((*dest)[i]);
        NSLog(@"ivar name: %s", name);
    }
#endif
}

template<>
void nxcxx::objc::nx_copyClassMetaInfoList(Class aClass, unsigned int *count, Method **dest) {
    if (!count) return;
    unsigned int c = 0;
    *dest = class_copyMethodList(aClass, &c);
    *count = c;
#if DEBUG
    for(int i = 0; i < c; i++) {
        SEL sel = method_getName((*dest)[i]);
        NSLog(@"ivar name: %s", sel_getName(sel));
    }
#endif
}

template<>
void nxcxx::objc::nx_copyClassMetaInfoList(Class aClass, unsigned int *count, Protocol* __unsafe_unretained * _Nonnull * _Nullable dest) {
    if (!count) return;
    unsigned int c = 0;
    *dest = class_copyProtocolList(aClass, &c);
    *count = c;
#if DEBUG
    for(int i = 0; i < c; i++) {
        Protocol* protocol = (*dest)[i];
        const char* name = protocol_getName(protocol);
        NSLog(@"protocol name: %s", name);
    }
#endif
}

@implementation XCRuntimeCpp

@end
