//
//  HttpTests.m
//  DemoTests
//
//  Created by NicholasXu on 2020/1/16.
//  Copyright © 2020 Deheng.Xu. All rights reserved.
//

#import <XCTest/XCTest.h>

#import <XCocoaUtilsPublic/XCUPHttp.h>

@interface HttpTests : XCTestCase

@end

@implementation HttpTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testNSURL_A {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    NSString *baiduUrl = @"https://www.baidu.com?kk=value";
    NSURL *result =[baiduUrl.xcup_URL xcup_URLByAppendingQueries:@{@"name":@"lion", @"city":@"beijing"}];
    NSLog(@"%@", baiduUrl);
    NSLog(@"result: %@", result);
    //NSAssert([result.absoluteString isEqualToString:@"https://www.baidu.com?kk=value&name=lion&city=beijing"], @"falt");
}

- (void)testNSURL_B {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    NSString *baiduUrl = @"https://www.baidu.com?name=tiger";
    NSURL *result =[baiduUrl.xcup_URL xcup_URLByAppendingQueries:@{@"name":@"lion2", @"city":@"beijing"}];
    NSLog(@"%@", baiduUrl);
    NSLog(@"result: %@", result);
    //NSAssert([result.absoluteString isEqualToString:@"https://www.baidu.com?kk=value&name=lion&city=beijing"], @"falt");
}

//- (void)testPerformanceExample {
//    // This is an example of a performance test case.
//    [self measureBlock:^{
//        // Put the code you want to measure the time of here.
//    }];
//}

@end
