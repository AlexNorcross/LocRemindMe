//
//  InterfaceController.m
//  LocRemindMe WatchKit Extension
//
//  Created by Alexandra Norcross on 2/5/15.
//  Copyright (c) 2015 Alexandra Norcross. All rights reserved.
//

#import "InterfaceController.h"
#import <CoreLocation/CoreLocation.h>
#import "RegionReminderRowController.h"
#import "ReminderInterfaceController.h"

@interface InterfaceController()
@property (weak, nonatomic) IBOutlet WKInterfaceTable *tableRegionReminders;
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) NSArray * regionReminders;
@end


@implementation InterfaceController

//Setup
- (void)awakeWithContext:(id)context {
  [super awakeWithContext:context];

  _locationManager = [[CLLocationManager alloc] init];
  _regionReminders = _locationManager.monitoredRegions.allObjects;
  [_tableRegionReminders setNumberOfRows:_regionReminders.count withRowType:@"ROW_REGION_REMINDER"];
  NSInteger index = 0;
  for (CLCircularRegion *regionReminder in _regionReminders) {
    RegionReminderRowController *rowController = [_tableRegionReminders rowControllerAtIndex:index];
    [rowController.labelRegionReminder setText:regionReminder.identifier];
    index++;
  } //end for
} //end func

//Table row selected
- (void)table:(WKInterfaceTable *)table didSelectRowAtIndex:(NSInteger)rowIndex {
  [self pushControllerWithName:@"IC_REMINDER" context:_regionReminders[rowIndex]];
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



