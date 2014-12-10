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
#import "Reachability.h"

@interface SPSWatsonViewController () <UITextViewDelegate>

@property (nonatomic, readwrite) UIImageView *backgroundImageView;
@property (nonatomic) UITextView *responseTextView;
@property (nonatomic) UIButton *askButton;
@property (nonatomic) UITextView *questionField;
@property (nonatomic) UIImageView *watsonLogo;
@property (nonatomic) UITapGestureRecognizer *tapToDismiss;
@property (nonatomic) NSMutableArray *previousQuestions;
@property (nonatomic, getter = isConnected) BOOL connected;

@end

@implementation SPSWatsonViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        self.title = @"Main";
        self.previousQuestions = [NSMutableArray array];
    }
    return self;
}

- (void) loadView {
    [super loadView];
    [self.view setBackgroundColor:[UIColor colorWithRed:(30/255.0) green:(139/255.0) blue:(195/255.0) alpha:1]];
    
    self.questionField = [UITextView new];
    [self.questionField.layer setMasksToBounds:YES];
    [self.questionField.layer setCornerRadius:10];
    [self.questionField setFont:[UIFont systemFontOfSize:20]];
    [self.questionField setDelegate:self];
    [self.view addSubview:self.questionField];
    
    self.askButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.askButton setFrame:CGRectMake(self.view.frame.size.width *3/4-5, 40, self.view.frame.size.width / 4, self.view.frame.size.height/8-20)];
    [self.askButton setTitle:@"Ask Watson!" forState:UIControlStateNormal];
    [self.askButton.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [self.askButton.titleLabel setAdjustsFontSizeToFitWidth:YES];
    [self.askButton addTarget:self action:@selector(tappedAsk) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.askButton];

    self.responseTextView = [UITextView new];
    [self.responseTextView setFrame:CGRectMake(10, 120, self.view.frame.size.width-20, self.view.frame.size.height-190)];
    [self.responseTextView setTextColor:[UIColor blackColor]];
    [self.responseTextView setBackgroundColor:[UIColor whiteColor]];
    [self.responseTextView setTextAlignment:NSTextAlignmentCenter];
    [self.responseTextView setFont:[UIFont systemFontOfSize:18]];
    [self.responseTextView setText:@""];
    [self.responseTextView setEditable:NO];
    [self.responseTextView setDirectionalLockEnabled:YES];
    [self.responseTextView setAlwaysBounceVertical:YES];
    [self.responseTextView setAlwaysBounceHorizontal:NO];
    [self.responseTextView.layer setCornerRadius:10];
    [self.responseTextView setDelegate:self];
    [self.view addSubview:self.responseTextView];
    
    self.watsonLogo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"watson_logo"]];
    [self.watsonLogo.layer setMasksToBounds:YES];
    [self.watsonLogo.layer setCornerRadius:10];
    [self.view addSubview:self.watsonLogo];
    [self setUIToDefault];
}

- (void) viewDidLoad {
    [super viewDidLoad];
    self.tapToDismiss = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:self.tapToDismiss];
    [self.responseTextView addGestureRecognizer:self.tapToDismiss];
    if (![self checkInternetConnected]) {
        NSLog(@"Not connected");
        self.connected = false;
    } else {
        NSLog(@"connected");
        self.connected = true;
    }
}

- (void)tappedAsk {
    if ([self.questionField.text isEqualToString:@""]) {
        [self.responseTextView setText:@""];
        [self setUIToAskNewQuestion];
    } else {
        if (self.connected) {
            [self askQuestionWithText:self.questionField.text];
            [self setUIToViewAnswer];
        } else {
            [self.responseTextView setText:@"Sorry you aren't connected to the internet, please check your network settings."];
            [self setUIToDefault];
        }

    }
    [self.questionField resignFirstResponder];
}

-(void)setUIToViewAnswer {
    NSLog(@"move to side");
    NSNumber *rotationAtStart = [self.watsonLogo.layer valueForKeyPath:@"transform.rotation"];
    float myRotationAngle = M_PI*6;
    CATransform3D myRotationTransform = CATransform3DRotate(self.watsonLogo.layer.transform, myRotationAngle, 0.0, 0.0, 1.0);
    self.watsonLogo.layer.transform = myRotationTransform;
    CABasicAnimation *myAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    myAnimation.duration = 4;
    myAnimation.fromValue = rotationAtStart;
    myAnimation.toValue = [NSNumber numberWithFloat:([rotationAtStart floatValue] + myRotationAngle)];
    [self.watsonLogo.layer addAnimation:myAnimation forKey:@"transform.rotation"];
    
    [UIView animateWithDuration:2  delay:2 options:0 animations:^{
        [self.watsonLogo setFrame:CGRectMake(0, 0, 200*1.12, 200)];
        [self.watsonLogo setCenter:CGPointMake(self.view.center.x, self.view.center.y-80)];
        [self.watsonLogo setAlpha:0];
        [self.questionField setFrame:CGRectMake(10, 30, self.view.frame.size.width-20, self.questionField.frame.size.height)];
    } completion:^(BOOL finished) {
        
    }];
}

-(void)setUIToAskNewQuestion {
    [self.questionField setText:@""];
    [self.responseTextView setText:@"Ask Watson anything about sepsis"];
    [UIView animateWithDuration:1 animations:^{
        [self.watsonLogo setFrame:CGRectMake(0, 0, 100*1.12, 100)];
        [self.watsonLogo setCenter:CGPointMake(self.view.center.x, self.view.center.y-80)];
        [self.watsonLogo setAlpha:1];
        [self.questionField setFrame:CGRectMake(10, 30, self.view.frame.size.width*3/4-20, self.view.frame.size.height/8)];
    }];
}

-(void)setUIToDefault {
    [self.questionField setText:@"Tap to Ask Watson!"];
//    [self.responseTextView setText:@"You can ask..."];
    [UIView animateWithDuration:1 animations:^{
        [self.watsonLogo setFrame:CGRectMake(0, 0, 205*1.12, 205)];
        [self.watsonLogo setCenter:CGPointMake(self.view.center.x, self.view.center.y)];
        [self.watsonLogo setAlpha:1];
        [self.questionField setFrame:CGRectMake(10, 30, self.view.frame.size.width-20, self.view.frame.size.height/8)];
    }];
}

-(void)askQuestionWithText:(NSString *)text {
    __block UITextView *weakResponseTextView = self.responseTextView;
    [[WPWatson sharedManager] askQuestion:text completionHandler:^(NSString *response, NSError *connectionError) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([response isEqualToString:@""]) {
                weakResponseTextView.text = @"Sorry, Watson couldn't understand you question, please try another one";
            } else {
                weakResponseTextView.text = response;
            }
        });
    }];
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if ([text isEqualToString:@"\n"])  {
        [self tappedAsk];
    }
    
    CGFloat fontSize = textView.font.pointSize-2;
    if (textView.contentSize.height > textView.frame.size.height && fontSize > 8.0) {
        textView.font = [textView.font fontWithSize:fontSize];
    }
    return YES;
}

-(void)textViewDidBeginEditing:(UITextView *)textView {
    [self setUIToAskNewQuestion];
}

-(void)dismissKeyboard {
    NSLog(@"dismiss");
    [self.questionField resignFirstResponder];
    [self setUIToDefault];
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesEnded:touches withEvent:event];
    [self dismissKeyboard];
}


- (BOOL)checkInternetConnected
{
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [reachability currentReachabilityStatus];
    return !(networkStatus == NotReachable);
}

@end

