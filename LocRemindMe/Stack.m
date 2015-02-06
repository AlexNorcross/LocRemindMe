//
//  Stack.m
//  LocReminders
//
//  Created by Alexandra Norcross on 2/2/15.
//  Copyright (c) 2015 Alexandra Norcross. All rights reserved.
//

#import "Stack.h"

@interface Stack()
@property (strong, nonatomic) NSMutableArray *myItems;
@end

@implementation Stack

//Init
-(instancetype) init {
  if (self = [super init]) {
    _myItems = [[NSMutableArray alloc] init];
  } //end if
  return self;
} //end init

//Push
-(NSNumber*) pushItem:(NSNumber*)newVal {
  [_myItems addObject:newVal];
  return newVal;
} //end func

//Pop
-(NSNumber*) popItem {
  if (sizeof(_myItems) > 0) {
    NSNumber* oldVal = _myItems.lastObject;
    [_myItems removeLastObject];
    return oldVal;
  } else {
    return nil;
  } //end if
} //end func

//Peek
-(NSNumber*) peek {
  if (sizeof(_myItems) > 0) {
    return _myItems.lastObject;
  } else {
    return nil;
  } //end if
} //end func

//Count:
-(int) count {
  return sizeof(_myItems);
} //end func
@end
