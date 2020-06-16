//
//  XCocoaUtilsPublicTests.m
//  XCocoaUtilsPublicTests
//
//  Created by NicholasXu on 2020/2/7.
//  Copyright © 2020 Deheng.Xu. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <XCocoaUtilsPublic/XCocoaUtilsPublic.h>

typedef struct _book_info {
    float price;
    const char *name;
}BooKInfo;

@interface Book : NSObject

- (NSNumber *)isOnline:(NSString *)name category:(NSString *)category;
- (NSUInteger)publishedTimes:(NSString *)name category:(NSString *)category;
- (BooKInfo *)bookInfo:(NSString *)name category:(NSString *)category;

@end

@implementation Book

- (NSNumber *)isOnline:(NSString *)name category:(NSString *)category
{
    NSLog(@"%s, name:%@, category:%@", __func__, name, category);
    return @YES;
}

- (NSUInteger)publishedTimes:(NSString *)name category:(NSString *)category
{
    NSLog(@"%s, name:%@, category:%@", __func__, name, category);
    return 3;
}

- (BooKInfo *)bookInfo:(NSString *)name category:(NSString *)category
{
    NSLog(@"%s, name:%@, category:%@", __func__, name, category);
    BooKInfo * book = malloc(sizeof(BooKInfo));
    return book;
}

@end

@interface XCocoaUtilsPublicTests : XCTestCase

@end

@implementation XCocoaUtilsPublicTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testRuntime {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    Book *book = Book.new;
    NSNumber *res = [book performSelector:@selector(isOnline:category:) withObjects:@[@"论语", @"Education"]];
    NSLog(@"res: %@", res);

//    NSUInteger times = [book performSelector:@selector(publishedTimes:category:) withObjects:@[@"论语", @"Education"]];
//    NSLog(@"times: %lu", times);

    BooKInfo *bookInfo = (__bridge BooKInfo *)([book performSelector:@selector(bookInfo:category:) withObjects:@[@"论语", @"Education"]]);
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
