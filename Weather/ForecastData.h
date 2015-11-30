//
//  ForecastData.h
//  Weather
//
//  Created by Jacob Brehm on 29.11.15.
//  Copyright © 2015 Jacob Brehm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ForecastData : NSObject

@property (nonatomic, strong) NSNumber* temperature;
@property (nonatomic, strong) NSNumber* apparentTemperature;
@property (nonatomic, strong) NSNumber* pressure;
@property (nonatomic, strong) NSNumber* windSpeed;
@property (nonatomic, strong) NSDate* time;
@property (nonatomic, strong) NSString* iconName;

@property (nonatomic, strong) NSNumber* longitude;
@property (nonatomic, strong) NSNumber* latitude;

@end
