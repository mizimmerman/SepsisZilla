//
//  SPSTrendDataManager.m
//  WatsonQuery
//
//  Created by gazevedo on 11/10/14.
//  Copyright (c) 2014 EECS 481. All rights reserved.
//

#import "SPSTrendDataManager.h"
#import "SPSGraphDataSource.h"

@implementation SPSTrendDataManager

+(SPSTrendDataManager *)data
{
    static SPSTrendDataManager *singleton = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        singleton = [SPSTrendDataManager new];
    });
    return singleton;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.trendsCount = 3;
    }
    return self;
}

-(NSString *)headerForIndex:(NSInteger)index
{
    switch (index) {
        case SPSGraphTypeActivity:
            return @"Activity Trends";
        case SPSGraphTypeSleep:
            return @"Sleep Cycles";
        case SPSGraphTypeHR:
            return @"Heart Rate Trends";
        default:
            return @"";
    }
}

-(NSString *)summaryForIndex:(NSInteger)index
{
    NSString *message = [NSString stringWithFormat:@"You have gotten septic! See a doctor!"];
    return message;
}

-(CGFloat)sleepValueForDate:(NSInteger)index
{
    if (index % 2 == 0) {
        return 8;
    }
    return 6;
}

-(CGFloat)activityValueForDate:(NSInteger)index
{
    if (index % 2 == 0) {
        return 10000;
    }
    return 5000;
}

-(CGFloat)heartRateValueForIndex:(NSInteger)index
{
    if (index % 2 == 0) {
        return 60;
    }
    return 70;
}

@end
