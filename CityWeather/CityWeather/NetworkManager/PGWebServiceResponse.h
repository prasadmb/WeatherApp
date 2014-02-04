//
//  PGWebServiceResponse.h
//  CityWeather
//
//  Created by Prasad on 4/2/14.
//  Copyright (c) 2014 propertyguru. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "PGWebServiceRequest.h"
/**
 Request Methods
 */
typedef enum {
    kJSON = 1,
    KSOAP = 2
}   ResponseType;

@interface PGWebServiceResponse : NSObject
{
    BOOL isValidJson;
}

@property (nonatomic,assign)  NSInteger      responseCode;
@property (nonatomic,strong)  id      data;
@property (nonatomic,strong)  NSDictionary*  responseData;
@property (nonatomic,assign)  WebserviceCall  webserviceCall;
@property (nonatomic,assign)  ResponseType   responseType;
@property (nonatomic,strong)  NSString       *responseString;
@property (nonatomic,strong)  NSError       *error;

- (NSDictionary *)getJSON;
- (id)initWithData:(id)data;
- (int)getResponseCode;


@end
