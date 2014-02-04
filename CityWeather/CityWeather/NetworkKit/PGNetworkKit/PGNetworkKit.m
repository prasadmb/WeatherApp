//
//  PGNetworkKit.m
//  CityWeather
//
//  Created by Prasad on 4/2/14.
//  Copyright (c) 2014 propertyguru. All rights reserved.
//


#import "PGNetworkKit.h"
#import "AFHTTPRequestOperationManager.h"

@interface PGNetworkKit ()
- (void) successRequest:(id)responseObj withServiceIndentifier:(NSNumber *)reference;
- (void) failedRequest:(NSError *)error withServiceIndentifier:(NSNumber *)reference;
@end

@implementation PGNetworkKit

@synthesize requestURL;
@synthesize requestHeaders;
@synthesize requestParams;
@synthesize mutableRequest;
@synthesize serviceReference;
@synthesize imageUploadPath;
@synthesize imageInfoDict;
@synthesize requestBody;
@synthesize methodType;

#pragma mark-
#pragma mark API connectors

- (void)executeURLRequest
{
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:mutableRequest];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         [self successRequest:responseObject withServiceIndentifier:self.serviceReference];
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         
         [self failedRequest:error withServiceIndentifier:self.serviceReference];
         
         NSLog(@"%@", [error description]);
     }];
    
    [operation start];
}


- (void)executeImageUpload {
    
    NSDate *date = [NSDate date];
    NSString *milliSecond = [NSString stringWithFormat:@"%lli.png", [@(floor([date timeIntervalSince1970] * 1000)) longLongValue]];
    NSData *imageData = nil;
    if ([self.imageUploadPath length] > 0)
    {
        imageData = [NSData dataWithContentsOfFile:self.imageUploadPath];
    }
    else
    {
        imageData = [self.imageInfoDict objectForKey:IMAGE_DATA_KEY];
    }
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    
    NSData *data = [self.requestBody dataUsingEncoding:NSUTF8StringEncoding];
    [manager POST:self.requestURL parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData)
     {
         [formData appendPartWithFormData:data name:@"json-data"];
         [formData  appendPartWithFileData:imageData name:@"file-data" fileName:milliSecond mimeType:IMAGE_MIME];
         
     }
          success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         [self successRequest:responseObject withServiceIndentifier:self.serviceReference];
         
     }
          failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         [self failedRequest:error withServiceIndentifier:self.serviceReference];
     }];
}

- (void)downloadImage
{
    
    AFHTTPRequestOperation *postOperation = [[AFHTTPRequestOperation alloc] initWithRequest:self.mutableRequest];
    postOperation.responseSerializer = [AFImageResponseSerializer serializer];
    [postOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         [self successRequest:responseObject withServiceIndentifier:self.serviceReference];
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         [self failedRequest:error withServiceIndentifier:self.serviceReference];
     }];
    
    [postOperation start];
}


- (void)doProcess
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    if (self.methodType == POST_)
    {
        
        [manager POST:self.requestURL parameters:self.requestParams success:^(AFHTTPRequestOperation *operation, id responseObject) {
            [self successRequest:responseObject withServiceIndentifier:self.serviceReference];
        }
              failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                  
                  [self failedRequest:error withServiceIndentifier:self.serviceReference];
              }];
    }
    else if (self.methodType == GET_)
    {
        [manager GET:self.requestURL parameters:self.requestHeaders success:^(AFHTTPRequestOperation *operation, id responseObject) {
            [self successRequest:responseObject withServiceIndentifier:self.serviceReference];
        }
             failure:^(AFHTTPRequestOperation *operation, NSError *error)
         {
             [self failedRequest:error withServiceIndentifier:self.serviceReference];
         }];
    }
}

#pragma mark-
#pragma mark API resposne

- (void) successRequest:(id)responseObj withServiceIndentifier:(NSNumber *)reference
{
    [self performSelector:@selector(processSucceeded::) withObject:responseObj withObject:reference];
}


- (void) failedRequest:(NSError *)error withServiceIndentifier:(NSNumber *)reference
{
    [self performSelector:@selector(proccessFail::) withObject:error withObject:reference];
}


#pragma mark-
#pragma mark API Callback
- (void)processSucceeded:(id)object :(NSNumber *)ref
{
    //empty implementation
}
- (void)proccessFail:(NSError *)error :(NSNumber *)ref
{
    //empty implementation
}
@end