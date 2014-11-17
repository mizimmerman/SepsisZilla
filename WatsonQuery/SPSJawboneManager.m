//
//  SPSJawboneManager.m
//  WatsonQuery
//
//  Created by gazevedo on 11/17/14.
//  Copyright (c) 2014 EECS 481. All rights reserved.
//

#import "SPSJawboneManager.h"
#import <UIKit/UIKit.h>
#import <UPPlatform/UPPlatform.h>
#import <UPPlatform/UPUserAPI.h>
#import <UPPlatform/UPMoveAPI.h>
#import <UPPlatform/UPSleepAPI.h>

@implementation SPSJawboneManager

- (NSArray *)recentSteps {
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    CGFloat screenHeight = screenRect.size.height;
    NSMutableArray *stepViews = [NSMutableArray array];
    NSMutableArray *dateViews = [NSMutableArray array];
    
    [UPMoveAPI getMovesWithLimit:5U completion:^(NSArray *moves, UPURLResponse *response, NSError *error) {
        if (error) {
            NSLog(@"%@", error.userInfo);
        }
        int i=0;
        for (UPMove *move in moves){
            NSLog(@"%@", move);
            [UPMoveAPI getMoveGraphImage:move completion:^(UIImage *image) {
                UIImageView *moveView = [[UIImageView alloc] initWithFrame:CGRectMake(0, (i*screenHeight/6)+40, screenWidth , (screenHeight/6)-50)];
                moveView.image = image;
                [moveView setBackgroundColor:[UIColor blackColor]];
//                [self.view addSubview:moveView];
                [stepViews addObject:moveView];
            }];
            
            int offset = (i*screenHeight/6)+20;
            UITextView *dateView = [UITextView new];
            [dateView setFrame:CGRectMake(0, offset, 100, 30)];
            [dateView setTextColor:[UIColor blackColor]];
            
            NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"MM/dd"];
            NSString *dateString = [dateFormatter stringFromDate:[move date]];
            NSString *dateText = [@"Date: " stringByAppendingString:dateString];
            [dateView setText:dateText];
//            [self.view addSubview:date];
            [dateViews addObject:dateView];
            UITextView *steps = [UITextView new];
            [steps setFrame:CGRectMake(100, offset, 100, 30)];
            [steps setTextColor:[UIColor blackColor]];
            NSString *stepsString = [[move steps] stringValue];
            NSString *stepsText = [@"Steps: " stringByAppendingString:stepsString];
            [steps setText:stepsText];
//            [self.view addSubview:steps];
            [stepViews addObject:steps];
            i++;
        }
    }];
    return stepViews;
}

//- (void)showSleep {
//    CGRect screenRect = [[UIScreen mainScreen] bounds];
//    CGFloat screenWidth = screenRect.size.width;
//    CGFloat screenHeight = screenRect.size.height;
//    [UPSleepAPI getSleepsWithLimit:5U completion:^(NSArray *sleeps, UPURLResponse *response, NSError *error) {
//        int i=0;
//        for (UPSleep *sleep in sleeps){
//            NSLog(@"%@", sleep);
//            [UPSleepAPI getSleepGraphImage:sleep completion:^(UIImage *image) {
//                UIImageView *sleepView = [[UIImageView alloc] initWithFrame:CGRectMake(0, i*screenHeight/6+40, screenWidth , (screenHeight/6)-50)];
//                sleepView.image = image;
//                [self.view addSubview:sleepView];
//            }];
//            
//            int offset =(i*screenHeight/6)+20;
//            UITextView *date = [UITextView new];
//            [date setFrame:CGRectMake(0, offset, 100, 30)];
//            [date setTextColor:[UIColor blackColor]];
//            
//            NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
//            [dateFormatter setDateFormat:@"MM/dd"];
//            NSString *dateString = [dateFormatter stringFromDate:[sleep date]];
//            NSString *dateText = [@"Date: " stringByAppendingString:dateString];
//            [date setText:dateText];
//            [self.view addSubview:date];
//            
//            UITextView *time = [UITextView new];
//            [time setFrame:CGRectMake(100, offset, 100, 30)];
//            [time setTextColor:[UIColor blackColor]];
//            NSString *timeString = [[sleep totalTime] stringValue];
//            NSString *timeText = [@"Time: " stringByAppendingString:timeString];
//            [time setText:timeText];
//            [self.view addSubview:time];
//            
//            
//            UITextView *quality = [UITextView new];
//            [quality setFrame:CGRectMake(100, offset, 100, 30)];
//            [quality setTextColor:[UIColor blackColor]];
//            NSString *qualityString = [[sleep quality] stringValue];
//            NSString *qualityText = [@"Quality: " stringByAppendingString:qualityString];
//            [time setText:qualityText];
//            [self.view addSubview:quality];
//            
//            i++;
//        }
//    }];
//}

@end
