//
//  Queue.h
//  LocReminders
//
//  Created by Alexandra Norcross on 2/2/15.
//  Copyright (c) 2015 Alexandra Norcross. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Queue : NSObject
-(NSNumber*) enqueue:(NSNumber*)newVal;
-(NSNumber*) dequeue;
-(NSNumber*) peek;
-(int) count;
@end
