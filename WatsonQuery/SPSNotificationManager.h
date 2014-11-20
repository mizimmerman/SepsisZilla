//
//  SPSNotificationManager.h
//  WatsonQuery
//
//  Created by Greg Azevedo on 11/19/14.
//  Copyright (c) 2014 EECS 481. All rights reserved.
//

#import "SPSTrendDataManager.h"
#import <CoreData/CoreData.h>

@interface SPSNotificationManager : SPSTrendDataManager

+(SPSNotificationManager *)data;

@property (nonatomic) NSFetchedResultsController *fetchedResultsController;

@end
