//
//  City.m
//  Weather Forecast
//
//  Created by Mateusz Grzyb on 01.01.2014.
//  Copyright (c) 2014 Mateusz Grzyb. All rights reserved.
//

#import "City.h"
@interface City()
-(void) setValues:(NSDictionary*)cityDictionary;
@end

@implementation City

-(id) initWithData:(NSDictionary*) firstData{
    self = [super init];
    
    if(self){
        [self setValues:firstData];
    }
    return self;
}

-(id) initWithId:(int)cityId andUnits:(NSString*)units{
    self = [super init];
    if(self){
        NSURL *targetURL = [NSURL URLWithString:[NSString stringWithFormat:@"http://api.openweathermap.org/data/2.5/weather?id=%d&units=%@", cityId, [units stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]]];
        NSURLRequest *request = [NSURLRequest requestWithURL:targetURL];
        NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
        NSDictionary *dictionary = [[NSDictionary alloc] init];
        dictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        
        NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
        NSDate *dateNow = [[NSDate alloc] init];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        [dict setObject:[dateFormatter stringFromDate:dateNow] forKey:@"refreshDateTime"];
        [dict setObject:dictionary forKey:@"cityData"];
        self.dictionary = dict;
        [self setValues:dict];
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

#pragma mark - Setting values for all variables
-(void) setValues:(NSDictionary*)cityDictionary{
    NSDictionary *data = [NSDictionary dictionaryWithDictionary:[cityDictionary objectForKey:@"cityData"]];
    
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
    self.cloudiness = [[[data objectForKey:@"clouds"] objectForKey:@"all"] floatValue];
    
    self.timeNow = [NSDate dateWithTimeIntervalSince1970:[[data objectForKey:@"dt"] doubleValue]];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH"];
    
    self.sunSet = [NSDate dateWithTimeIntervalSince1970:[[[data objectForKey:@"sys"] objectForKey:@"sunset"] doubleValue]];
    self.sunRise = [NSDate dateWithTimeIntervalSince1970:[[[data objectForKey:@"sys"] objectForKey:@"sunrise"] doubleValue]];
    
    if(self.sunSet < self.timeNow || self.sunRise > self.timeNow){
        self.isDay = NO;
    }else{
        self.isDay = YES;
    }
    
    self.timeOfLastRefresh = [cityDictionary objectForKey:@"refreshDateTime"];
    
    NSArray *tmpArray = [[NSArray alloc]init];
    NSDictionary *tmpDictionary = [[NSDictionary alloc] init];
    tmpArray = [data objectForKey:@"weather"];
    tmpDictionary = [tmpArray objectAtIndex:0];
    self.weatherId = [[tmpDictionary objectForKey:@"id"] integerValue];
    self.weatherMain = [tmpDictionary objectForKey:@"main"];
    self.weatherDescription = [tmpDictionary objectForKey:@"description"];
}

-(void) refreshData:(int) rowNum{
    NSUserDefaults *userDefaults = [[NSUserDefaults alloc] init];
    NSString *units = [userDefaults objectForKey:@"units"];
    
    NSURL *targetURL = [NSURL URLWithString:[NSString stringWithFormat:@"http://api.openweathermap.org/data/2.5/weather?id=%d&units=%@", self.cityId, [units stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]]];
    NSURLRequest *request = [NSURLRequest requestWithURL:targetURL];
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSDictionary *dictionary = [[NSDictionary alloc] init];
    dictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    NSDate *dateNow = [[NSDate alloc] init];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    [dict setObject:[dateFormatter stringFromDate:dateNow] forKey:@"refreshDateTime"];
    [dict setObject:dictionary forKey:@"cityData"];
    self.dictionary = dict;
    [self setValues:dict];
    
    NSMutableArray *tmpCitiesList = [[NSMutableArray alloc] init];
    [tmpCitiesList addObjectsFromArray:[userDefaults objectForKey:@"cities"]];
    
    [tmpCitiesList replaceObjectAtIndex:rowNum withObject:dict];
    [userDefaults setObject:tmpCitiesList forKey:@"cities"];
}

-(NSString*) updateTime{
    NSDate *dateNow = [[NSDate alloc] init];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date = [[NSDate alloc] init];
    date = [dateFormatter dateFromString:self.timeOfLastRefresh];
    NSTimeInterval secondsBetween = [dateNow timeIntervalSinceDate:date];
    float hourssBetween = secondsBetween/3600.0;
    float minutesBetween = secondsBetween / 60.0;
    if(secondsBetween > 0 && secondsBetween < 2){
        return @"1 second";
    }else if(secondsBetween > 59 && secondsBetween < 3600.0){
        return [NSString stringWithFormat:@"%.0f min", minutesBetween];
    }else if(secondsBetween < 60){
        return [NSString stringWithFormat:@"%.0f sec", secondsBetween];
    }else if(secondsBetween > 3599){
        return [NSString stringWithFormat:@"%.0f sec", hourssBetween];
    }
    return nil;
}

@end
