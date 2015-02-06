//
//  AddReminderViewController.h
//  LocReminders
//
//  Created by Alexandra Norcross on 2/3/15.
//  Copyright (c) 2015 Alexandra Norcross. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface AddReminderViewController : UIViewController
@property (strong, nonatomic) MKPointAnnotation *selectedLocation;
@property (strong, nonatomic) CLLocationManager *locationManager;
@end
