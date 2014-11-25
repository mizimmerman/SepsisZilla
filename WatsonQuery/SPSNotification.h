//
//  SPSNotification.h
//  WatsonQuery
//
//  Created by Greg Azevedo on 11/19/14.
//  Copyright (c) 2014 EECS 481. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface SPSNotification : NSManagedObject

@property (nonatomic, retain) NSString * text;
@property (nonatomic, retain) NSString * dateText;

@end
