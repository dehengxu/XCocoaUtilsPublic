//
//  LoggingTests.m
//  DemoTests
//
//  Created by Deheng Xu on 2019/1/6.
//  Copyright © 2019 Deheng.Xu. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <XLogging.h>
#import <objc/runtime.h>

DeclareLoggerWithTag(LTC);
DefineLoggerWithTag(LTC);

@interface LoggingTests : XCTestCase

@end

@implementation LoggingTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
    [log_LTC setLoggingEnabled:YES];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testTagLogging {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
	LTCLog(@"Hello, %@", [self classForCoder]);
	LTCLog(@"Hi, %s", __func__);
	LTCLog(@"Hello, %s", __func__);
}

//- (void)testPerformanceExample {
//    // This is an example of a performance test case.
//    [self measureBlock:^{
//        // Put the code you want to measure the time of here.
//    }];
//}

@end
