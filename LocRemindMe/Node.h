//
//  Node.h
//  LocRemindMe
//
//  Created by Alexandra Norcross on 2/6/15.
//  Copyright (c) 2015 Alexandra Norcross. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Node : NSObject
@property (strong, nonatomic) NSString *myString;
@property (strong, nonatomic) Node *next;
- (void) addNode:(Node *)newNode;
@end
