//
//  Helper.h
//  CityWeather
//
//  Created by Prasad on 4/2/14.
//  Copyright (c) 2014 propertyguru. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface Helper : NSObject
/**
 Save Location in a plist
 */
+ (void) saveSearchItem:(NSString *) aSearchString;
/**
 Fetch Saved Location from Plist
 */
+ (NSArray *) getSavedLocations ;
/**
     Save Weather details in plist as named by location
 */
+ (void) saveWeatherDataWithLocation:(NSString *)location data:(NSDictionary *)aData;
/**
 Fetch Weather Details from the plist
 */
+ (NSDictionary *) getWeatherDetailsWithLocation:(NSString *)aLocation;
@end
