//
//  AddCityViewController.m
//  Weather Forecast
//
//  Created by Mateusz Grzyb on 31.12.2013.
//  Copyright (c) 2013 Mateusz Grzyb. All rights reserved.
//

#import "AddCityViewController.h"

@interface AddCityViewController ()
@property (nonatomic, strong) NSURLConnection *conn;
@end

@implementation AddCityViewController

#pragma mark - SearchBar Actions

-(void) searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [self.searchBar resignFirstResponder];
    [self.activityIndicator setHidden:NO];
    [self.activityIndicator startAnimating];
    [self.message setHidden:NO];
    [self downloadCities:self.searchBar.text];
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    self.citiesList = [[NSArray alloc] init];
    self.responseData = [[NSMutableData alloc] init];
    self.citiesList = [[NSMutableArray alloc] init];
    
    [self.activityIndicator setHidden:YES];
    [self.activityIndicator stopAnimating];
    [self.tableView setHidden:YES];
    [self.message setHidden:YES];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void) viewWillAppear:(BOOL)animated{
    [[self.navigationController navigationBar]setTintColor:[UIColor whiteColor]];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.activityIndicator setHidden:YES];
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

#pragma mark - Download Cities

-(void) downloadCities:(NSString*)city{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://api.openweathermap.org/data/2.5/find?q=%@&type=like&mode=json", [city stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]]]];
    [request setHTTPMethod:@"POST"];
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
    }
}
@end
