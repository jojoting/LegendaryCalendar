//
//  NSDate+LCCalendarTests.m
//  LegendaryCalendar
//
//  Created by jojoting on 16/8/13.
//  Copyright © 2016年 jojoting. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NSDate+LCCalendar.h"

@interface NSDate_LCCalendarTests : XCTestCase

@end

@implementation NSDate_LCCalendarTests

- (void)setUp {
    [super setUp];
    
    // Put setup code here. This method is called before the invocation of each test method in the class.

    // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // Use recording to get started writing UI tests.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testLc_allDays {
    NSArray *allDays = [[NSDate date] lc_currentDates];
    NSLog(@"all days:%@",allDays);
}

- (void)testLc_weekDay {
    NSLog(@"week day:%ld",[[NSDate date] lc_weekDay]);
}

- (void)testLc_lastMonth {
    XCTAssertEqual([[NSDate date] lc_lastMonth], 7, @"获取上个月错误");
}

- (void)testLc_nextMonth {
    XCTAssertEqual([[NSDate date] lc_nextMonth], 9, @"获取下个月错误");
}

- (void)testLc_currentMonth {
    XCTAssertEqual([[NSDate date] lc_currentMonth], 8, @"获取当月月错误");
}

- (void)testLc_chineseDay {
    NSCalendar *greoCal = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    [greoCal setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
    NSDateComponents *testGreoComp = [greoCal components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:[NSDate date]];
    
    NSDate *testDate;
    NSString *testStr;
    //测试农历节日 春节
    testGreoComp.day = 8;
    testGreoComp.month = 2;
    testDate = [greoCal dateFromComponents:testGreoComp];
    testStr = [testDate lc_chineseDay];
    XCTAssertTrue([testStr isEqualToString:@"春节"] ,@"农历节日获取错误");

    //测试农历节日 除夕
    testGreoComp.day = 7;
    testGreoComp.month = 2;
    testDate = [greoCal dateFromComponents:testGreoComp];
    testStr = [testDate lc_chineseDay];
    XCTAssertTrue([testStr isEqualToString:@"除夕"] ,@"农历节日 除夕获取错误");

    //测试国际节日 儿童节
    testGreoComp.day = 1;
    testGreoComp.month = 6;
    testDate = [greoCal dateFromComponents:testGreoComp];
    testStr = [testDate lc_chineseDay];
    XCTAssertTrue([testStr isEqualToString:@"儿童节"] ,@"国际节日获取错误");
    
    //测试农历节气 立秋 2016-8-7
    testGreoComp.day = 7;
    testGreoComp.month = 8;
    testDate = [greoCal dateFromComponents:testGreoComp];
    testStr = [testDate lc_chineseDay];
    XCTAssertTrue([testStr isEqualToString:@"立秋"] ,@"农历气日获取错误");
    
    //测试判断节日
    XCTAssertTrue([testDate lc_isFestival] ,@"判断是否节日错误");

    //测试判断是否当前月
    XCTAssertTrue([testDate lc_isCurrentMonth] ,@"判断是否当前月错误");
    testGreoComp.day = 7;
    testGreoComp.month = 7;
    testDate = [greoCal dateFromComponents:testGreoComp];
    XCTAssertFalse([testDate lc_isCurrentMonth] ,@"判断是否当前月错误");

}
@end
