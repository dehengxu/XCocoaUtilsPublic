//
//  XCRuntimeCpp.h
//  XCocoaUtilsPublic
//
//  Created by NicholasXu on 2021/5/15.
//

#import <Foundation/Foundation.h>
#import <objc/message.h>

#ifdef __cplusplus

extern "C++" {
    namespace nxcxx {

        namespace objc {

            template<typename T>
            void nx_copyClassMetaInfoList(Class aClass, unsigned int *count, T**dest);

            template<typename T>
            static inline void nx_setIvarPrimitiveValue(id object, Ivar ivar, T value) {
                ptrdiff_t offset = ivar_getOffset(ivar);
                void *p = (__bridge void*)object;
                *(T*)((char*)p + offset) = value;
            }

        }//namespace objc

    }//namespace nxcxx
}

#endif

NS_ASSUME_NONNULL_BEGIN

@interface XCRuntimeCpp : NSObject

@end

NS_ASSUME_NONNULL_END
