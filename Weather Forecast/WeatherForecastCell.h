//
//  WeatherForecastCell.h
//  Weather Forecast
//
//  Created by Mateusz Grzyb on 05.01.2014.
//  Copyright (c) 2014 Mateusz Grzyb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WeatherForecastCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *weatherIcon;
@property (strong, nonatomic) IBOutlet UILabel *dayOfWeek;
@property (strong, nonatomic) IBOutlet UILabel *temperature;

@end
