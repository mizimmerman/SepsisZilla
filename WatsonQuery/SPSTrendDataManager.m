//
//  SPSTrendDataManager.m
//  WatsonQuery
//
//  Created by gazevedo on 11/10/14.
//  Copyright (c) 2014 EECS 481. All rights reserved.
//

#import "SPSTrendDataManager.h"
#import "SPSTrendDataManager+Algorithms.h"

@interface SPSTrendDataManager()

@property (nonatomic) NSArray *sleeps;
@property (nonatomic) NSArray *activities;
@property (nonatomic) NSArray *heartRates;

@end

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
        self.sleeps = @[@4, @5, @6, @8, @4, @9, @6, @6, @9, @9, @9, @9, @8];
        self.activities = @[@9000, @300, @4800, @8500, @3000, @8000, @1000, @9000, @9000, @10000, @5000, @50000];
        self.heartRates = @[@60, @80, @60, @80, @90, @90, @60, @60, @90, @90, @95, @80, @85];
        
    }
    return self;
}

-(NSString *)headerForGraph:(SPSGraphType)type
{
    switch (type) {
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

-(NSString *)summaryForGraph:(SPSGraphType)type
{
    NSNumber *average = 0;
    NSNumber *change = 0;
    NSString *message;
    NSString *recommendation;
    NSString *unit;
    NSString *moreLess;
    NSInteger totalRecords;
    NSInteger recent = 5;
    NSIndexSet *cur = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(self.activities.count - recent, recent)];
    NSIndexSet *base = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, self.activities.count - recent)];

    switch (type) {
        case SPSGraphTypeActivity: {
            totalRecords = self.activities.count;
            average = [self averageOfValues:self.activities ofTypes:[NSNumber class]];
            change = [self changeOfValues:self.activities ofTypes:[NSNumber class] forBaseInterval:base currentInterval:cur];
            unit = @"steps";
            moreLess = (change > 0) ? @"more" : @"less";
            recommendation = (change > 0) ? @"Nice job!" : @"You have gotten septic! See a doctor!";
            break;
        }
        case SPSGraphTypeSleep:
            totalRecords = self.sleeps.count;
            unit = @"hours";
            average = [self averageOfValues:self.sleeps ofTypes:[NSNumber class]];
            change = [self changeOfValues:self.sleeps ofTypes:[NSNumber class] forBaseInterval:base currentInterval:cur];
            moreLess = (change > 0) ? @"more" : @"less";
            recommendation = (change > 0) ? @"Nice job!" : @"You have gotten septic! See a doctor!";
            break;
        case SPSGraphTypeHR:
            totalRecords = self.heartRates.count;
            unit = @"bpm";
            average = [self averageOfValues:self.heartRates ofTypes:[NSNumber class]];
            change = [self changeOfValues:self.heartRates ofTypes:[NSNumber class] forBaseInterval:base currentInterval:cur];
            moreLess = (change > 0) ? @"more" : @"less";
            recommendation = (change > 0) ? @"Nice job!" : @"You have gotten septic! See a doctor!";
            break;
        default:
            break;
    }
    message = [NSString stringWithFormat:@"For the past %i days you've averaged %@ steps. Over the past %i days, you've averaged %@ %@ %@ than average.", totalRecords, average, recent, change, moreLess, unit];

    return [NSString stringWithFormat:@"%@ %@", message, recommendation];
}

-(CGFloat)sleepValueForIndex:(NSInteger)index
{
    return [[self.sleeps objectAtIndex:index] floatValue];
}

-(CGFloat)activityValueForIndex:(NSInteger)index
{
    return [[self.activities objectAtIndex:index] floatValue];
}

-(CGFloat)heartRateValueForIndex:(NSInteger)index
{
    return [[self.heartRates objectAtIndex:index] floatValue];
}

-(NSInteger)activityCount
{
    return self.activities.count;
}

-(NSInteger)sleepCount
{
    return self.sleeps.count;
}

-(NSInteger)heartRateCount
{
    return self.heartRates.count;
}

@end
