//
//  ReminderInterfaceController.m
//  LocRemindMe
//
//  Created by Alexandra Norcross on 2/5/15.
//  Copyright (c) 2015 Alexandra Norcross. All rights reserved.
//

#import "ReminderInterfaceController.h"
#import <MapKit/MapKit.h>


@interface ReminderInterfaceController()
@property (weak, nonatomic) IBOutlet WKInterfaceMap *mapView;

@end


@implementation ReminderInterfaceController

//Setup
- (void)awakeWithContext:(id)context {
  [super awakeWithContext:context];
  
  CLCircularRegion *region = context;
  CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(region.center.latitude, region.center.longitude);
  MKCoordinateRegion mkRegion = MKCoordinateRegionMake(coordinate, MKCoordinateSpanMake(1, 1));
  [_mapView setRegion:mkRegion];
  
  MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
  annotation.coordinate = region.center;
  [_mapView addAnnotation:coordinate withPinColor:WKInterfaceMapPinColorRed];
} //end func

- (void)willActivate {
  // This method is called when watch view controller is about to be visible to user
  [super willActivate];
}

- (void)didDeactivate {
  // This method is called when watch view controller is no longer visible
  [super didDeactivate];
}

@end