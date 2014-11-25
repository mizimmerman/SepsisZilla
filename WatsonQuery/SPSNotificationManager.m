//
//  SPSNotificationManager.m
//  WatsonQuery
//
//  Created by Greg Azevedo on 11/19/14.
//  Copyright (c) 2014 EECS 481. All rights reserved.
//

#import "SPSNotificationManager.h"
#import "SPSCoreDataHelper.h"
#import "SPSNotification+Helpers.h"

@interface SPSNotificationManager () <NSFetchedResultsControllerDelegate>

@end


@implementation SPSNotificationManager

+(SPSNotificationManager *)data
{
    static SPSNotificationManager *singleton = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        singleton = [SPSNotificationManager new];
    });
    return singleton;
}

- (NSFetchedResultsController *)fetchedResultsController {
    
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }

    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"SPSNotification" inManagedObjectContext:[SPSCoreDataHelper data].context];
    [fetchRequest setEntity:entity];
    
    NSSortDescriptor *sort = [[NSSortDescriptor alloc] initWithKey:@"text" ascending:NO];
    [fetchRequest setSortDescriptors:[NSArray arrayWithObject:sort]];
    [fetchRequest setFetchBatchSize:20];
    
    NSFetchedResultsController *theFetchedResultsController = [[NSFetchedResultsController alloc]
                                                               initWithFetchRequest:fetchRequest
                                                               managedObjectContext:[SPSCoreDataHelper data].context
                                                               sectionNameKeyPath:nil cacheName:@"Root"];
    self.fetchedResultsController = theFetchedResultsController;
    _fetchedResultsController.delegate = self;
    return _fetchedResultsController;
}

@end
