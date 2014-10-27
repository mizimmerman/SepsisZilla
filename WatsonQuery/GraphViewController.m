//
//  GraphViewController.m
//  WatsonQuery
//
//  Created by Greg Azevedo on 10/20/14.
//  Copyright (c) 2014 EECS 481. All rights reserved.
//

#import "GraphViewController.h"
#import <UPPlatform/UPPlatform.h>
#import <UPPlatform/UPUserAPI.h>
#import <UPPlatform/UPMoveAPI.h>
#import <UPPlatform/UPSleepAPI.h>

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
                                                       [self showSteps];
                                                       
                                                       /* TODO: Not sure how to switch between sleep view and steps view.
                                                                Still need to get data from trends to ask Watson */
                                                       
                                                       //[self showSleep];
                                                       NSLog(@"response!!!!!!!!!");
                                                   }
                                               }];
    
//    NSURL* url = [NSURL URLWithString:@"https://jawbone.com/auth/oauth2/auth?response_type=code&client_id=Xdcjl7E4-F0&redirect_uri=https://spotsis.herokuapp.com/oauthredirect"];
    
//    NSURLRequest *request = [NSURLRequest requestWithURL:url];
//    [self.jawboneLoginView loadRequest:request];
}

- (void)showSteps{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    CGFloat screenHeight = screenRect.size.height;
    
    [UPMoveAPI getMovesWithLimit:5U completion:^(NSArray *moves, UPURLResponse *response, NSError *error) {
        int i=0;
        for (UPMove *move in moves){
            NSLog(@"%@", move);
            [UPMoveAPI getMoveGraphImage:move completion:^(UIImage *image) {
                UIImageView *moveView = [[UIImageView alloc] initWithFrame:CGRectMake(0, (i*screenHeight/6)+40, screenWidth , (screenHeight/6)-50)];
                moveView.image = image;
                [moveView setBackgroundColor:[UIColor blackColor]];
                [self.view addSubview:moveView];
            }];
            
            int offset = (i*screenHeight/6)+20;
            UITextView *date = [UITextView new];
            [date setFrame:CGRectMake(0, offset, 100, 30)];
            [date setTextColor:[UIColor blackColor]];
            
            NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"MM/dd"];
            NSString *dateString = [dateFormatter stringFromDate:[move date]];
            NSString *dateText = [@"Date: " stringByAppendingString:dateString];
            [date setText:dateText];
            [self.view addSubview:date];
            
            UITextView *steps = [UITextView new];
            [steps setFrame:CGRectMake(100, offset, 100, 30)];
            [steps setTextColor:[UIColor blackColor]];
            NSString *stepsString = [[move steps] stringValue];
            NSString *stepsText = [@"Steps: " stringByAppendingString:stepsString];
            [steps setText:stepsText];
            [self.view addSubview:steps];
            i++;
        }
    }];
    
}

- (void)showSleep{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    CGFloat screenHeight = screenRect.size.height;
    [UPSleepAPI getSleepsWithLimit:5U completion:^(NSArray *sleeps, UPURLResponse *response, NSError *error) {
        int i=0;
        for (UPSleep *sleep in sleeps){
            NSLog(@"%@", sleep);
            [UPSleepAPI getSleepGraphImage:sleep completion:^(UIImage *image) {
                UIImageView *sleepView = [[UIImageView alloc] initWithFrame:CGRectMake(0, i*screenHeight/6+40, screenWidth , (screenHeight/6)-50)];
                sleepView.image = image;
                [self.view addSubview:sleepView];
            }];
            
            int offset =(i*screenHeight/6)+20;
            UITextView *date = [UITextView new];
            [date setFrame:CGRectMake(0, offset, 100, 30)];
            [date setTextColor:[UIColor blackColor]];
            
            NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"MM/dd"];
            NSString *dateString = [dateFormatter stringFromDate:[sleep date]];
            NSString *dateText = [@"Date: " stringByAppendingString:dateString];
            [date setText:dateText];
            [self.view addSubview:date];
            
            UITextView *time = [UITextView new];
            [time setFrame:CGRectMake(100, offset, 100, 30)];
            [time setTextColor:[UIColor blackColor]];
            NSString *timeString = [[sleep totalTime] stringValue];
            NSString *timeText = [@"Time: " stringByAppendingString:timeString];
            [time setText:timeText];
            [self.view addSubview:time];
            
            
            UITextView *quality = [UITextView new];
            [quality setFrame:CGRectMake(100, offset, 100, 30)];
            [quality setTextColor:[UIColor blackColor]];
            NSString *qualityString = [[sleep quality] stringValue];
            NSString *qualityText = [@"Quality: " stringByAppendingString:qualityString];
            [time setText:qualityText];
            [self.view addSubview:quality];
            
            i++;
        }
    }];
}


@end
