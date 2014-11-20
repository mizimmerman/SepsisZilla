//
//  SPSNotificationViewController.m
//  WatsonQuery
//
//  Created by gazevedo on 11/10/14.
//  Copyright (c) 2014 EECS 481. All rights reserved.
//

#import "SPSNotificationViewController.h"
#import "SPSNotificationTableViewCell.h"
#import "SPSNotificationManager.h"
#import "SPSNotification.h"

@interface SPSNotificationViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic) UITableView *notificationsFeed;

@end

@implementation SPSNotificationViewController

- (id)init
{
    self = [super init];
    if (self) {
        [self setTitle:@"Notifications"];
    }
    return self;
}

-(void)loadView
{
    [super loadView];
    self.notificationsFeed = [UITableView new];
    [self.notificationsFeed setFrame:self.view.bounds];
    [self.notificationsFeed setDelegate:self];
    [self.notificationsFeed setDataSource:self];
    [self.notificationsFeed registerClass:[SPSNotificationTableViewCell class] forCellReuseIdentifier:@"Cell"];
    [self.view addSubview:self.notificationsFeed];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Schedule the notification
    UILocalNotification* localNotification = [[UILocalNotification alloc] init];
  
    NSDate *today = [NSDate date];
    localNotification.fireDate = today;
    
    
    localNotification.alertBody = @"Show me the Noty";
    localNotification.alertAction = @"Show me the Noty";
    localNotification.timeZone = [NSTimeZone defaultTimeZone];
    localNotification.applicationIconBadgeNumber = [[UIApplication sharedApplication] applicationIconBadgeNumber] + 1;
    
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
    
    // Request to reload table view data
    [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadData" object:self];
    
    // Dismiss the view controller
    [self dismissViewControllerAnimated:YES completion:nil];
    
    
   
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SPSNotificationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    [cell setBackgroundColor:[UIColor whiteColor]];
    SPSNotification *noty = [[SPSNotificationManager data].fetchedResultsController objectAtIndexPath:indexPath];
    cell.textLabel.text = noty.text;
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [SPSNotificationManager data].fetchedResultsController.fetchedObjects.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

@end
