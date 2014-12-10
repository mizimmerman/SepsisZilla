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
#import "SPSTrendDataManager.h"
#import "SPSTrendDataManager+Algorithms.h"
#import "SPSGraphDataSource.h"
#import "SPSNotification+Helpers.h"

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
    [self.notificationsFeed setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.notificationsFeed setDelegate:self];
    [self.notificationsFeed setDataSource:self];
    [self.notificationsFeed registerClass:[SPSNotificationTableViewCell class] forCellReuseIdentifier:@"Cell"];
    [self.view addSubview:self.notificationsFeed];
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:(52/255.0) green:(152/255.0) blue:(219/255.0) alpha:1];
    
    
    /* If we need to add an info button, uncomment this */
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"Remind"
                                                                    style:UIBarButtonItemStylePlain
                                                                   target:self
                                                                   action:@selector(tappedInfo:)];
    [rightButton setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]} forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = rightButton;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSArray *notifications = [[SPSTrendDataManager data] shouldSendHealthNotifications];
    for (NSString* notification in notifications){
        [SPSNotification insertMockNotificationWithText:notification];
    }
    
    NSError *error;
    [[SPSNotificationManager data].fetchedResultsController performFetch:&error];
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SPSNotificationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    [cell setBackgroundColor:[UIColor whiteColor]];
    cell.layer.shadowColor = [[UIColor colorWithRed:(52/255.0) green:(152/255.0) blue:(219/255.0) alpha:1] CGColor];
    cell.layer.shadowOpacity = 1.0;
    cell.layer.shadowRadius = 2;
    cell.layer.shadowOffset = CGSizeMake(0.0, 1.0);
    
    SPSNotification *noty = [[SPSNotificationManager data].fetchedResultsController objectAtIndexPath:indexPath];
    cell.textLabel.text = noty.text;
    cell.textLabel.numberOfLines = 0;
    UILabel *dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 2, 35, 25)];
    dateLabel.text = noty.dateText;
    dateLabel.textColor = [UIColor darkGrayColor];
    dateLabel.adjustsFontSizeToFitWidth = YES;
    [cell addSubview:dateLabel];
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

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;
}

-(void)tappedInfo:(id)sender
{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Set your reminders!" message:@"Enter a time first for the reminder in format HH:MM followed by a reminder message" delegate:self cancelButtonTitle:@"Enter" otherButtonTitles:nil];
    alert.alertViewStyle = UIAlertViewStyleLoginAndPasswordInput;
    [alert textFieldAtIndex:1].secureTextEntry = NO; //Will disable secure text entry for second textfield.
    [alert textFieldAtIndex:0].placeholder = @"Time in HH:MM"; //Will replace "Username"
    [alert textFieldAtIndex:1].placeholder = @"Reminder message"; //Will replace "Password"
    [alert show];
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    UITextField *title1 = [alertView textFieldAtIndex:0];
    
    title1= [alertView textFieldAtIndex:0];
    NSString *title = title1.text;
    NSLog(@"The name is %@",title);
    NSLog(@"Using the Textfield: %@",[[alertView textFieldAtIndex:0] text]);
    NSString *message = [alertView textFieldAtIndex:1].text;
    NSString *time = [alertView textFieldAtIndex:0].text;
    if ([message  isEqual: @""] || [time  isEqual: @""]) {
        return;
    }
    NSString *notif = [NSString stringWithFormat:@"%@ at %@", message, time];
    [SPSNotification insertMockNotificationWithText:notif];
    NSError *error;
    [[SPSNotificationManager data].fetchedResultsController performFetch:&error ];

    [self.notificationsFeed reloadData];
//    [self.notificationsFeed beginUpdates];
//    [self.notificationsFeed endUpdates];
    
}
@end
