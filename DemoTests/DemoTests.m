//
//  DemoTests.m
//  DemoTests
//
//  Created by NicholasXu on 15/9/1.
//  Copyright (c) 2015年 Deheng.Xu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import <XCocoaUtilsPublic/NSObject+XCUP.h>

@interface DemoTests : XCTestCase

@end

@implementation DemoTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testHashTable {
    // This is an example of a functional test case.
    NSLog(@"%@", [NSHashTable name]);
}

- (void)testFleManager {
    NSURL *fileURL = [NSURL fileURLWithPath:@"/usr/local/readme.txt"];
    NSLog(@"relativePath: %@", fileURL.relativePath);
    NSLog(@"URLByStandardizingPath: %@", fileURL.URLByStandardizingPath.absoluteString);
    NSLog(@"URLByDeletingPathExtension: %@", fileURL.URLByDeletingPathExtension.absoluteString);
    NSLog(@"URLByDeletingLastPathComponent: %@", fileURL.URLByDeletingLastPathComponent.absoluteString);
}

//- (void)testPerformanceExample {
//    // This is an example of a performance test case.
//    [self measureBlock:^{
//        // Put the code you want to measure the time of here.
//    }];
//}

@end
