//
//  ViewController.m
//  WatsonQuery
//
//  Created by Greg Azevedo on 10/15/14.
//  Copyright (c) 2014 EECS 481. All rights reserved.
//


#import "SPSWatsonViewController.h"
#import "SPSWatsonViewController.h"
#import "WPWatson.h"
#import "UIColor+SPSColors.h"

@interface SPSWatsonViewController () <UITextViewDelegate>


@property (nonatomic, readwrite) UIImageView *backgroundImageView;
@property (nonatomic) UITextView *responseTextView;
@property (nonatomic) UIButton *askButton;
@property (nonatomic) UITextView *questionField;
@property (nonatomic) UIImageView *watsonLogo;

@end

@implementation SPSWatsonViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        self.title = @"Main";
    }
    return self;
}

- (void) loadView {
    [super loadView];
    
}



- (void) viewDidLoad{
    [super viewDidLoad];

    UIImageView *backgroundImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width,self.view.frame.size.height)];
    UIImage *image = [UIImage imageNamed:@"background"];
    [backgroundImage setImage:image];
    [self.view addSubview:backgroundImage];

    self.backgroundImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width,self.view.frame.size.height)];
    self.backgroundImageView.animationImages = [[NSArray alloc] initWithObjects:
                                                [UIImage imageNamed:@"CB00001"],
                                                [UIImage imageNamed:@"CB00003"],
                                                [UIImage imageNamed:@"CB00004"],
                                                [UIImage imageNamed:@"CB00005"],
                                                [UIImage imageNamed:@"CB00006"],
                                                [UIImage imageNamed:@"CB00007"],
                                                [UIImage imageNamed:@"CB00008"],
                                                [UIImage imageNamed:@"CB00009"],
                                                [UIImage imageNamed:@"CB00010"],
                                                [UIImage imageNamed:@"CB00011"],
                                                [UIImage imageNamed:@"CB00012"],
                                                [UIImage imageNamed:@"CB00013"],
                                                [UIImage imageNamed:@"CB00014"],
                                                [UIImage imageNamed:@"CB00015"],
                                                [UIImage imageNamed:@"CB00016"],
                                                [UIImage imageNamed:@"CB00017"],
                                                [UIImage imageNamed:@"CB00018"],
                                                [UIImage imageNamed:@"CB00019"],
                                                [UIImage imageNamed:@"CB00020"],
                                                [UIImage imageNamed:@"CB00021"],
                                                [UIImage imageNamed:@"CB00022"],
                                                [UIImage imageNamed:@"CB00023"],
                                                [UIImage imageNamed:@"CB00024"],
                                                [UIImage imageNamed:@"CB00025"],
                                                [UIImage imageNamed:@"CB00026"],
                                                [UIImage imageNamed:@"CB00027"],
                                                [UIImage imageNamed:@"CB00028"],
                                                [UIImage imageNamed:@"CB00029"],
                                                [UIImage imageNamed:@"CB00030"],
                                                [UIImage imageNamed:@"CB00031"],
                                                [UIImage imageNamed:@"CB00032"],
                                                [UIImage imageNamed:@"CB00033"],
                                                [UIImage imageNamed:@"CB00034"],
                                                [UIImage imageNamed:@"CB00035"],
                                                [UIImage imageNamed:@"CB00036"],
                                                [UIImage imageNamed:@"CB00037"],
                                                [UIImage imageNamed:@"CB00038"],
                                                [UIImage imageNamed:@"CB00039"],
                                                [UIImage imageNamed:@"CB00040"],
                                                [UIImage imageNamed:@"CB00041"],
                                                [UIImage imageNamed:@"CB00042"],
                                                [UIImage imageNamed:@"CB00043"],
                                                [UIImage imageNamed:@"CB00044"],
                                                [UIImage imageNamed:@"CB00045"],
                                                [UIImage imageNamed:@"CB00046"],
                                                [UIImage imageNamed:@"CB00047"],
                                                [UIImage imageNamed:@"CB00048"],
                                                [UIImage imageNamed:@"CB00049"],
                                                [UIImage imageNamed:@"CB00050"],
                                                [UIImage imageNamed:@"CB00051"],
                                                [UIImage imageNamed:@"CB00052"],
                                                [UIImage imageNamed:@"CB00053"],
                                                [UIImage imageNamed:@"CB00054"],
                                                [UIImage imageNamed:@"CB00055"],
                                                [UIImage imageNamed:@"CB00056"],
                                                [UIImage imageNamed:@"CB00057"],
                                                [UIImage imageNamed:@"CB00058"],
                                                [UIImage imageNamed:@"CB00059"],
                                                [UIImage imageNamed:@"CB00060"],nil];
    self.backgroundImageView.animationDuration = 2.5f;
    self.backgroundImageView.animationRepeatCount = 1;
   

    [self.view addSubview:self.backgroundImageView];
//
    self.responseTextView = [UITextView new];
    self.responseTextView.contentInset = UIEdgeInsetsMake(5, 10, 5, 10);
//    [self.responseTextView setFrame:CGRectMake(50, 200, self.view.frame.size.width-100, self.view.frame.size.height/3.5)];
    [self.responseTextView setFrame:self.backgroundImageView.frame];
    [self.responseTextView setTextColor:[UIColor blackColor]];
    self.responseTextView.backgroundColor = [UIColor clearColor];
    self.responseTextView.font = [UIFont systemFontOfSize:22];
    [self.responseTextView setText:@""];
    [self.responseTextView.layer setMasksToBounds:YES];
    [self.responseTextView.layer setCornerRadius:self.responseTextView.frame.size.height/2];
//
    [self.view addSubview:self.responseTextView];

    self.questionField = [UITextView new];
    [self.questionField setFrame:CGRectMake(10, 475, self.view.frame.size.width-20, self.view.frame.size.height/8)];
    [self.questionField.layer setMasksToBounds:YES];
    [self.questionField.layer setCornerRadius:10];
    [self.questionField setFont:[UIFont systemFontOfSize:25]];
    [self.view addSubview:self.questionField];
    [self.questionField setDelegate:self];
    
    self.askButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.askButton.frame = CGRectMake(60, 565, 261, 47); // position in the parent view and set the size of the button
    [self.askButton setTitle:@"Ask Watson!" forState:UIControlStateNormal];
    [self.askButton setFont:[UIFont systemFontOfSize:20]];
    [self.askButton addTarget:self action:@selector(tappedAsk) forControlEvents:UIControlEventTouchUpInside];
    [self.askButton setBackgroundImage:[UIImage imageNamed:@"whiteButton.png"]
                        forState:UIControlStateNormal];
    [self.view addSubview:self.askButton];

    
    self.watsonLogo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"watson_logo"]];
    [self.watsonLogo setFrame:CGRectMake(10, 10, 125*1.12, 125)];
    [self.watsonLogo.layer setMasksToBounds:YES];
    [self.watsonLogo.layer setCornerRadius:10];
    [self.view addSubview:self.watsonLogo];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//


- (void)tappedAsk {
    [self.backgroundImageView startAnimating];
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

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if ([text isEqualToString:@"\n"])  {
        [textView resignFirstResponder];
        [self tappedAsk];
    }
    return YES;
}


-(BOOL)textViewShouldEndEditing:(UITextView *)textView {
    [textView resignFirstResponder];
    [self tappedAsk];
    return true;
}

//-(void)textViewDidEndEditing:(UITextView *)textView {
//
//}

@end
























