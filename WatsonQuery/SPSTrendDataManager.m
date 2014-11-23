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
        self.sleeps = @[@4, @5, @6, @8, @4, @9, @6, @6, @9, @9, @9, @9, @8, @3, @3, @3, @3];
        self.activities = @[@9000, @300, @4800, @8500, @3000, @8000, @1000, @9000, @9000, @10000, @5000, @12000];
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
    NSNumber *average;
    NSNumber *dayAvg;
    NSNumber *weekAvg;
    NSNumber *monthAvg;
    NSNumber *high;
    NSNumber *low;
    NSString *change;
    NSString *unit;
    NSInteger totalRecords = 0;
    NSInteger recent = 5;
    NSIndexSet *recentRecords = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(self.activities.count - recent, recent)];
    NSIndexSet *pastRecords = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, self.activities.count - recent)];

    switch (type) {
        case SPSGraphTypeActivity:
            totalRecords = self.activities.count;
            unit = @"steps";
            average = [self averageOfValues:self.activities ofTypes:[NSNumber class]];
            dayAvg = [self averageOfValues:self.activities ofTypes:[NSNumber class] numberOfDays:1];
            weekAvg = [self averageOfValues:self.activities ofTypes:[NSNumber class] numberOfDays:7];
            monthAvg = [self averageOfValues:self.activities ofTypes:[NSNumber class] numberOfDays:30];
            high = [self findHighest:self.activities ofTypes:[NSNumber class] numberOfDays:7];
            low = [self findLowest:self.activities ofTypes:[NSNumber class] numberOfDays:7];
            change = [self changeOfValues:self.activities ofTypes:[NSNumber class] forBaseRange:pastRecords currentRange:recentRecords];
            break;
        case SPSGraphTypeSleep:
            totalRecords = self.sleeps.count;
            unit = @"hours";
            average = [self averageOfValues:self.sleeps ofTypes:[NSNumber class]];
            dayAvg = [self averageOfValues:self.sleeps ofTypes:[NSNumber class] numberOfDays:1];
            weekAvg = [self averageOfValues:self.sleeps ofTypes:[NSNumber class] numberOfDays:7];
            monthAvg = [self averageOfValues:self.sleeps ofTypes:[NSNumber class] numberOfDays:30];
            high = [self findHighest:self.sleeps ofTypes:[NSNumber class] numberOfDays:7];
            low = [self findLowest:self.sleeps ofTypes:[NSNumber class] numberOfDays:7];
            change = [self changeOfValues:self.sleeps ofTypes:[NSNumber class] forBaseRange:pastRecords currentRange:recentRecords];
            break;
        case SPSGraphTypeHR:
            totalRecords = self.heartRates.count;
            unit = @"bpm";
            average = [self averageOfValues:self.heartRates ofTypes:[NSNumber class]];
            dayAvg = [self averageOfValues:self.heartRates ofTypes:[NSNumber class] numberOfDays:1];
            weekAvg = [self averageOfValues:self.heartRates ofTypes:[NSNumber class] numberOfDays:7];
            monthAvg = [self averageOfValues:self.heartRates ofTypes:[NSNumber class] numberOfDays:30];
            high = [self findHighest:self.heartRates ofTypes:[NSNumber class] numberOfDays:7];
            low = [self findLowest:self.heartRates ofTypes:[NSNumber class] numberOfDays:7];
            change = [self changeOfValues:self.heartRates ofTypes:[NSNumber class] forBaseRange:pastRecords currentRange:recentRecords];
            break;
    }
    
    NSString *dayAvgStr = [NSString stringWithFormat:@"Daily average: %@ %@", dayAvg, unit];
    NSString *weekAvgStr = [NSString stringWithFormat:@"Weekly average: %@ %@", weekAvg, unit];
    NSString *monthAvgStr = [NSString stringWithFormat:@"Monthly average: %@ %@", monthAvg, unit];
    NSString *highStr = [NSString stringWithFormat:@"Weekly high: %@ %@", high, unit];
    NSString *lowStr = [NSString stringWithFormat:@"Weekly low: %@ %@", low, unit];
                         
    NSString *moreLess = (change > 0) ? @"more" : @"less";
    
    NSString *message = [NSString stringWithFormat:@"For the past %i days you've averaged %@ %@. Over the past %i days, you've averaged %@ %@ %@ than average.", totalRecords, average, unit, recent, change, moreLess, unit];
    NSString *recommendation = (change > 0) ? @"Nice job!" : @"You have gotten septic! See a doctor!";

    return [NSString stringWithFormat:@"%@\n%@\n%@\n%@\n%@\n\n%@\n\n%@", dayAvgStr, weekAvgStr, monthAvgStr, highStr, lowStr, message, recommendation];

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
