//
//  LCPlistWrapperTest.m
//  LegendaryCalendar
//
//  Created by jojoting on 16/8/30.
//  Copyright © 2016年 jojoting. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "LCPlistWrapper.h"

#define testDictionary  @{@"testKey":@"testValue"}

@interface LCPlistWrapperTest : XCTestCase

@end

@implementation LCPlistWrapperTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

- (void)testWriteFile {
    BOOL isSuccessful = [LCPlistWrapper storeData:[NSKeyedArchiver archivedDataWithRootObject:testDictionary] toPlistFile:@"test.plist"];
    XCTAssertTrue(isSuccessful, @"write plist failed");
}

- (void)testReadFile {
    NSData *data = [LCPlistWrapper retrieveDataWithPlistFile:@"test.plist"];
    NSDictionary *dic = (NSDictionary *)[NSKeyedUnarchiver unarchiveObjectWithData:data];
    NSLog(@"dic:%@",dic);
}

@end
