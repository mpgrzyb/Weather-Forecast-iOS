//
//  City.h
//  Weather Forecast
//
//  Created by Mateusz Grzyb on 01.01.2014.
//  Copyright (c) 2014 Mateusz Grzyb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface City : NSObject

#pragma mark - variables
@property (nonatomic, strong) NSString *cityName;
@property (nonatomic, strong) NSString *country;
@property (nonatomic) float longitude;
@property (nonatomic) float latitude;
@property (nonatomic) int cityId;
@property (nonatomic, strong) NSDate *lastRefresh;

#pragma mark - weather variables
@property (nonatomic) float temp;
@property (nonatomic) float tempMin;
@property (nonatomic) float tempMax;
@property (nonatomic) float pressure;
@property (nonatomic) float humidity;
@property (nonatomic) float windSpeed;
@property (nonatomic) float clouds;
@property (nonatomic) NSString *weatherMain;
@property (nonatomic) NSString *weatherDescription;

#pragma mark - methods
-(id) initWithData:(NSDictionary*) data;
-(id) initWithId:(int) cityId;
@end
