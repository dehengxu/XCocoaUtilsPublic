//
//  CGMacros.h
//  XCocoaUtilsPublic
//
//  Created by NicholasXu on 2018/12/10.
//  Copyright © 2018 Deheng.Xu. All rights reserved.
//

#ifndef CGMacros_h
#define CGMacros_h

#ifndef SYNTHESIZE_SINGLETON_FOR_CLASS
#define SYNTHESIZE_SINGLETON_FOR_CLASS(classname) \
\
static classname *shared##classname = nil; \
\
+ (classname *)sharedInstance \
{ \
@synchronized(self) \
{ \
if (shared##classname == nil) \
{ \
shared##classname = [[self alloc] init]; \
} \
} \
\
return shared##classname; \
} \
\
+ (void)purgeSharedInstance{\
\
}\
\
+ (id)allocWithZone:(NSZone *)zone \
{ \
@synchronized(self) \
{ \
if (shared##classname == nil) \
{ \
shared##classname = [super allocWithZone:zone]; \
return shared##classname; \
} \
} \
\
return nil; \
} \
\
- (id)copyWithZone:(NSZone *)zone \
{ \
return self; \
} \
\
- (id)retain \
{ \
return self; \
} \
\
- (NSUInteger)retainCount \
{ \
return NSUIntegerMax; \
} \
\
- (oneway void)release \
{ \
} \
\
- (id)autorelease \
{ \
return self; \
}
#endif

#ifndef SYNTHESIZE_SINGLETON_FOR_HEADER

#define SYNTHESIZE_SINGLETON_FOR_HEADER \
+ (id)sharedInstance; \
+ (void)purgeSharedInstance;
#endif


#endif /* CGMacros_h */
