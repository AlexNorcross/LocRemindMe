//
//  Node.m
//  LocRemindMe
//
//  Created by Alexandra Norcross on 2/6/15.
//  Copyright (c) 2015 Alexandra Norcross. All rights reserved.
//

#import "Node.h"

@implementation Node
- (void) addNode:(Node *)newNode {
  if (_next == nil) {
    _next = newNode;
  } else {
    [_next addNode:newNode];
  } //end else
} //end func
@end

