//
//  PGWebServiceManager.m
//  CityWeather
//
//  Created by Prasad on 4/2/14.
//  Copyright (c) 2014 propertyguru. All rights reserved.
//


#import "PGWebServiceManager.h"

@implementation PGWebServiceManager

@synthesize delegate=_delegate;

-(NSString *)urlEncodeUsingEncoding:(NSString *)str {
	return [str stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
}

#pragma mark-
#pragma mark Authentication services

- (void)executeCityWeatherSearch:(NSString *) aCity {
    PGWebServiceRequest *request = [[PGWebServiceRequest alloc] init];
    [request setRequestURL:[self urlEncodeUsingEncoding:[NSString stringWithFormat:api,aCity]]];
    [request setRequestMethod:POST];
    [self setValues:request];
    [self doProcess];
}

- (void)setValues:(PGWebServiceRequest *)request {
    self.requestURL = request.requestURL;
    self.requestParams = request.requestParams;
    self.requestBody = request.requestBody;
    self.serviceReference = [NSNumber numberWithInt:request.webserviceCall];
    self.methodType = request.requestMethod;
    self.imageUploadPath = request.imageUploadPath;
}


#pragma mark-
#pragma mark call backs
- (void)processSucceeded:(id)object :(NSNumber *)ref {
    PGWebServiceResponse *response = [[PGWebServiceResponse alloc] initWithData:object];
    response.webserviceCall = [ref intValue];
    if ([[self delegate] respondsToSelector:@selector(processCompleted:)]) {
        [[self delegate] performSelector:@selector(processCompleted:) withObject:response];
    }
}

- (void)proccessFail:(NSError *)error :(NSNumber *)ref {
    PGWebServiceResponse *response = [[PGWebServiceResponse alloc] init];
    response.error = error;
    response.webserviceCall = [ref intValue];

    if ([[self delegate] respondsToSelector:@selector(processFailed:)])
    {
        [[self delegate] performSelector:@selector(processFailed:) withObject:response];
    }
}


@end
