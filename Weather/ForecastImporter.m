//
//  ForecastImporter.m
//  Weather
//
//  Created by Jacob Brehm on 25.11.15.
//  Copyright © 2015 Jacob Brehm. All rights reserved.
//

#import "ForecastImporter.h"
#import "Forecastr.h"
#import <MapKit/MapKit.h>

@interface ForecastImporter()

@property (strong, nonatomic) Forecastr *forecastr;

@end

@implementation ForecastImporter

#pragma mark - Init & Setup

- (id) init {
    if (self = [super init]) {
        [self setupForecastr];
    }
    
    return self;
}

- (id) initWithWeatherLocations: (NSArray*) weatherLocations {
    if (self = [self init]) {
        self.weatherLocations = weatherLocations;
    }
    
    return self;
}

- (void) setupForecastr {
    self.forecastr = [Forecastr sharedManager];
    self.forecastr.apiKey = @"8bbd5b401e6d13017e587e0951ccf040"; //forecast.io API-Key
    self.forecastr.units = kFCUKUnits;
}

- (void) startForecastImport {
    
    if (!self.weatherLocations) {
        // cancel in case there are no weather locations given
        NSLog(@"[ForecastImporter] ERROR - No weatherlocation given");
        return;
    }
    
    for (CLLocation* location in self.weatherLocations) {
        [self getCurrentWeatherForLocation:location withSuccess:^(id parsedJSON) {
            [self.delegate didFinishForecastImportWithForecastData:[self getForecastDataForJSON:parsedJSON]];
        }];
    }
}

#pragma mark - Weather forecast requests

- (void) getCurrentWeatherForLocation: (CLLocation*) location withSuccess:(void (^)(id parsedJSON))successHandler {
    NSArray *exclusions = @[kFCAlerts, kFCFlags, kFCMinutelyForecast, kFCHourlyForecast, kFCDailyForecast];
    
    [self.forecastr getForecastForLatitude:location.coordinate.latitude longitude:location.coordinate.longitude time:[self timeStamp] exclusions:exclusions extend:nil language:nil success:^(id JSON) {
        // call delegate with parsed forecast data
        successHandler(JSON);
    
    } failure:^(NSError *error, id response) {
        NSLog(@"[ForecastImporter] ERROR - Error while retrieving forecast: %@", [self.forecastr messageForError:error withResponse:response]);
    }];
}

- (void) getCurrentAlertsForLocation: (CLLocation*) location withSuccess:(void (^)(id parsedJSON))successHandler {
    // exclude everything except Alerts
    NSArray *exclusions = @[kFCCurrentlyForecast, kFCFlags, kFCMinutelyForecast, kFCHourlyForecast, kFCDailyForecast];
    
    [self.forecastr getForecastForLatitude:location.coordinate.latitude longitude:location.coordinate.longitude time:[self timeStamp] exclusions:exclusions extend:nil language:nil success:^(id JSON) {
        NSLog(@"[ForecastImporter] WARNING - WeatherAlert received, but not implemented - JSON Response was: %@", JSON);
        successHandler(JSON);
    
    } failure:^(NSError *error, id response) {
        NSLog(@"[ForecastImporter] ERROR - Error while retrieving forecast: %@", [self.forecastr messageForError:error withResponse:response]);
    }];
}

#pragma mark - private helper

- (NSNumber*) timeStamp {
    return [NSNumber numberWithDouble:(double)[[NSDate date] timeIntervalSince1970]];
}

- (ForecastData*) getForecastDataForJSON: (id)JSON {
    
    NSDictionary* dataDictionary;
    
    // serialize json if needed
    if ([JSON isKindOfClass:[NSDictionary class]]) {
        dataDictionary = JSON;
    } else {
        dataDictionary = [NSJSONSerialization JSONObjectWithData:[JSON dataUsingEncoding:NSUTF8StringEncoding] options:0 error:nil];
    }
    
    // Create ForecastData-Class
    ForecastData *forecastData = [[ForecastData alloc] init];
    
    // add location information
    if ([[dataDictionary objectForKey:@"latitude"] isKindOfClass:[NSNumber class]]) {
        forecastData.latitude = [dataDictionary objectForKey:@"latitude"];
    }
    
    if ([[dataDictionary objectForKey:@"longitude"] isKindOfClass:[NSNumber class]]) {
        forecastData.longitude = [dataDictionary objectForKey:@"longitude"];
    }
    
    
    // Check if there is data for "currently"
    if ([[dataDictionary objectForKey:@"currently"] isKindOfClass:[NSDictionary class]]) {
        
        NSDictionary* currentWeather = [dataDictionary objectForKey:@"currently"];
        
        // map weather data to the ForecastData-class
        
        if ([[currentWeather objectForKey:@"temperature"] isKindOfClass:[NSNumber class]]) {
            forecastData.temperature = [currentWeather objectForKey:@"temperature"];
        }
        
        if ([[currentWeather objectForKey:@"apparentTemperature"] isKindOfClass:[NSNumber class]]) {
            forecastData.apparentTemperature = [currentWeather objectForKey:@"apparentTemperature"];
        }
        
        if ([[currentWeather objectForKey:@"pressure"] isKindOfClass:[NSNumber class]]) {
            forecastData.pressure = [currentWeather objectForKey:@"pressure"];
        }
        
        if ([[currentWeather objectForKey:@"windSpeed"] isKindOfClass:[NSNumber class]]) {
            forecastData.windSpeed = [currentWeather objectForKey:@"windSpeed"];
        }
        
        if ([[currentWeather objectForKey:@"time"] isKindOfClass:[NSNumber class]]) {
            forecastData.time = [NSDate dateWithTimeIntervalSince1970: [(NSNumber*)[currentWeather objectForKey:@"time"] doubleValue]];
        }
        
        if ([[currentWeather objectForKey:@"icon"] isKindOfClass:[NSString class]]) {
            forecastData.iconName = [currentWeather objectForKey:@"icon"];
        }
    }
    
    return forecastData;
}


@end
