//
//  constant.h
//  CityWeather
//
//  Created by Prasad on 4/2/14.
//  Copyright (c) 2014 propertyguru. All rights reserved.
//

#ifndef CityWeather_constant_h
#define CityWeather_constant_h

// Json Keywords

static NSString *kData=@"data";
static NSString *kError=@"error";
static NSString *kErrorMsg=@"msg";
static NSString *kCurrentCondition=@"current_condition";
static NSString *kWeatherIconUrl=@"weatherIconUrl";
static NSString *kValue=@"value";
static NSString *kObservationTime=@"observation_time";
static NSString *kHumidity=@"humidity";
static NSString *kWeatherDesc =@"weatherDesc";
#define  Alert(TITLE,MSG) [[[UIAlertView alloc] initWithTitle:(TITLE) \
message:(MSG) \
delegate:nil \
cancelButtonTitle:@"OK" \
otherButtonTitles:nil] show]

#endif
