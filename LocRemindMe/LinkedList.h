//
//  LinkedList.h
//  LocRemindMe
//
//  Created by Alexandra Norcross on 2/6/15.
//  Copyright (c) 2015 Alexandra Norcross. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Node.h"

@interface LinkedList : NSObject
@property(strong, nonatomic) Node *head;

- (Node*) addToHead:(NSString *)newString;
- (Node*) addToEnd:(NSString *)newString;
- (Node*) addToEndRecursively:(NSString *)newString;
- (Node*) atIndex:(NSInteger)index;
@end
