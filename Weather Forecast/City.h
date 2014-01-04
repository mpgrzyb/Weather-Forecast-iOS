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
@property (nonatomic, strong) NSString *timeOfLastRefresh;
@property (nonatomic, strong) NSDate *timeNow;
@property (nonatomic, strong) NSDate *sunSet;
@property (nonatomic, strong) NSDate *sunRise;
@property (nonatomic) BOOL isDay;
@property (nonatomic, strong) NSDictionary *dictionary;

#pragma mark - weather variables
@property (nonatomic) float temp; // in degrees
@property (nonatomic) float tempMin; // in degrees
@property (nonatomic) float tempMax; // in degrees
@property (nonatomic) float pressure; // in hPa
@property (nonatomic) float humidity; // in %
@property (nonatomic) float windSpeed; // in mps
@property (nonatomic) float cloudiness; // Cloudiness in %
@property (nonatomic) int weatherId; // weather id
@property (nonatomic, strong) NSString *weatherMain; // main description
@property (nonatomic, strong) NSString *weatherDescription; // longer description

#pragma mark - methods
-(id) initWithData:(NSDictionary*) firstData;
-(id) initWithId:(int) cityId andUnits:(NSString*)units;
-(BOOL) isWeatherActual;
@end
