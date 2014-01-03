//
//  CitiesViewController.m
//  Weather Forecast
//
//  Created by Mateusz Grzyb on 31.12.2013.
//  Copyright (c) 2013 Mateusz Grzyb. All rights reserved.
//

#import "CitiesViewController.h"
#import "CityCell.h"
#import "City.h"
#import "IconPicker.h"

@interface CitiesViewController ()
-(IBAction)edit:(id)sender;

@property (strong, nonatomic) IBOutlet UIBarButtonItem *editButton;
@property (strong, nonatomic) IBOutlet UITableView *citiesTableView;

@property (nonatomic, strong) NSMutableArray *cities;

@property (nonatomic, strong) NSString *units;
@property (nonatomic, strong) NSURLConnection *conn;
@property (nonatomic, retain) NSMutableData* responseData;
@property (nonatomic, strong) NSUserDefaults *userDefaults;
@property (nonatomic, strong) NSMutableArray *itemsToUpdate;
@end

@implementation CitiesViewController

-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationItem setHidesBackButton:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.cities = [[NSMutableArray alloc] init];
    self.userDefaults = [NSUserDefaults standardUserDefaults];
    self.responseData = [[NSMutableData alloc] init];
    
//    [userDefaults removeObjectForKey:@"units"];
//    [self.userDefaults removeObjectForKey:@"cities"];

    self.units = [[NSString alloc]init];
    self.units = [self.userDefaults objectForKey:@"units"];
    
    if ([self.units length] == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Choose units" message:@"Please choose your units type" delegate:self cancelButtonTitle:Nil otherButtonTitles:@"Metric", @"Imperial", nil];
        [alert show];
    }
    self.cities = [self.userDefaults objectForKey:@"cities"];
    
    if ([self.cities count] == 0) {
        [self.citiesTableView setHidden:YES];
    }
}

#pragma mark - Cities TableView

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    int number = [self.cities count];
    return number;
}

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    int number = 1;
    return number;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *identifier = @"Cell";
    CityCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    
    City *city = [[City alloc] initWithData:[self.cities objectAtIndex:indexPath.row]];
    if(city.isWeatherActual == NO){
        UIAlertView *messageAlert = [[UIAlertView alloc] initWithTitle:@"Test" message:@"Nieaktualne dane" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [messageAlert show];
        city = [[City alloc] initWithData:[self downloadCityData:city.cityId rowToUpdate:indexPath.row]];
    }
    
    cell.degreesLabel.text = [NSString stringWithFormat:@"%.f%@", city.temp, @"\u00B0"];
    cell.cityLabel.text = city.cityName;
    UIImage *icon = [UIImage imageNamed:[IconPicker iconForWeatherId:city.weatherId andPartOfDay:city.isDay]];
    [cell.weatherIcon setImage:icon];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        if (editingStyle == UITableViewCellEditingStyleDelete)
        {
            [self.cities removeObjectAtIndex:indexPath.row];
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            [userDefaults setObject:self.cities forKey:@"cities"];
        }
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark - Edit button click event

-(IBAction)edit:(id)sender{
    if ([self.editButton.title isEqualToString:@"Edit"]) {
        [self.editButton setTitle:@"Done"];
        [self.citiesTableView setEditing:YES];
    }else{
        [self.editButton setTitle:@"Edit"];
        [self.citiesTableView setEditing:NO];
    }
}

#pragma mark - Alert buttons click event

-(void)alertView:(UIAlertView*)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    switch (buttonIndex) {
        case 0:
            [userDefaults setObject:@"metric" forKey:@"units"];
            break;
        case 1:
            [userDefaults setObject:@"imperial" forKey:@"units"];
            break;
    }
}

#pragma mark - Download Citie data

-(NSDictionary*) downloadCityData:(int)cityId rowToUpdate:(int)rowNum{
    NSString *units = [[NSString alloc] init];
    units = [self.userDefaults objectForKey:@"units"];
    NSURL *targetURL = [NSURL URLWithString:[NSString stringWithFormat:@"http://api.openweathermap.org/data/2.5/weather?id=%d&units=%@", cityId, [units stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]]];
    NSURLRequest *request = [NSURLRequest requestWithURL:targetURL];
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSDictionary *dictionary = [[NSDictionary alloc] init];
    dictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    NSDate *dateNow = [[NSDate alloc] init];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    [dict setObject:[dateFormatter stringFromDate:dateNow] forKey:@"refreshDateTime"];
    [dict setObject:dictionary forKey:@"cityData"];

    [self.cities replaceObjectAtIndex:rowNum withObject:dict];
    [self.userDefaults setObject:self.cities forKey:@"cities"];
    
    return dict;
}


@end
