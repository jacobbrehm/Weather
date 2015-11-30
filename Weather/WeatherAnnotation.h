//
//  WeatherAnnotation.h
//  Weather
//
//  Created by Jacob Brehm on 29.11.15.
//  Copyright © 2015 Jacob Brehm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>


// WeatherAnnotationType Enum - for forecast.io API
typedef NS_ENUM(NSInteger, WeatherAnnotationType) {
    WeatherAnnotationDefault = 0,
    WeatherAnnotationClearDay,
    WeatherAnnotationClearNight,
    WeatherAnnotationRain,
    WeatherAnnotationSnow,
    WeatherAnnotationSleet,
    WeatherAnnotationWind,
    WeatherAnnotationFog,
    WeatherAnnotationCloudy,
    WeatherAnnotationPartlyCloudyDay,
    WeatherAnnotationPartlyCloudyNight
};


@interface WeatherAnnotation : NSObject <MKAnnotation>

@property (nonatomic) CLLocationCoordinate2D coordinate;
@property (nonatomic) WeatherAnnotationType weatherType;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;

@property (nonatomic, copy) NSString *temperature;
@property (nonatomic, copy) NSString *pressure;

+ (WeatherAnnotationType) weatherAnnotationTypeForIconName: (NSString*) iconName;

@end
