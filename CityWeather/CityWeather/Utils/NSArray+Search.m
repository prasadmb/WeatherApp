//
//  NSArray+Search.m
//  CityWeather
//
//  Created by Prasad on 4/2/14.
//  Copyright (c) 2014 propertyguru. All rights reserved.
//

#import "NSArray+Search.h"

@implementation NSArray (Search)

- (BOOL) itemFoundWithString:(NSString *)aString  {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF contains[c] %@",aString];
    NSArray *results = [self filteredArrayUsingPredicate:predicate];
    if ([results count]) return YES;
    return NO;
}

- (NSArray *)searchItemsWithString:(NSString *)aString {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF contains[c] %@",aString];
    NSArray *results = [self filteredArrayUsingPredicate:predicate];
    return results;
}

@end
