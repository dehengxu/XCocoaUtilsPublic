//
//  TCObjectMappingProtocol.h
//  TCFinance
//
//  Created by NicholasXu on 15/12/11.
//  Copyright © 2015年 DehengXu. All rights reserved.
//

#ifndef TCObjectMappingDelegate_h
#define TCObjectMappingDelegate_h

#pragma mark - TCObjectMappingDelegate definition

@protocol TCObjectMappingDelegate

@required
- (id _Nullable)mapObject:(id _Nullable)object toClass:(Class _Nullable)aClass;

@optional
- (id _Nullable)mapObject:(id _Nullable)object1 toKindeOfObject:(id _Nullable)object2;

@end


#endif /* TCObjectMappingDelegate_h */
