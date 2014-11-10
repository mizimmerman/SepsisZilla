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

@interface TabViewController ()

@property (nonatomic) SPSWatsonViewController *mainVC;
@property (nonatomic) GraphViewController *graphVC;

@end

@implementation TabViewController

- (void)loadView {
    [super loadView];
    self.mainVC = [SPSWatsonViewController new];
    self.graphVC = [GraphViewController new];
    [self setViewControllers:@[self.mainVC, self.graphVC]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

@end
