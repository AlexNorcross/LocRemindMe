//
//  AddReminderViewController.m
//  LocReminders
//
//  Created by Alexandra Norcross on 2/3/15.
//  Copyright (c) 2015 Alexandra Norcross. All rights reserved.
//

#import "AddReminderViewController.h"

@interface AddReminderViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *textReminderName;
@property (weak, nonatomic) IBOutlet UILabel *labelLocLatitude;
@property (weak, nonatomic) IBOutlet UILabel *labelLocLongitude;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@end

@implementation AddReminderViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  //Setup.
  NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
  [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
  [formatter setMaximumFractionDigits:4];

  NSString *currentLatitude = [formatter stringFromNumber:[NSNumber numberWithFloat:_selectedLocation.coordinate.latitude]];
  _labelLocLatitude.text = currentLatitude;
  
  NSString *currentLongitude = [formatter stringFromNumber:[NSNumber numberWithFloat:_selectedLocation.coordinate.longitude]];
  _labelLocLongitude.text = currentLongitude;

  MKCoordinateRegion loc = MKCoordinateRegionMake(_selectedLocation.coordinate, MKCoordinateSpanMake(3, 3));
  [_mapView setRegion:loc animated:true];
  [_mapView addAnnotation:_selectedLocation];
} //end func

#pragma mark - TextField Delegate

//Dismiss keyboard
-(BOOL)textFieldShouldReturn:(UITextField *)textField {
  [textField resignFirstResponder];
  return true;
} //end func

#pragma mark - IBActions

//Add reminder
- (IBAction)pressedAddButton:(id)sender {
  if ([CLLocationManager isMonitoringAvailableForClass:[CLCircularRegion class]]) { //can monitor region
    //Reminder name:
    NSString *regionReminderName = _textReminderName.text;
    
    //Region:
    CLCircularRegion *regionSelected = [[CLCircularRegion alloc] initWithCenter:_selectedLocation.coordinate radius:5000 identifier:regionReminderName]; //region
    [_locationManager startMonitoringForRegion:regionSelected]; //start monitoring region
    
    //Notification:

    [[NSNotificationCenter defaultCenter] postNotificationName:@"AddReminder" object:self userInfo:@{@"regionReminderName" : regionReminderName, @"reminderRegion" : regionSelected}];
    
    //Dismiss view controller.
    [[self navigationController] popViewControllerAnimated:true];
  } //end if
} //end func
@end
