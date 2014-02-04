//
//  WeatherSearchBaseViewController.h
//  CityWeather
//  Created by Prasad on 4/2/14.
//  Copyright (c) 2014 propertyguru. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WeatherSearchBaseViewController : UIViewController
{
}
/**
 This method is used to search weather data by passing location
*/
- (void) searchWeatherDetailsByLocation:(NSString *)city;

@end
