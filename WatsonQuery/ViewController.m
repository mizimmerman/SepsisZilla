//
//  ViewController.m
//  WatsonQuery
//
//  Created by Greg Azevedo on 10/15/14.
//  Copyright (c) 2014 EECS 481. All rights reserved.
//

#import "ViewController.h"
#import "WPWatson.h"
#import "UIColor+SPSColors.h"

@interface ViewController ()

@property (nonatomic) UITextView *responseTextView;
@property (nonatomic) UIButton *askButton;
@property (nonatomic) UITextView *questionField;

@end

@implementation ViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        self.title = @"Main";
    }
    return self;
}

- (void)loadView {
    [super loadView];
    self.view.backgroundColor = [UIColor themeColor1];
    self.responseTextView = [UITextView new];
    self.responseTextView.contentInset = UIEdgeInsetsMake(5, 10, 5, 10);
    [self.responseTextView setFrame:CGRectMake(10, 368, 300, 100)];
    [self.responseTextView setTextColor:[UIColor blackColor]];
    [self.responseTextView setText:@"uhhhhhhhhh"];
    [self.view addSubview:self.responseTextView];
    
    self.questionField = [UITextView new];
    [self.questionField setFrame:CGRectMake(10, 20, 220, 40)];
//    [self.questionField setPlaceholder:@"Enter your Q"];
    [self.view addSubview:self.questionField];

    self.askButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.askButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.askButton setFrame:CGRectMake(220, 20, 100, 40)];
    [self.askButton setTitle:@"Ask Watson" forState:UIControlStateNormal];
    [self.askButton addTarget:self action:@selector(tappedAsk) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.askButton];
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)tappedAsk {
    [self askQuestionWithText:self.questionField.text];
    [self.questionField resignFirstResponder];
}

-(void)askQuestionWithText:(NSString *)text {
    __block UITextView *weakResponseTextView = self.responseTextView;
    [[WPWatson sharedManager] askQuestion:text completionHandler:^(NSString *response, NSError *connectionError) {
        dispatch_async(dispatch_get_main_queue(), ^{
            weakResponseTextView.text = response;
        });
    }];
}

@end
