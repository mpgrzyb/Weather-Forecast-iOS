//
//  WeatherDetailsViewController.m
//  Weather Forecast
//
//  Created by Mateusz Grzyb on 03.01.2014.
//  Copyright (c) 2014 Mateusz Grzyb. All rights reserved.
//

#import "WeatherDetailsViewController.h"

@interface WeatherDetailsViewController ()

@end

@implementation WeatherDetailsViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[self.navigationController navigationBar] setTintColor:[UIColor whiteColor]];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
