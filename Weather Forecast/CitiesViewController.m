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

@interface CitiesViewController ()
-(IBAction)edit:(id)sender;

@property (strong, nonatomic) IBOutlet UIBarButtonItem *editButton;
@property (strong, nonatomic) IBOutlet UITableView *citiesTableView;

@property (nonatomic, strong) NSMutableArray *cities;
@property (nonatomic, strong) NSString *units;
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
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    self.units = [[NSString alloc]init];
    self.units = [userDefaults objectForKey:@"units"];
    if ([self.units length] == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Choose units" message:@"Please choose your units type" delegate:self cancelButtonTitle:Nil otherButtonTitles:@"Metric", @"Imperial", nil];
        [alert show];
    }
    
    
//    [userDefaults setObject:self.cities forKey:@"cities"];
	
    self.cities = [userDefaults objectForKey:@"cities"];
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
    cell.degreesLabel.text = [NSString stringWithFormat:@"%.f%@", city.temp, @"\u00B0"];
    cell.cityLabel.text = city.cityName;
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
    UIAlertView *messageAlert = [[UIAlertView alloc] initWithTitle:@"Row Selected" message:@"You've selected a row" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [messageAlert show];
    
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

@end
