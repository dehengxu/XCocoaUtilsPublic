//
//  XCObjectMappingProtocol.h
//
//  Created by NicholasXu on 15/12/11.
//  Copyright © 2015年 DehengXu. All rights reserved.
//

#ifndef XCObjectMappingDelegate_h
#define XCObjectMappingDelegate_h

#pragma mark - XCObjectMappingDelegate definition

@protocol XCObjectMappingDelegate

@required
- (id _Nullable)mapObject:(id _Nullable)object toClass:(Class _Nullable)aClass;

@optional
- (id _Nullable)mapObject:(id _Nullable)object1 toKindeOfObject:(id _Nullable)object2;

@end


#endif /* XCObjectMappingDelegate_h */
