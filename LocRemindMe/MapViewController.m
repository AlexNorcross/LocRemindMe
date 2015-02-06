//
//  MapViewController.m
//  LocReminders
//
//  Created by Alexandra Norcross on 2/2/15.
//  Copyright (c) 2015 Alexandra Norcross. All rights reserved.
//

#import "MapViewController.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "Stack.h"
#import "Queue.h"
#import "AddReminderViewController.h"

@interface MapViewController () <CLLocationManagerDelegate, MKMapViewDelegate>
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) MKPointAnnotation *selectedLocation;
@end

@implementation MapViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  //Setup.
  _locationManager = [[CLLocationManager alloc] init];
  _locationManager.delegate = self;
  _mapView.delegate = self;
  
  //Gesture:
  UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressedMapView:)];
  [_mapView addGestureRecognizer:longPress];
  
  //Notifications:
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reminderAdded:) name:@"AddReminder" object:nil];
  
  //Location manager:
  if ([CLLocationManager locationServicesEnabled]) { //enabled
    //Request authorization.
    if ([CLLocationManager authorizationStatus] == 0) { //not authorized
      [_locationManager requestAlwaysAuthorization]; //request authorization
    } else { //place user
      _mapView.showsUserLocation = true;
      [self.locationManager startMonitoringSignificantLocationChanges];
    } //end if
  } else { //disabled - alert
  } //end if
  
  //Stack:
  Stack *myStack = [[Stack alloc] init];
  [myStack pushItem:@1];
  [myStack pushItem:@2];
  [myStack pushItem:@3];
  [myStack popItem];
  NSNumber *peekAtStack = [myStack peek];
  NSLog(@"%@",peekAtStack);
  
  //Queue:
  Queue *myQueue = [[Queue alloc] init];
  [myQueue enqueue:@1];
  [myQueue enqueue:@2];
  [myQueue enqueue:@3];
  [myQueue dequeue];
  NSNumber *peekAtQueue = [myQueue peek];
  NSLog(@"%@",peekAtQueue);
} //end func

#pragma mark - IBActions

//Cuisiat, France
- (IBAction)pressedButtonLoc1:(id)sender {
  MKCoordinateRegion loc = MKCoordinateRegionMake(CLLocationCoordinate2DMake(46.2722, 5.3692), MKCoordinateSpanMake(3, 3));
  [_mapView setRegion:loc animated:true];
} //end ibaction

//Roccalumera, Sicily
- (IBAction)pressedButtonLoc2:(id)sender {
  MKCoordinateRegion loc = MKCoordinateRegionMake(CLLocationCoordinate2DMake(37.9833, 15.4), MKCoordinateSpanMake(3, 3));
  [_mapView setRegion:loc animated:true];
} //end ibaction

//Sanok, Poland
- (IBAction)pressedButtonLoc3:(id)sender {
  MKCoordinateRegion loc = MKCoordinateRegionMake(CLLocationCoordinate2DMake(49.5667, 22.2), MKCoordinateSpanMake(3, 3));
  [_mapView setRegion:loc animated:true];
} //end ibaction

#pragma mark - LocationManager Delegate

//Entered region - local notification
-(void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region {
  UILocalNotification *notifyRegionEntered = [[UILocalNotification alloc] init];
  notifyRegionEntered.alertBody = @"you are close";
  notifyRegionEntered.alertAction = @"ok";
  [[UIApplication sharedApplication] presentLocalNotificationNow:notifyRegionEntered];
} //end func

#pragma mark - MapView Delegate

//Add annotation
-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
  MKPinAnnotationView *newAnnotation = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"ANNOTATION_NEW"];
  newAnnotation.animatesDrop = true;
  newAnnotation.canShowCallout = true;
  newAnnotation.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeContactAdd];
  return newAnnotation;
} //end func

//Handle callout
-(void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control {
  _selectedLocation = view.annotation;
  [self performSegueWithIdentifier:@"SEGUE_ANNOTATION" sender:self];
} //end func

//Edit/Render overlay
-(MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay {
  MKCircleRenderer *circleRender = [[MKCircleRenderer alloc] initWithOverlay:overlay];
  circleRender.fillColor = [UIColor redColor];
  circleRender.alpha = 0.25;
  circleRender.strokeColor = [UIColor redColor];
  return circleRender;
} //end func

#pragma mark - Selectors

//Map long press
-(void)longPressedMapView:(id)sender {
  
  UILongPressGestureRecognizer *longPress = (UILongPressGestureRecognizer *)sender; //cast
  if (longPress.state == 3) {
    CGPoint locInView = [longPress locationInView:_mapView];
    CLLocationCoordinate2D coordinateOnMap = [_mapView convertPoint:locInView toCoordinateFromView:_mapView]; //view to map coordinate
    MKPointAnnotation *newAnnotation = [[MKPointAnnotation alloc] init];
    newAnnotation.coordinate = coordinateOnMap;
    newAnnotation.title = @"my new place";
    [_mapView addAnnotation:newAnnotation]; //add annotation
  } //end if
} //end func

//Reminder added
-(void)reminderAdded:(NSNotification *)notification {
  if ([notification.name isEqual: @"AddReminder"]) {
    NSDictionary *userInfo = notification.userInfo;
    
    //Name
    NSString *regionReminderName = userInfo[@"regionReminderName"];
    _selectedLocation.title = regionReminderName;
    
    //Add overlay
    CLCircularRegion *region = userInfo[@"reminderRegion"];
    MKCircle *regionCircle = [MKCircle circleWithCenterCoordinate:region.center radius:region.radius];
    [_mapView addOverlay:regionCircle];
    
    //Zoom:
    MKCoordinateRegion loc = MKCoordinateRegionMake(_selectedLocation.coordinate, MKCoordinateSpanMake(1, 1));
    [_mapView setRegion:loc animated:true];
  } //end if
} //end func

#pragma mark - Navigation

//Setup before navigaton
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  if ([segue.identifier isEqual: @"SEGUE_ANNOTATION"]) {
    AddReminderViewController *vcAddReminder = (AddReminderViewController *) segue.destinationViewController;
    vcAddReminder.selectedLocation = _selectedLocation;
    vcAddReminder.locationManager = _locationManager;
  } //end if
}

#pragma mark - Clean up

//Clean up
-(void) dealloc {
  [[NSNotificationCenter defaultCenter] removeObserver:self];
} //end func

@end
