//
//  PGNetworkKit.h
//  CityWeather
//
//  Created by Prasad on 4/2/14.
//  Copyright (c) 2014 propertyguru. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PGNetworkKitConstant.h"

@interface PGNetworkKit : NSObject
@property (nonatomic,strong) NSString  *requestURL;
@property (nonatomic,strong) NSDictionary  * requestHeaders;
@property (nonatomic,strong) NSDictionary  * requestParams;
@property (nonatomic,strong) NSMutableURLRequest *mutableRequest;
@property (nonatomic,strong) NSNumber *serviceReference;
@property (nonatomic,strong) NSString *imageUploadPath;
@property (nonatomic,strong) NSDictionary *imageInfoDict;
@property (nonatomic,strong) NSString *requestBody;
@property (nonatomic,assign) Request methodType;

- (void)doProcess;
- (void)downloadImage;
- (void)executeImageUpload;
- (void)executeURLRequest;

- (void)processSucceeded:(id)object :(NSNumber *)ref;
- (void)proccessFail:(NSError *)error :(NSNumber *)ref;
@end
