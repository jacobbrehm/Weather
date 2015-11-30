//
//  WeatherAnnotation.m
//  Weather
//
//  Created by Jacob Brehm on 29.11.15.
//  Copyright © 2015 Jacob Brehm. All rights reserved.
//

#import "WeatherAnnotation.h"

@implementation WeatherAnnotation

+ (WeatherAnnotationType) weatherAnnotationTypeForIconName: (NSString*) iconName {
    if ([iconName isEqualToString:@"cloudy"]) {
        return WeatherAnnotationCloudy;
    } else if ([iconName isEqualToString:@"clear-day"]) {
        return WeatherAnnotationClearDay;
    } else if ([iconName isEqualToString:@"clear-night"]) {
        return WeatherAnnotationClearNight;
    } else if ([iconName isEqualToString:@"rain"]) {
        return WeatherAnnotationRain;
    } else if ([iconName isEqualToString:@"snow"]) {
        return WeatherAnnotationSnow;
    } else if ([iconName isEqualToString:@"sleet"]) {
        return WeatherAnnotationSleet;
    } else if ([iconName isEqualToString:@"wind"]) {
        return WeatherAnnotationWind;
    } else if ([iconName isEqualToString:@"fog"]) {
        return WeatherAnnotationFog;
    } else if ([iconName isEqualToString:@"partly-cloudy-day"]) {
        return WeatherAnnotationPartlyCloudyDay;
    } else if ([iconName isEqualToString:@"partly-cloudy-night"]) {
        return WeatherAnnotationPartlyCloudyNight;
    } else if ([iconName isEqualToString:@""]) {
        return WeatherAnnotationDefault;
    } else {
        return WeatherAnnotationDefault;
    }
}

- (void)setTemperature:(NSString *)temperature {
    _temperature = temperature;
    _title = [NSString stringWithFormat:@"Temperature: %@ °C", temperature];
}

- (void)setPressure:(NSString *)pressure {
    _pressure = pressure;
    _subtitle = [NSString stringWithFormat:@"Pressure: %@ hPa", pressure];
}

@end
