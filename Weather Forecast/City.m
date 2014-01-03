//
//  City.m
//  Weather Forecast
//
//  Created by Mateusz Grzyb on 01.01.2014.
//  Copyright (c) 2014 Mateusz Grzyb. All rights reserved.
//

#import "City.h"

@implementation City

-(id) initWithData:(NSDictionary*) firstData{
    self = [super init];
    
    if(self){
        NSDictionary *data = [NSDictionary dictionaryWithDictionary:[firstData objectForKey:@"cityData"]];
        
        self.cityName = [data objectForKey:@"name"];
        self.country = [[data objectForKey:@"sys"] objectForKey:@"country"];
        self.latitude = [[[data objectForKey:@"coord"] objectForKey:@"lon"] floatValue];
        self.longitude = [[[data objectForKey:@"coord"] objectForKey:@"lat"] floatValue];
        self.cityId = [[data objectForKey:@"id"] intValue];
        
        self.temp = [[[data objectForKey:@"main"] objectForKey:@"temp"] floatValue];
        self.tempMin = [[[data objectForKey:@"main"] objectForKey:@"temp_min"] floatValue];
        self.tempMax = [[[data objectForKey:@"main"] objectForKey:@"temp_max"] floatValue];
        self.pressure = [[[data objectForKey:@"main"] objectForKey:@"pressure"]  floatValue];
        self.humidity = [[[data objectForKey:@"main"] objectForKey:@"humidity"] floatValue];
        self.windSpeed = [[[data objectForKey:@"wind"] objectForKey:@"speed"] floatValue];
        self.clouds = [[[data objectForKey:@"clouds"] objectForKey:@"all"] floatValue];
        
        self.timeNow = [NSDate dateWithTimeIntervalSince1970:[[data objectForKey:@"dt"] doubleValue]];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"HH"];
        NSString *hourTmp = [[NSString alloc] initWithString:[dateFormatter stringFromDate:self.timeNow]];
        int hour = [hourTmp integerValue];
        if(hour < 6 && hour >= 21){
            self.isDay = NO;
        }else{
            self.isDay = YES;
        }
        
        self.timeOfLastRefresh = [firstData objectForKey:@"refreshDateTime"];
        
        NSArray *tmpArray = [[NSArray alloc]init];
        NSDictionary *tmpDictionary = [[NSDictionary alloc] init];
        tmpArray = [data objectForKey:@"weather"];
        tmpDictionary = [tmpArray objectAtIndex:0];
        self.weatherId = [[tmpDictionary objectForKey:@"id"] integerValue];
        self.weatherMain = [tmpDictionary objectForKey:@"main"];
        self.weatherDescription = [tmpDictionary objectForKey:@"description"];
    }
    return self;
}

-(id) initWithId:(int)cityId{
    self = [super init];
    if(self){
        self.cityId = cityId;
    }
    return self;
}

-(BOOL)isWeatherActual{
    NSDate *dateNow = [[NSDate alloc] init];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date = [[NSDate alloc] init];
    date = [dateFormatter dateFromString:self.timeOfLastRefresh];
    
    NSTimeInterval secondsBetween = [dateNow timeIntervalSinceDate:date];
    int numberOfMinutes = secondsBetween / 60;
    if (numberOfMinutes >= 30) {
        return NO;
    }
    return YES;
}
@end
