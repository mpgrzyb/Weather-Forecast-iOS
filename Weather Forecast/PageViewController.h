//
//  PageViewController.h
//  Weather Forecast
//
//  Created by Mateusz Grzyb on 05.01.2014.
//  Copyright (c) 2014 Mateusz Grzyb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "City.h"
#import "WeatherDetailsViewController.h"
#import "WeatherForecastViewController.h"

@interface PageViewController : UIPageViewController <UIPageViewControllerDataSource>
@property (nonatomic, strong) City *city;
@property (nonatomic, strong) WeatherDetailsViewController *weatherDetailViewController;
@property (nonatomic, strong) WeatherForecastViewController *weatherForecastViewController;
@end
