//
//  Helper.m
//  CityWeather
//
//  Created by Prasad on 4/2/14.
//  Copyright (c) 2014 propertyguru. All rights reserved.
//

#import "Helper.h"
#import "NSArray+Search.h"

@implementation Helper

+ (NSString *)getLocationsFilePath {
    NSString *docsPath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
    NSString *filePath = [docsPath stringByAppendingPathComponent:@"location.plist"];
    return filePath;
}

+ (NSString *)getWeatherDataFilePath:(NSString *)location {
    NSString *docsPath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
    NSString *filePath = [docsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.plist",location]];
    return filePath;
}

+ (NSArray *) getSavedLocations {
    NSArray * values=[[NSArray alloc] initWithContentsOfFile:[self getLocationsFilePath]];
    return values;
}

+ (NSDictionary *) getWeatherDetailsWithLocation:(NSString *)aLocation {
    NSDictionary * values=[[NSDictionary alloc] initWithContentsOfFile:[self getWeatherDataFilePath:aLocation]];
    return values;
}


+ (void) saveSearchItem:(NSString *) aSearchString {
    NSMutableArray *locations = [NSMutableArray array];
    NSArray *loc=[self getSavedLocations];
    if (loc) {
        locations=[[self getSavedLocations]mutableCopy];
        if ([locations count]==10) {
            [locations removeObjectAtIndex:0];
        }
    }
    if (![locations itemFoundWithString:aSearchString]) {
        [locations addObject:aSearchString];
        [locations writeToFile:[self getLocationsFilePath] atomically:YES];
    }
}


+ (void) saveWeatherDataWithLocation:(NSString *)location data:(NSDictionary *)aData {
    [aData writeToFile:[self getWeatherDataFilePath:location] atomically:YES];
}


@end
