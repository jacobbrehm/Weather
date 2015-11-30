//
//  WeatherViewController.m
//  Weather
//
//  Created by Jacob Brehm on 23.11.15.
//  Copyright © 2015 Jacob Brehm. All rights reserved.
//

#import "WeatherViewController.h"
#import <MapKit/MapKit.h>

#import "WeatherAnnotation.h"
#import "WeatherAnnotationView.h"


@interface WeatherViewController ()
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *mapTypeSegmentedControl;
@property (nonatomic) CLLocationDegrees zoomLevel;
@property (strong, nonatomic) NSMutableArray* forecastDataArray;

@end

// mapView region location values
static const double kCenterLocationLatitude = 41.2074;
static const double kCenterLocationLongitude = 23.2117;


@implementation WeatherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // center map on this location
    CLLocation *location = [[CLLocation alloc] initWithLatitude:kCenterLocationLatitude longitude:kCenterLocationLongitude];
    [self centerMapOnLocation:location];
    
    // create the forecast importer
    ForecastImporter* forecastImporter = [[ForecastImporter alloc] initWithWeatherLocations:[self makeWeatherLocationArray]];
    forecastImporter.delegate = self;
    [forecastImporter startForecastImport];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void) centerMapOnLocation: (CLLocation *) location {
    CLLocationDistance regionDistance = 100000; // distance value is used for the zoomlevel on startup
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(location.coordinate, regionDistance * 15.0, regionDistance * 11.0);
    [self.mapView setRegion:region animated:YES];
}

- (NSArray*) makeWeatherLocationArray {
    
    // important balkan locations - hand-picked
    CLLocation *sofia = [[CLLocation alloc] initWithLatitude:42.693328  longitude:23.290978];
    CLLocation *burgas = [[CLLocation alloc] initWithLatitude:42.485434 longitude:27.451956];
    CLLocation *thessaloniki = [[CLLocation alloc] initWithLatitude:40.685616 longitude:22.983310];
    CLLocation *corfu = [[CLLocation alloc] initWithLatitude:39.602850 longitude:19.875884];
    CLLocation *tripoli = [[CLLocation alloc] initWithLatitude:37.496378 longitude:22.322016];
    CLLocation *bucarest = [[CLLocation alloc] initWithLatitude:44.446564 longitude:26.106303];
    CLLocation *plowdiw = [[CLLocation alloc] initWithLatitude:42.147920 longitude:24.755950];
    CLLocation *prishtine = [[CLLocation alloc] initWithLatitude:42.682551 longitude:21.167547];
    CLLocation *dubrovnik = [[CLLocation alloc] initWithLatitude:42.649711 longitude:18.109342];
    
    NSMutableArray *locations = [NSMutableArray arrayWithObjects:sofia, burgas, thessaloniki, corfu, tripoli, bucarest, plowdiw, prishtine, dubrovnik, nil];
    
    return locations;
}

- (void) showWeatherIconForForecastData: (ForecastData*) forecastData {
    
    // add weather icon (annotations) to the map
    WeatherAnnotation *annotation = [[WeatherAnnotation alloc] init];
    annotation.coordinate = CLLocationCoordinate2DMake([forecastData.latitude doubleValue], [forecastData.longitude doubleValue]);
    annotation.temperature = [forecastData.temperature stringValue];
    annotation.weatherType = [WeatherAnnotation weatherAnnotationTypeForIconName:forecastData.iconName];
    annotation.pressure = [forecastData.pressure stringValue];
    
    [self.mapView addAnnotation:annotation];
}

- (void) updateWeatherIcons {
    for (ForecastData* forecastData in self.forecastDataArray) {
        [self showWeatherIconForForecastData:forecastData];
    }
}

#pragma mark - MapView Delegates

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    WeatherAnnotationView *annotationView = [[WeatherAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:nil];
    annotationView.canShowCallout = YES;
    return annotationView;
}

#pragma mark - ForecastImporterDelegate

- (void)didFinishForecastImportWithForecastData:(ForecastData *) forecastData {
    
    NSLog(@"[WeatherViewController] INFO - Weather: %@", forecastData.iconName);
    
    [self.forecastDataArray addObject:forecastData];
    [self showWeatherIconForForecastData:forecastData];
    
}

#pragma mark - Segmented Control
- (IBAction)mapTypeSegementSwitched:(id)sender {
    
    UISegmentedControl *segmentedControl = (UISegmentedControl *) sender;
    NSInteger selectedSegment = segmentedControl.selectedSegmentIndex;
    
    switch (selectedSegment) {
        case 0:
            [self.mapView setMapType:MKMapTypeStandard];
            break;
        case 1:
            [self.mapView setMapType:MKMapTypeHybrid];
            break;
        case 2:
            [self.mapView setMapType:MKMapTypeSatellite];
            break;
        default:
            [self.mapView setMapType:MKMapTypeStandard];
            break;
    }
    
}

@end
