//
//  GraphViewController.m
//  WatsonQuery
//
//  Created by Greg Azevedo on 10/20/14.
//  Copyright (c) 2014 EECS 481. All rights reserved.
//

#import "GraphViewController.h"
#import <UPPlatform/UPPlatform.h>

@interface GraphViewController ()

@property (nonatomic) UIWebView *jawboneLoginView;
@property (nonatomic) UIButton *jawboneButton;

@end

@implementation GraphViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.title = @"Jawbone";
        
    }
    return self;
}

- (void)loadView {
    [super loadView];
    self.jawboneButton = [UIButton new];
    [self.jawboneButton setFrame:CGRectMake(10, 100, 100, 40)];
    [self.jawboneButton setTitle:@"Login" forState:UIControlStateNormal];
    [self.jawboneButton addTarget:self action:@selector(tappedLogin) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.jawboneButton];
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)tappedLogin {
    NSLog(@"Tapped login");
    self.jawboneLoginView = [UIWebView new];
    [self.jawboneLoginView setFrame:self.view.frame];
    [self.view addSubview:self.jawboneLoginView];
    
    NSString *clientID = @"Xdcjl7E4-F0";
    NSString *appSecret = @"7166a3040e2c610c6c3559ba93d5e0fc0dc3c6a1";

    [[UPPlatform sharedPlatform] startSessionWithClientID:clientID
                                             clientSecret:appSecret
                                                authScope:(UPPlatformAuthScopeExtendedRead | UPPlatformAuthScopeMoveRead)
                                               completion:^(UPSession *session, NSError *error) {
                                                   if (session != nil) {
                                                       // Your code to start making API requests goes here.
                                                       NSLog(@"response!!!!!!!!!");
                                                   }
                                               }];
    
//    NSURL* url = [NSURL URLWithString:@"https://jawbone.com/auth/oauth2/auth?response_type=code&client_id=Xdcjl7E4-F0&redirect_uri=https://spotsis.herokuapp.com/oauthredirect"];
    
//    NSURLRequest *request = [NSURLRequest requestWithURL:url];
//    [self.jawboneLoginView loadRequest:request];
}

@end
