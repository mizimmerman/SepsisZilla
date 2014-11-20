//
//  SPSNotification+Helpers.m
//  WatsonQuery
//
//  Created by Greg Azevedo on 11/19/14.
//  Copyright (c) 2014 EECS 481. All rights reserved.
//

#import "SPSNotification+Helpers.h"
#import "SPSCoreDataHelper.h"

@implementation SPSNotification (Helpers)

+(void)insertMockNotificationWithText:(NSString *)text
{
    SPSNotification *noty = [NSEntityDescription insertNewObjectForEntityForName:@"SPSNotification" inManagedObjectContext:[SPSCoreDataHelper data].context];
    noty.text = text;
    [[SPSCoreDataHelper data] saveContext];
}


@end
