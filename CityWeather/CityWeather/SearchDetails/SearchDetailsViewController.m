//
//  WeatherSearchDetailsViewController.m
//  CityWeather
//  Created by Prasad on 4/2/14.
//  Copyright (c) 2014 propertyguru. All rights reserved.
//

#import "SearchDetailsViewController.h"
#import "PGWebServiceManager.h"
#import "Helper.h"
#import "DetailCell.h"
#import "constant.h"
#import "EGORefreshTableHeaderView.h"
#import "UIImageView+WebCache.h"

@interface  SearchDetailsViewController ()<PGWebserviceManagerDelegate,EGORefreshTableHeaderDelegate>

@property (nonatomic,strong) NSDictionary *weatherData;
@property (nonatomic,weak) IBOutlet UITableView *tblSearchDetails;
@property(nonatomic,strong) EGORefreshTableHeaderView *refreshHeaderView;
@property(nonatomic,assign) BOOL reloading;


- (void)reloadTableViewDataSource;
- (void)doneLoadingTableViewData;
@end

@implementation SearchDetailsViewController
@synthesize searchKeyword;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
         self.title=@"Weather Details";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadWeatherData];
    [self addRefereshView];
}

- (void) addRefereshView  {
    if (self.refreshHeaderView == nil) {
		EGORefreshTableHeaderView *view = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f - self.tblSearchDetails.bounds.size.height, self.view.frame.size.width, self.tblSearchDetails.bounds.size.height)];
		view.delegate = self;
		[self.tblSearchDetails addSubview:view];
		self.refreshHeaderView = view;
	}
	[_refreshHeaderView refreshLastUpdatedDate];
}

- (void) loadWeatherData {
    NSDictionary *dataDict=[Helper getWeatherDetailsWithLocation:self.searchKeyword];
    self.weatherData=[dataDict objectForKey:kData];
    [self.tblSearchDetails reloadData];
}


#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row==0) return 100.0;
    return 50.0;
}
// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    DetailCell *cell = (DetailCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"DetailCell" owner:self options:nil];
        if (indexPath.row==0)  cell = [nib objectAtIndex:0];
        else cell = [nib objectAtIndex:1];
    }
    switch (indexPath.row) {
        case 0: {
            NSArray *urlArray=[[[self.weatherData objectForKey:kCurrentCondition] objectAtIndex:0] objectForKey:kWeatherIconUrl];
            NSString *weatherIconUrl=[[urlArray objectAtIndex:0] objectForKey:kValue];
            [cell.iconView setImageWithURL:[NSURL URLWithString:weatherIconUrl]
                           placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
            cell.lblCityName.text=self.searchKeyword;
            break;
        }
        case 1:
            cell.lblTitle.text=@"Observation Time:";
            cell.lblValue.text=[[[self.weatherData objectForKey:kCurrentCondition] objectAtIndex:0] objectForKey:kObservationTime];
            break;
        case 2:
            cell.lblTitle.text=@"Humidity:";
            cell.lblValue.text=[NSString stringWithFormat:@"%@%%",[[[self.weatherData objectForKey:kCurrentCondition] objectAtIndex:0] objectForKey:kHumidity]];
            break;
        case 3: {
            cell.lblTitle.text=@"Weather Description:";
            NSArray *weatherDes=[[[self.weatherData objectForKey:kCurrentCondition] objectAtIndex:0] objectForKey:kWeatherDesc];
            NSString *weatherValue=[[weatherDes objectAtIndex:0] objectForKey:kValue];
            cell.lblValue.text=weatherValue;
            break;
        }
        default:
            break;
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma mark -
#pragma mark Data Source Loading / Reloading Methods
- (void)reloadTableViewDataSource{
	//  should be calling your tableviews data source model to reload
	//  put here just for demo
	_reloading = YES;
}

- (void)doneLoadingTableViewData{
    [super searchWeatherDetailsByLocation:self.searchKeyword];
	//  model should call this when its done loading
	_reloading = NO;
	[self.refreshHeaderView  egoRefreshScrollViewDataSourceDidFinishedLoading:self.tblSearchDetails];
}


#pragma mark -
#pragma mark UIScrollViewDelegate Methods
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
	[self.refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
	[self.refreshHeaderView  egoRefreshScrollViewDidEndDragging:scrollView];
}

#pragma mark EGORefreshTableHeaderDelegate Methods
- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view{
	[self reloadTableViewDataSource];
	[self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:3.0];
}

- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view{
	return self.reloading; // should return if data source model is reloading
}

- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view{
	return [NSDate date]; // should return date data source was last changed
}

- (void)processCompleted:(PGWebServiceResponse *)response {
    [self loadWeatherData];
	[self reloadTableViewDataSource];
    _reloading = NO;
}

- (void)processFailed:(PGWebServiceResponse *)response {
    Alert(@"Error", [response.error description]);
}


@end
