//
//  Demo.h
//  Demo
//
//  Created by Deheng Xu on 2019/1/7.
//  Copyright © 2019 Deheng.Xu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <XLogging.h>

NS_ASSUME_NONNULL_BEGIN

DeclareNewLog(demo, Demo);

@interface Demo : NSObject

DeclareLoggingSwitcher();

@end

NS_ASSUME_NONNULL_END
