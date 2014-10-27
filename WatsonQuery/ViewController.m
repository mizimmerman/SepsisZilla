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
@property (nonatomic) UIImageView *watsonLogo;

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
    [self.responseTextView setFrame:CGRectMake(10, self.view.frame.size.height/2, self.view.frame.size.width-20, self.view.frame.size.height/2-70)];
    [self.responseTextView setTextColor:[UIColor blackColor]];
    [self.responseTextView setText:@""];
    [self.responseTextView.layer setMasksToBounds:YES];
    [self.responseTextView.layer setCornerRadius:10];
    
    [self.view addSubview:self.responseTextView];
    
    self.questionField = [UITextView new];
    [self.questionField setFrame:CGRectMake(10, 100, self.view.frame.size.width-20, self.view.frame.size.height/8)];
    [self.questionField.layer setMasksToBounds:YES];
    [self.questionField.layer setCornerRadius:10];
    [self.questionField setFont:[UIFont systemFontOfSize:25]];
    [self.view addSubview:self.questionField];

    self.askButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.askButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.askButton setFrame:CGRectInset(self.view.frame, 100, 200)];
    [self.askButton setCenter:CGPointMake(self.view.frame.size.width*3/4+10, 50)];
    [self.askButton setTitle:@"Ask Watson" forState:UIControlStateNormal];
    [self.askButton setFont:[UIFont systemFontOfSize:20]];
    [self.askButton addTarget:self action:@selector(tappedAsk) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.askButton];
    
    self.watsonLogo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Watson-Avatar.jpg"]];
    [self.watsonLogo setFrame:CGRectMake(self.view.frame.size.width/2-50, self.view.frame.size.height/2-120, 100, 100)];
    [self.watsonLogo.layer setMasksToBounds:YES];
    [self.watsonLogo.layer setCornerRadius:10];
    [self.view addSubview:self.watsonLogo];
    
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
