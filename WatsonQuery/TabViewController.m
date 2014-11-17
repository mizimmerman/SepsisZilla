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

@property (nonatomic) ViewController *mainVC;
//@property (nonatomic) GraphViewController *graphVC;
@property (nonatomic) SPSNotificationViewController *notifVC;
@property (nonatomic) SPSTrendViewController *trendVC;

@end

@implementation TabViewController

- (void)loadView {
    [super loadView];
    self.mainVC = [ViewController new];
//    self.graphVC = [GraphViewController new];
    self.notifVC = [SPSNotificationViewController new];
    self.trendVC = [SPSTrendViewController new];
    [self setViewControllers:@[self.mainVC, self.trendVC, self.notifVC]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

@end
