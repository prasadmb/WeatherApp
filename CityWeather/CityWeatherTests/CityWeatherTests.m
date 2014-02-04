//
//  CityWeatherTests.m
//  CityWeatherTests
//
//  Created by Prasad on 4/2/14.
//  Copyright (c) 2014 propertyguru. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Helper.h"
#import "PGWebServiceManager.h"
#import "constant.h"
#import "OCMockObject.h"
#import "PGWebServiceManager.h"
#import "SearchViewController.h"
#import "OCMArg.h"
@interface CityWeatherTests : XCTestCase<PGWebserviceManagerDelegate>
   @property (nonatomic,strong) PGWebServiceManager *webServiceManager;
@end

@implementation CityWeatherTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}


//Test Case 1
- (void) testSucessSearch {
    self.webServiceManager=[[PGWebServiceManager alloc]init];
    id mockDelegate = [OCMockObject mockForProtocol:@protocol(PGWebserviceManagerDelegate)];
    self.webServiceManager.delegate=mockDelegate;
    [self.webServiceManager executeCityWeatherSearch:@"London"];
    [[mockDelegate expect]processCompleted:[OCMArg any]];
    [mockDelegate verify];
}

//Test Case 2
- (void) testFailureSearch {
    self.webServiceManager=[[PGWebServiceManager alloc]init];
    id mockDelegate = [OCMockObject mockForProtocol:@protocol(PGWebserviceManagerDelegate)];
    self.webServiceManager.delegate=mockDelegate;
    [self.webServiceManager executeCityWeatherSearch:@"Leererondon"];
    [[mockDelegate expect]processFailed:[OCMArg any]];
    [mockDelegate verify];
}

/**
   Test Case 3
*/
- (void)testSavedLocations {
    NSArray *locations = [Helper getSavedLocations];
    XCTAssertNotNil(locations, @"Failed to get Saved Locations");
    XCTAssertEqual([locations count], 10, @"Saved Location count reaches count");
}

/**
 Test Case 4
*/
- (void) testWeatherData {
    NSDictionary *weatherData = [Helper getWeatherDetailsWithLocation:@"London"];
    XCTAssertNotNil(weatherData, @"Failed to get Weather Details");
    XCTAssertEqual([weatherData count], 1, @"Get Weather Details ");

}

@end
