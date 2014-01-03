//
//  IconPicker.m
//  Weather Forecast
//
//  Created by Mateusz Grzyb on 01.01.2014.
//  Copyright (c) 2014 Mateusz Grzyb. All rights reserved.
//

#import "IconPicker.h"

@implementation IconPicker
+(NSString*)iconForWeatherId:(int)weatherId andPartOfDay:(BOOL)isDay{
    if (weatherId < 300) {
        return @"storm";
    }else if (weatherId >= 300 && weatherId < 322){
        return @"downpour";
    }else if (weatherId >= 500 && weatherId < 505){
        return @"little_rain";
    }else if (weatherId == 511){
        return @"snow";
    }else if (weatherId >= 520 && weatherId < 532){
        return @"downpour";
    }else if (weatherId >= 600 && weatherId < 623){
        return @"downpour";
    }else if (weatherId >= 700 && weatherId < 800 && isDay == NO){
        return @"fog_night";
    }else if (weatherId >= 700 && weatherId < 800 && isDay == YES){
        return @"fog_day";
    }else if (weatherId == 800 && isDay == NO){
        return @"moon";
    }else if (weatherId == 800 && isDay == YES){
        return @"sun";
    }else if (weatherId == 801 && isDay == NO){
        return @"partly_cloudy_night";
    }else if (weatherId == 801 && isDay == YES){
        return @"partly_cloudy";
    }else if (weatherId >= 802 && weatherId < 900){
        return @"clouds";
    }
    
    return @"sun";
}
@end
