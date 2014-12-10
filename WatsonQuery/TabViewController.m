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
//@property (nonatomic) GraphViewController *graphVC;
@property (nonatomic) SPSNotificationViewController *notifVC;
@property (nonatomic) SPSTrendViewController *trendVC;

@end

@implementation TabViewController

- (void)loadView {
    [super loadView];
    self.mainVC = [SPSWatsonViewController new];
    CGSize size = CGSizeMake(30, 30);
    UIImage *watsonsel = [self imageWithImage:[UIImage imageNamed:@"watson"] scaledToSize:size];
    UIImage *watson = [self imageWithImage:[UIImage imageNamed:@"watsonlight"] scaledToSize:size];
    UIImage *notif = [self imageWithImage:[UIImage imageNamed:@"notiflight"] scaledToSize:size];
    UIImage *notifsel = [self imageWithImage:[UIImage imageNamed:@"notif"] scaledToSize:size];
    UIImage *trend = [self imageWithImage:[UIImage imageNamed:@"trends"] scaledToSize:size];
    UIImage *trendsel = [self imageWithImage:[UIImage imageNamed:@"trendlight"] scaledToSize:size];

    [self.mainVC setTabBarItem:[[UITabBarItem alloc] initWithTitle:@"Watson" image:watson selectedImage:watsonsel]];
//    self.graphVC = [GraphViewController new];
    self.notifVC = [SPSNotificationViewController new];
    [self.notifVC setTabBarItem:[[UITabBarItem alloc] initWithTitle:@"Notifications" image:notif selectedImage:notifsel]];
    self.trendVC = [SPSTrendViewController new];
    [self.trendVC setTabBarItem:[[UITabBarItem alloc] initWithTitle:@"Trends" image:trend selectedImage:trendsel]];
    UINavigationController *notyNav = [[UINavigationController alloc] initWithRootViewController:self.notifVC];
    [self setViewControllers:@[self.mainVC, self.trendVC, notyNav]];
   
    
}

- (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize {
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
}

@end
