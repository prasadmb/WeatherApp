//
//  SearchViewController.m
//  CityWeather
//
//  Created by Prasad on 4/2/14.
//  Copyright (c) 2014 propertyguru. All rights reserved.
//

#import "SearchViewController.h"
#import "PGWebServiceManager.h"
#import "Helper.h"
#import "NSArray+Search.h"
#import "constant.h"
#import "SearchDetailsViewController.h"

@interface SearchViewController ()<PGWebserviceManagerDelegate>
@property (nonatomic,weak) IBOutlet UITableView *tblSearch;
@property (nonatomic,weak) IBOutlet UISearchBar *searchBar;
@property (nonatomic,weak)  IBOutlet UIActivityIndicatorView *indicator;
@property (nonatomic,strong) NSArray *savedLocations;
@property (nonatomic,strong) NSArray *searchResults;
@end

@implementation SearchViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title=@"Search";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.indicator setHidden:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    [self.tblSearch reloadData];
}

- (void) startSearch {
    self.savedLocations=[Helper getSavedLocations];
    self.searchResults=[self.savedLocations searchItemsWithString:self.searchBar.text];
}

- (void) resetSearchResults {
    self.searchResults =nil;
    [self.tblSearch reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.searchResults count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *MyIdentifier = @"MyIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                       reuseIdentifier:MyIdentifier];
    }
    cell.textLabel.text = [self.searchResults objectAtIndex:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.searchBar.text=[self.searchResults objectAtIndex:indexPath.row];
    SearchDetailsViewController *searchDetailsViewController=[[SearchDetailsViewController alloc]init];
    searchDetailsViewController.searchKeyword=self.searchBar.text;
    [self.navigationController pushViewController:searchDetailsViewController animated:YES];
}

#pragma mark - Search Implementation
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    if([searchText length] != 0) {
        [self startSearch];
    }
    else {
        [self.searchBar resignFirstResponder];
    }
    [self.tblSearch reloadData];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    [self.tblSearch reloadData];
}
- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar  {
    [self resetSearchResults];
    [self startSearch];
    return YES;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    if ([searchBar.text length]==0) {
        Alert(@"Warning", @"Please enter valid city");
    }
    [super searchWeatherDetailsByLocation:searchBar.text];
    [self.indicator setHidden:NO];
    [self.indicator startAnimating];
    [searchBar resignFirstResponder];
}


#pragma mark PGWebServiceManager delegate methods
- (void)processCompleted:(PGWebServiceResponse *)response {
    NSDictionary *jsonDict=response.getJSON;
    NSDictionary *weatherData=[jsonDict objectForKey:kData];
    if (![weatherData objectForKey:kError]) {
        [Helper saveSearchItem:self.searchBar.text];
        [Helper saveWeatherDataWithLocation:self.searchBar.text data:jsonDict];
  
        SearchDetailsViewController *searchDetailsViewController=[[SearchDetailsViewController alloc]init];
        searchDetailsViewController.searchKeyword=self.searchBar.text;
        [self.navigationController pushViewController:searchDetailsViewController animated:YES];
    }
    else {
        Alert(@"Error", [[[weatherData objectForKey:kError] objectAtIndex:0] objectForKey:kErrorMsg]);
    }
    [self.indicator setHidden:YES];

}

- (void)processFailed:(PGWebServiceResponse *)response {
    Alert(@"Error", [response.error description]);
    [self.indicator setHidden:YES];
}

@end
