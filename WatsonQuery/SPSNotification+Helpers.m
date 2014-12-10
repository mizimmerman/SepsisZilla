//
//  SPSNotification+Helpers.m
//  WatsonQuery
//
//  Created by Greg Azevedo on 11/19/14.
//  Copyright (c) 2014 EECS 481. All rights reserved.
//

#import "SPSNotification+Helpers.h"
#import "SPSCoreDataHelper.h"
#import "SPSNotificationViewController.h"

@implementation SPSNotification (Helpers)

+(void)insertMockNotificationWithText:(NSString *)text
{
    SPSNotification *noty = [NSEntityDescription insertNewObjectForEntityForName:@"SPSNotification" inManagedObjectContext:[SPSCoreDataHelper data].context];
    
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM/dd"];
    noty.dateText = [formatter stringFromDate:[NSDate date]];
    noty.text = text;
    [[SPSCoreDataHelper data] saveContext];
    // Schedule the notification
    
    UILocalNotification* localNotification = [[UILocalNotification alloc] init];
    
    NSDate *today = [NSDate date];
    localNotification.fireDate = today;
    
    localNotification.alertBody = text;
    localNotification.alertAction = text;
    localNotification.timeZone = [NSTimeZone defaultTimeZone];
    localNotification.applicationIconBadgeNumber = [[UIApplication sharedApplication] applicationIconBadgeNumber] + 1;
    
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
    
    // Request to reload table view data
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadData" object:self];
    
    // Dismiss the view controller
}


@end
