//
//  IconPicker.h
//  Weather Forecast
//
//  Created by Mateusz Grzyb on 01.01.2014.
//  Copyright (c) 2014 Mateusz Grzyb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IconPicker : NSObject
+(NSString*)iconForWeatherId:(int)weatherId andPartOfDay:(BOOL)isDay;
@end
