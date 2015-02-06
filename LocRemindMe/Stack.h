//
//  Stack.h
//  LocReminders
//
//  Created by Alexandra Norcross on 2/2/15.
//  Copyright (c) 2015 Alexandra Norcross. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Stack : NSObject
-(NSNumber*) pushItem:(NSNumber*)newVal;
-(NSNumber*) popItem;
-(NSNumber*) peek;
-(int) count;
@end
