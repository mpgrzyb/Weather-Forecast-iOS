//
//  WeatherForecastViewController.m
//  Weather Forecast
//
//  Created by Mateusz Grzyb on 05.01.2014.
//  Copyright (c) 2014 Mateusz Grzyb. All rights reserved.
//

#import "WeatherForecastViewController.h"
#import "WeatherForecastCell.h"

@interface WeatherForecastViewController ()

@end

@implementation WeatherForecastViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

#pragma mark - Weather details TableView

- (NSInteger) tableView:(UITableView*) tableView numberOfRowsInSection:(NSInteger)section{
    return 7;
}

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(UITableViewCell*) tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WeatherForecastCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    
    switch (indexPath.row) {
        case 0:
            cell.dayOfWeek.text = @"Poniedziałek";
            break;
        case 1:
            cell.dayOfWeek.text = @"Wtorek";
            break;
        case 2:
            cell.dayOfWeek.text = @"Środa";
            break;
        case 3:
            cell.dayOfWeek.text = @"Czwartek";
            break;
        case 4:
            cell.dayOfWeek.text = @"Piątek";
            break;
        case 5:
            cell.dayOfWeek.text = @"Sobota";
            break;
        case 6:
            cell.dayOfWeek.text = @"Niedziela";
            break;
    }
    
    return cell;
}


@end
