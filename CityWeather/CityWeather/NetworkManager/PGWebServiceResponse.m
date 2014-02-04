//
//  PGWebServiceResponse.m
//  CityWeather
//  Created by Prasad on 4/2/14.
//  Copyright (c) 2014 propertyguru. All rights reserved.
//


#import "PGWebServiceResponse.h"
#import "NSDictionary+JSON.h"
#import "PGWebServiceInterface.h"

@interface PGWebServiceResponse()
{
    NSDictionary *jsonDictionary;
    
}
- (BOOL)isValidJson;

@end

@implementation PGWebServiceResponse


- (id)initWithData:(id)data
{
    if (self = [super init])
    {
        NSError *error;
        self.data = data;
        NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:self.data options: NSJSONReadingMutableContainers error: &error];
        if (jsonObject)
        {
            isValidJson = YES;
            jsonDictionary =  [[NSDictionary alloc ] initWithDictionary:jsonObject];
        }
        else
        {
            NSMutableDictionary *dict = [NSMutableDictionary dictionary];
            [dict setObject:[error description] forKey:@"ERROR"];
            [dict setObject:[NSNumber numberWithInt:-1] forKey:RESPONSE_CODE_NODE];
            jsonDictionary =  [[NSDictionary alloc ] initWithDictionary:dict];
        }
        
        
    }
    return self;
}


- (BOOL)isValidJson
{
    return ([NSJSONSerialization isValidJSONObject:self.data]);
}



- (NSDictionary *)getJSON
{
    return jsonDictionary;
}

- (int)getResponseCode
{
    int code = -1;
    if (isValidJson)
    {
       code = [[jsonDictionary objectForKey:RESPONSE_CODE_NODE] intValue];
    }
        
    return code;
}

@end
