//
//  TabViewController.m
//  WatsonQuery
//
//  Created by Greg Azevedo on 10/20/14.
//  Copyright (c) 2014 EECS 481. All rights reserved.
//

#import "TabViewController.h"
#import "ViewController.h"
#import "GraphViewController.h"

@interface TabViewController ()

@property (nonatomic) ViewController *mainVC;
@property (nonatomic) GraphViewController *graphVC;

@end

@implementation TabViewController

- (void)loadView {
    [super loadView];
    self.mainVC = [ViewController new];
    self.graphVC = [GraphViewController new];
    [self setViewControllers:@[self.mainVC, self.graphVC]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

@end
