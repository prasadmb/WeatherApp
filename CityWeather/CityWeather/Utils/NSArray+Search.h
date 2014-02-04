//
//  NSArray+Search.h
//  CityWeather
//
//  Created by Prasad on 4/2/14.
//  Copyright (c) 2014 propertyguru. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (Search)
/**
  Check Item found in the list
 */
- (BOOL)itemFoundWithString:(NSString *)aString ;
/**
 Get Saved Locations
 */
- (NSArray *)searchItemsWithString:(NSString *)aString;
@end
