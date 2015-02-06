//
//  LinkedList.m
//  LocRemindMe
//
//  Created by Alexandra Norcross on 2/6/15.
//  Copyright (c) 2015 Alexandra Norcross. All rights reserved.
//

#import "LinkedList.h"

@implementation LinkedList

//Add node to head
- (Node*) addToHead:(NSString *)newString {
  //new node
  Node *newNode = [[Node alloc] init];
  newNode.myString = newString;
  newNode.next = _head;

  //set new head to new node
  _head = newNode;
  
  //return value
  return newNode;
} //end func

//Add node to end
- (Node*) addToEnd:(NSString *)newString {
  //new node
  Node *newNode = [[Node alloc] init];
  newNode.myString = newString;
  
  //find last node => before nil
  Node *nextNode = _head;
  while (nextNode.next != nil) {
    nextNode = nextNode.next;
  } //end while
  nextNode.next = newNode;
  
  //return value
  return newNode;
} //end func

//Add node to end recursively
- (Node*) addToEndRecursively:(NSString *)newString {
  //new node
  Node *newNode = [[Node alloc] init];
  newNode.myString = newString;
  [_head addNode:newNode];
  
  //return value
  return newNode;
} //end func

//Obtain node at index
- (Node*) atIndex:(NSInteger)index; {
  if (index >=0) {
    NSInteger i = 0;
    Node *currentNode = _head;
    while (i <= index) {
      if (i == index) {
        return currentNode;
      } else {
        currentNode = currentNode.next;
        i++;
      } //end if
    } //end while
    return nil;
  } else {
    return nil;
  } //end if
} //end func
@end
