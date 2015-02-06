//
//  Queue.m
//  LocReminders
//
//  Created by Alexandra Norcross on 2/2/15.
//  Copyright (c) 2015 Alexandra Norcross. All rights reserved.
//

#import "Queue.h"

@interface Queue()
@property (strong, nonatomic) NSMutableArray *myItems;
@end

@implementation Queue

//Init
-(instancetype) init {
  if (self = [super init]) {
    _myItems = [[NSMutableArray alloc] init];
  } //end if
  return self;
} //end init

//Enqueue
-(NSNumber*) enqueue:(NSNumber*)newVal {
  [_myItems addObject:newVal];
  return newVal;
} //end func

//Dequeue
-(NSNumber*) dequeue {
  if (sizeof(_myItems) > 0) {
    NSNumber *oldVal = _myItems[0];
    [_myItems removeObjectAtIndex:0];
    return oldVal;
  } else {
    return nil;
  } //end if
} //end func

//Peek
-(NSNumber*) peek {
  if (sizeof(_myItems) > 0) {
    return _myItems.firstObject;
  } else {
    return nil;
  } //end if
} //end func

//Count
-(int) count {
  return sizeof(_myItems);
} //end func
@end
