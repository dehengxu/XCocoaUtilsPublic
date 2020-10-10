//
//  XCUFoundation.h
//  Pods
//
//  Created by NicholasXu on 2020/9/24.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

extern NSString* xcu_NSStringFromBool(BOOL b);

extern const char *xcu_CStringFromNSString(NSString *string);

@interface XCUFoundation : NSObject

@end

@interface NSBundle (XCUP)

- (NSString*)contentStringWithName:(NSString*)fileName extension:(NSString*)extension error:(NSError**)error;

@end

NS_ASSUME_NONNULL_END
