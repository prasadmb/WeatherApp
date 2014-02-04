//
//  PGWebServiceRequest.h
//  CityWeather
//
//  Created by Prasad on 4/2/14.
//  Copyright (c) 2014 propertyguru. All rights reserved.
//

#import <Foundation/Foundation.h>



/**
 Request Methods
 */
typedef enum {
    GET     = 1,
    PUT    = 2,
    POST    = 3,
    DELETE  = 4
}   RequestMethod;


static NSString *api = @"http://api.worldweatheronline.com/free/v1/weather.ashx?key=vzkjnx2j5f88vyn5dhvvqkzc&q=%@&fx=yes&format=json";

static NSString *RESPONSE_CODE_NODE = @"ResponseCode";

/**
 Webservice Methods
*/

typedef enum {
    kCITY_WEATHER_SEARCH                 = 1
}   WebserviceCall;


@interface PGWebServiceRequest : NSObject
@property (nonatomic,strong) NSString  *webserviceAPI;
@property (nonatomic,strong) NSString  *requestURL;
@property (nonatomic,strong) NSDictionary  * requestHeaders;
@property (nonatomic,strong) NSDictionary  * requestParams;
@property (nonatomic,strong) NSString *savedFileName;
@property (nonatomic,assign) RequestMethod requestMethod;
@property (nonatomic,assign) WebserviceCall webserviceCall;
@property (nonatomic,strong) NSString *imageUploadPath;
@property (nonatomic,strong) NSString *requestBody;
@property (nonatomic,strong) NSData *dataUserImage;


@end
