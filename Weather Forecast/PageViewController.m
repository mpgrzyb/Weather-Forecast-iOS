//
//  PageViewController.m
//  Weather Forecast
//
//  Created by Mateusz Grzyb on 05.01.2014.
//  Copyright (c) 2014 Mateusz Grzyb. All rights reserved.
//

#import "PageViewController.h"

@interface PageViewController ()
-(IBAction)refreshData:(id)sender;
@end

@implementation PageViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIStoryboard *storyBoard = [self storyboard];
    self.dataSource = self;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refreshData:)];
    
    self.weatherDetailViewController = [storyBoard instantiateViewControllerWithIdentifier:@"WeatherDetails"];
    [self.weatherDetailViewController setCity:self.city];
    self.weatherForecastViewController = [storyBoard instantiateViewControllerWithIdentifier:@"WeatherForecast"];
    [self setViewControllers:@[self.weatherDetailViewController] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    
}
-(UIViewController*)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController{
    UIViewController *beforeViewController = nil;
    if (viewController == self.weatherDetailViewController) {
        beforeViewController = self.weatherForecastViewController;
    }
    return beforeViewController;
}

-(UIViewController*)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController{
    UIViewController *afterViewController = nil;
    if(viewController == self.weatherForecastViewController){
        afterViewController = self.weatherDetailViewController;
    }
    return afterViewController;
}


-(IBAction)refreshData:(id)sender{
    [self.city refreshData:self.numOfCityCell];
    [self.weatherDetailViewController setCity:self.city];
    [self.weatherDetailViewController refreshData];
}

@end
