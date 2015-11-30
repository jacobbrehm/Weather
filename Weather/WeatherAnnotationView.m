//
//  WeatherAnnotationView.m
//  Weather
//
//  Created by Jacob Brehm on 29.11.15.
//  Copyright © 2015 Jacob Brehm. All rights reserved.
//

#import "WeatherAnnotationView.h"
#import "WeatherAnnotation.h"

@implementation WeatherAnnotationView

- (id)initWithAnnotation:(id<MKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        // resize imageview
        CGRect imageViewFrame = CGRectMake(-25, -25, 50, 50);
        UIImageView* imageView = [[UIImageView alloc] initWithFrame:imageViewFrame];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        self.imageView = imageView;
        [self addSubview:self.imageView];
        
        // set image according to weatherAnnotationType
        [self setImageWithWeatherAnnotation:self.annotation];
    }
    
    return self;
}

- (void) setImageWithWeatherAnnotation: (WeatherAnnotation*) weatherAnnotation {
    WeatherAnnotation* annotation = self.annotation;
    
    switch (annotation.weatherType) {
        case WeatherAnnotationClearDay:
            self.image = [UIImage imageNamed:@"sunny"];
            break;
        case WeatherAnnotationCloudy:
            self.image = [UIImage imageNamed:@"cloudy"];
            break;
        case WeatherAnnotationPartlyCloudyDay:
            self.image = [UIImage imageNamed:@"partlycloudy"];
            break;
        case WeatherAnnotationPartlyCloudyNight:
            self.image = [UIImage imageNamed:@"partlycloudynight"];
            break;
        case WeatherAnnotationFog:
            self.image = nil;
            break;
        case WeatherAnnotationClearNight:
            self.image = [UIImage imageNamed:@"clearnight"];
            break;
        case WeatherAnnotationRain:
            self.image = [UIImage imageNamed:@"rain"];
            break;
        case WeatherAnnotationSleet:
            self.image = nil;
            break;
        case WeatherAnnotationSnow:
            self.image = [UIImage imageNamed:@"snow"];
            break;
        case WeatherAnnotationWind:
            self.image = nil;
            break;
        case WeatherAnnotationDefault:
            self.image = nil;
            break;
        default:
            self.image = nil;
            break;
    }
}

- (void) setImage:(UIImage *)image {
    _imageView.image = image;
}

@end
