//
//  PGWebServiceManager.h
//  CityWeather
//
//  Created by Prasad on 4/2/14.
//  Copyright (c) 2014 propertyguru. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "PGWebServiceManager.h"
#import "PGWebServiceResponse.h"
#import "PGNetworkKit.h"
#import "PGWebServiceRequest.h"
#import "PGWebServiceInterface.h"

@class PGWebServiceManager;
@class PGWebServiceResponse;
@class PGNetworkKit;

@protocol PGWebserviceManagerDelegate <NSObject>

@optional

- (void) webserviceManager:(PGWebServiceManager *) aManager processedData: (PGWebServiceResponse *) aResponse;
- (void) webserviceManager:(PGWebServiceManager *) aManager processFailed:(PGWebServiceResponse *) aResponse;
- (void)processCompleted:(PGWebServiceResponse *)response;
- (void)processFailed:(PGWebServiceResponse *)response;

@end

@interface PGWebServiceManager : PGNetworkKit <PGWebServiceInterface>
{

}
@property (nonatomic,weak) NSObject  <PGWebserviceManagerDelegate>  *delegate;



@end
