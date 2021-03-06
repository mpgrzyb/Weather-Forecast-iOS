//
//  AddCityViewController.m
//  Weather Forecast
//
//  Created by Mateusz Grzyb on 31.12.2013.
//  Copyright (c) 2013 Mateusz Grzyb. All rights reserved.
//

#import "AddCityViewController.h"
#import "City.h"

@interface AddCityViewController ()
@property (nonatomic, strong) NSURLConnection *conn;
-(void) addCity:(NSDictionary*)cityData;

@property(nonatomic, strong) NSUserDefaults *userDefaults;
@property (strong, nonatomic) IBOutlet UIView *waitView;
@end

@implementation AddCityViewController

-(void) viewWillAppear:(BOOL)animated{
    [[self.navigationController navigationBar]setTintColor:[UIColor whiteColor]];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.userDefaults = [[NSUserDefaults alloc] init];
   
    [self.searchBar setPlaceholder:@"Find your city"];
    [self.searchBar becomeFirstResponder];
    
    
//    Set up of location manager
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.distanceFilter = kCLDistanceFilterNone;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyKilometer;
}

#pragma mark - SearchBar Actions

-(void) searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [self.searchBar resignFirstResponder];
    [self.activityIndicator startAnimating];
    [self downloadCities:self.searchBar.text];
    [self.waitView setHidden:NO];
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    self.citiesList = [[NSMutableArray alloc] init];
    self.responseData = [[NSMutableData alloc] init];
    [self.tableView setHidden:YES];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

#pragma mark - Cities TableView

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    int number = [self.citiesList count];
    return number;
}

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    int number = 1;
    return number;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *identifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    NSDictionary *tmpDictionary = [self.citiesList objectAtIndex:indexPath.row];
    cell.detailTextLabel.text = [[tmpDictionary objectForKey:@"sys"] objectForKey:@"country"];
    cell.textLabel.text = [tmpDictionary objectForKey:@"name"];
    return cell;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSMutableDictionary *selectedCity = [self.citiesList objectAtIndex:indexPath.row];
    [self addCity:selectedCity];
}

#pragma mark - Download Cities

-(void) downloadCities:(NSString*)city{
    NSString *units = [[NSString alloc] init];
    units = [self.userDefaults objectForKey:@"units"];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://api.openweathermap.org/data/2.5/find?q=%@&type=like&mode=json&units=%@", [city stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]], [units stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]]]];
    [request setHTTPMethod:@"GET"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Current-Type"];
    self.conn = [[NSURLConnection alloc]initWithRequest:request delegate:self];
}

-(void) downloadCitiesWithLongitude:(float)longitude andLatitude:(float)latitude{
    NSString *units = [[NSString alloc] init];
    units = [self.userDefaults objectForKey:@"units"];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://api.openweathermap.org/data/2.5/find?lat=%f&lon=%f&units=%@", latitude, longitude, [units stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]]]];
    [request setHTTPMethod:@"GET"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Current-Type"];
    self.conn = [[NSURLConnection alloc]initWithRequest:request delegate:self];
}

#pragma mark - Server Connection

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [self.responseData appendData:data];
    NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:self.responseData options:0 error:nil];
    self.citiesList = [dictionary objectForKey:@"list"];

    if ([self.citiesList count] > 0) {
        [self.tableView setHidden:NO];
        [self.tableView reloadData];
        [self.waitView setHidden:YES];
        [self.activityIndicator stopAnimating];
    }
}

#pragma mark - Other methods

-(void) addCity:(NSMutableDictionary*)cityData{
    NSMutableArray *tmpCitiesList = [[NSMutableArray alloc] init];
    [tmpCitiesList addObjectsFromArray:[self.userDefaults objectForKey:@"cities"]];
    
    int cityId = [[cityData objectForKey:@"id"] integerValue];
    City *city = [[City alloc] initWithId:cityId andUnits:[self.userDefaults objectForKey:@"units"]];
    [tmpCitiesList addObject:[city dictionary]];
    [self.userDefaults setObject:tmpCitiesList forKey:@"cities"];
}

#pragma mark - Use geolocation data

-(IBAction)useGeolocationData:(id)sender{
    self.citiesList = [[NSMutableArray alloc] init];
    self.responseData = [[NSMutableData alloc] init];
    
    [self.tableView setHidden:YES];
    [self.locationManager startUpdatingLocation];
    [self.searchBar resignFirstResponder];
    [self.activityIndicator startAnimating];
    [self.waitView setHidden:NO];
    [self downloadCitiesWithLongitude:self.locationManager.location.coordinate.longitude andLatitude:self.locationManager.location.coordinate.latitude];
}

@end
