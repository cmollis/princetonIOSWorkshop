//
//  MapViewController.m
//  testcoredata
//
//  Created by Eric Mansfield on 1/31/12.
//  Copyright (c) 2012 AppsOnTheSide, LLC. All rights reserved.
//

#import "MapViewController.h"

@implementation MapViewController
@synthesize mapView = _mapView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.mapView setUserTrackingMode:MKUserTrackingModeFollow animated:YES];

    NSString *path = [[NSBundle mainBundle] pathForResource:@"StoreLocations" ofType:@"plist"];
    NSArray *stores = [[NSDictionary dictionaryWithContentsOfFile:path] valueForKey:@"Array"];
    NSLog(@"%i", [stores count]);
    
    NSMutableArray *annotations = [NSMutableArray array];
    
    for (NSDictionary *store in stores) {
        NSLog(@"%@, %@", [store valueForKey:@"latitude"], [store objectForKey:@"longitude"]);
        // get the coodiantes
        MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
        annotation.title = @"Store";

        CLLocationCoordinate2D coord;
        coord.latitude = [[store valueForKey:@"latitude"] doubleValue];
        coord.longitude = [[store valueForKey:@"longitude"] doubleValue];
        
        annotation.coordinate = coord;
        
        NSLog(@".adding to array ...");
        [annotations addObject:annotation];
    }
    
    if ([annotations count] > 0) {
        NSLog(@"Adding annotations....");
        [self.mapView addAnnotations:annotations];
    }
    
    
    //Set Zoom level using Span
    MKCoordinateRegion theRegion = self.mapView.region;
    
    // Zoom out
    theRegion.span.longitudeDelta *= 1.05;
    theRegion.span.latitudeDelta *= 1.05;
    [self.mapView setRegion:theRegion animated:YES];
}

- (void)viewDidUnload
{
    [self setMapView:nil];
    [self setMapView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}



#pragma mark - MKMapViewDelegate
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    if ([annotation isKindOfClass:[MKUserLocation class]]) {
        // use the default user annotation view (blue dot)
        return nil;
    }
    
    static NSString *viewId = @"annotationView";
    
    // use a purple pin to denote the Store location on the mapView
    MKPinAnnotationView *view = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:viewId];
    if (view == nil) {
        view = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:viewId];
    }
    view.pinColor = MKPinAnnotationColorPurple;    
    view.animatesDrop = YES;
    view.canShowCallout = YES;
    return view;
}

- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view {
    if ([view isKindOfClass:[MKPinAnnotationView class]]) {
        // user tapped annotation, use a geocoder to find the address
        MKPointAnnotation *point = (MKPointAnnotation *)view.annotation;
        
        CLGeocoder *geocoder = [[CLGeocoder alloc] init];
        CLLocation *location = [[CLLocation alloc] initWithLatitude:point.coordinate.latitude longitude:point.coordinate.longitude];
        
        // ask the geoder for the address
        [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
            
            // completion handler
            if (error == nil) {
                CLPlacemark *placemark = [placemarks objectAtIndex:0];
                
                // set the annotation's subtitle to the address
                point.subtitle = [placemark name];
            }
            else {
                NSLog(@"ERROR occurred ... %@", [error localizedDescription]);
            }
        }];
    }
}

@end
