//
//  WeatherDetailsViewController.h
//  Weather Forecast
//
//  Created by Mateusz Grzyb on 03.01.2014.
//  Copyright (c) 2014 Mateusz Grzyb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "City.h"

@interface WeatherDetailsViewController : UIViewController

@property (nonatomic) int cityId;

-(IBAction)segmentSwitch:(id)sender;
@property (nonatomic, strong) City *city;


@property (strong, nonatomic) IBOutlet UIView *todayView;
@property (strong, nonatomic) IBOutlet UIView *nextDaysView;
@property (strong, nonatomic) IBOutlet UILabel *cityNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *weatherDescriptionLabel;
@property (strong, nonatomic) IBOutlet UILabel *temperatureLabel;
@property (strong, nonatomic) IBOutlet UIImageView *icon;
@end
