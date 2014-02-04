//
//  PGWebServiceInterface.h
//  CityWeather
//
//  Created by Prasad on 4/2/14.
//  Copyright (c) 2014 propertyguru. All rights reserved.
//


#import <Foundation/Foundation.h>

@class PGWebServiceInterface;

@protocol PGWebServiceInterface <NSObject>

@optional
/**
 This method is used to get wheather details from the server
*/
- (void)executeCityWeatherSearch:(NSString *) aCity;

@end


