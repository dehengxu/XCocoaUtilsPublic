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

@interface LoggingTests : XCTestCase

DeclareLoggingSwitcher();

@end

@implementation LoggingTests

DefineLoggingSwitcher();

DefineNewLogWithClass(LTC, Logging, LoggingTests);

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

DefineNewLog(LT, Logging);

- (void)testTagLogging {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
	LTLog(@"Hello, %@", [self classForCoder]);
	LTLog(@"XTagLog, %ld");
	LTLog(@"Hi, %s", __func__);
	[LoggingTests setLoggingEnabled:NO];
	LTCLog(@"Hello, %s", __func__);
}

//- (void)testPerformanceExample {
//    // This is an example of a performance test case.
//    [self measureBlock:^{
//        // Put the code you want to measure the time of here.
//    }];
//}

@end
