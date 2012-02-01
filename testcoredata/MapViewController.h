//
//  MapViewController.h
//  testcoredata
//
//  Created by Eric Mansfield on 1/31/12.
//  Copyright (c) 2012 AppsOnTheSide, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface MapViewController : UIViewController<MKMapViewDelegate>

@property (strong, nonatomic) IBOutlet MKMapView *mapView;

@end
