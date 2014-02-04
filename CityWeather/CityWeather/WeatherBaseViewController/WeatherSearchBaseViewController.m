//
//  WeatherSearchBaseViewController.m
//  CityWeather
//  Created by Prasad on 4/2/14.
//  Copyright (c) 2014 propertyguru. All rights reserved.
//

#import "WeatherSearchBaseViewController.h"
#import "PGWebServiceManager.h"
@interface WeatherSearchBaseViewController () <PGWebserviceManagerDelegate>
   @property (nonatomic,strong) PGWebServiceManager *webServiceManager;
@end

@implementation WeatherSearchBaseViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.extendedLayoutIncludesOpaqueBars = NO;
    }
}

- (void) searchWeatherDetailsByLocation:(NSString *) city {
    self.webServiceManager=[[PGWebServiceManager alloc]init];
    [self.webServiceManager setDelegate:self];
    [self.webServiceManager executeCityWeatherSearch:city];
}

#pragma mark PGWebServiceManager delegate methods
- (void)processCompleted:(PGWebServiceResponse *)response {
}
- (void)processFailed:(PGWebServiceResponse *)response {
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
