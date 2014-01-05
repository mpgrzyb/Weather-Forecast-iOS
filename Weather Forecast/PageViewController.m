//
//  PageViewController.m
//  Weather Forecast
//
//  Created by Mateusz Grzyb on 05.01.2014.
//  Copyright (c) 2014 Mateusz Grzyb. All rights reserved.
//

#import "PageViewController.h"

@interface PageViewController ()

@end

@implementation PageViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIStoryboard *storyBoard = [self storyboard];
    self.dataSource = self;
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


@end
