//
//  TabViewController.m
//  WatsonQuery
//
//  Created by Greg Azevedo on 10/20/14.
//  Copyright (c) 2014 EECS 481. All rights reserved.
//

#import "TabViewController.h"
#import "SPSWatsonViewController.h"
#import "GraphViewController.h"
#import "SPSNotificationViewController.h"
#import "SPSTrendViewController.h"

@interface TabViewController ()

@property (nonatomic) SPSWatsonViewController *mainVC;
@property (nonatomic) SPSNotificationViewController *notifVC;
@property (nonatomic) SPSTrendViewController *trendVC;

@end


@implementation TabViewController

- (void)loadView {
    [super loadView];
    
    self.notifVC = [SPSNotificationViewController new];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:self.notifVC];
    self.mainVC = [SPSWatsonViewController new];
    self.trendVC = [SPSTrendViewController new];
    [self setViewControllers:@[self.mainVC, self.trendVC, nav]];
   
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
}

@end
