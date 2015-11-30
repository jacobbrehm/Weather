//
//  ForecastImporter.h
//  Weather
//
//  Created by Jacob Brehm on 25.11.15.
//  Copyright © 2015 Jacob Brehm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ForecastData.h"

@protocol ForecastImporterDelegate <NSObject>

- (void) didFinishForecastImportWithForecastData: (ForecastData*) forecastData;

@end

@interface ForecastImporter : NSObject

@property (nonatomic, weak) id<ForecastImporterDelegate> delegate;
@property (nonatomic, strong) NSArray *weatherLocations;

- (id) init;
- (id) initWithWeatherLocations: (NSArray*) weatherLocations;
- (void) startForecastImport;

@end
