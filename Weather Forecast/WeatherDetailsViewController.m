//
//  WeatherDetailsViewController.m
//  Weather Forecast
//
//  Created by Mateusz Grzyb on 03.01.2014.
//  Copyright (c) 2014 Mateusz Grzyb. All rights reserved.
//

#import "WeatherDetailsViewController.h"
#import "IconPicker.h"

@interface WeatherDetailsViewController ()
@property (nonatomic, strong) NSDateFormatter *dateFormatter;
@end

@implementation WeatherDetailsViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[self.navigationController navigationBar] setTintColor:[UIColor whiteColor]];
    [self.navigationItem.backBarButtonItem setWidth:10];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.dateFormatter = [[NSDateFormatter alloc] init];
    [self.dateFormatter setDateFormat:@"HH:mm"];
    [self.icon setImage:[UIImage imageNamed:[IconPicker iconForWeatherId:self.city.weatherId andPartOfDay:self.city.isDay]]];
    [self.cityNameLabel setText:self.city.cityName];
    [self.weatherDescriptionLabel setText:self.city.weatherMain];
    [self.temperatureLabel setText:[NSString stringWithFormat:@"%.0f%@", self.city.temp, @"\u00B0"]];
}

#pragma mark - Weather details TableView

- (NSInteger) tableView:(UITableView*) tableView numberOfRowsInSection:(NSInteger)section{
    return 6;
}

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(UITableViewCell*) tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    
    switch (indexPath.row) {
        case 0:
            cell.textLabel.text = @"Humidity";
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%.0f%@", self.city.humidity, @"%"];
            break;
        case 1:
            cell.textLabel.text = @"Preasure";
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%.0f hPa", self.city.pressure];
            break;
        case 2:
            cell.textLabel.text = @"Wind speed";
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%.1f m/s", self.city.windSpeed];
            break;
        case 3:
            cell.textLabel.text = @"Cloudiness";
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%.0f%@", self.city.cloudiness, @"%"];
            break;
        case 4:
            cell.textLabel.text = @"Sunrise";
            cell.detailTextLabel.text = [self.dateFormatter stringFromDate:self.city.sunRise];
            break;
        case 5:
            cell.textLabel.text = @"Sunset";
            cell.detailTextLabel.text = [self.dateFormatter stringFromDate:self.city.sunSet];
            break;
    }
    
    return cell;
}
@end
