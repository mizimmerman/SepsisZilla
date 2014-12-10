//
//  SPSTrendDataManager.m
//  WatsonQuery
//
//  Created by gazevedo on 11/10/14.
//  Copyright (c) 2014 EECS 481. All rights reserved.
//

#import "SPSTrendDataManager.h"
#import "SPSTrendDataManager+Algorithms.h"
@import HealthKit;

@interface SPSTrendDataManager()

@property (nonatomic) HKHealthStore *healthStore;

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
        
        self.sleeps = @[@9.14, @5.56, @6.17, @6.5, @7, @6.5, @8.13, @7.53, @7.57, @6.16,  @7.4, @4.37, @2.26, @8.13, @6.4, @5.14, @8.06];
        self.activities = @[@3291, @4705, @7319, @1755, @9394, @6190, @10124, @8949, @8551, @1233, @2297, @2034, @2550, @2931, @8580, @6789, @3558, @12872, @5059, @6080, @7931, @11257];
        self.heartRates = @[@78, @75, @81, @85, @84, @79, @77, @78, @82, @91, @92, @85];
        
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
    NSNumber *change;
    NSString *unit;
    NSInteger totalRecords = 0;
    NSInteger recent = 5;
    NSIndexSet *pastRecords = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(self.activities.count - recent, recent)];
    NSIndexSet *recentRecords = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, self.activities.count - recent)];
    
    NSIndexSet *sleepspastRecords = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(self.sleeps.count - recent, recent)];
    NSIndexSet *sleepsrecentRecords = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, self.sleeps.count - recent)];
    
    NSIndexSet *HRpastRecords = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(self.heartRates.count - recent, recent)];
    NSIndexSet *HRrecentRecords = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, self.heartRates.count - recent)];

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
            change = [self changeOfValues:self.sleeps ofTypes:[NSNumber class] forBaseRange:sleepspastRecords currentRange:sleepsrecentRecords];
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
            change = [self changeOfValues:self.heartRates ofTypes:[NSNumber class] forBaseRange:HRpastRecords currentRange:HRrecentRecords];
            break;
    }
    
    NSString *dayAvgStr = [NSString stringWithFormat:@"Daily average: %@ %@", dayAvg, unit];
    NSString *weekAvgStr = [NSString stringWithFormat:@"Weekly average: %@ %@", weekAvg, unit];
    NSString *monthAvgStr = [NSString stringWithFormat:@"Monthly average: %@ %@", monthAvg, unit];
    NSString *highStr = [NSString stringWithFormat:@"Weekly high: %@ %@", high, unit];
    NSString *lowStr = [NSString stringWithFormat:@"Weekly low: %@ %@", low, unit];
                         
    NSString *moreLess = ([change floatValue]> 0.0f) ? @"more" : @"less";
    float posChange = fabsf([change floatValue]);
    NSString* formattedFloat = [NSString stringWithFormat:@"%.02f", posChange];
    NSString *message = [NSString stringWithFormat:@"For the past %i days you've averaged %@ %@. Over the past %i days, you've averaged %@ %@ %@ than average.", totalRecords, average, unit, recent, formattedFloat, moreLess, unit];
    NSString *recommendation = ([change floatValue]> 0.0f) ? @"Nice job, you're on an upward trend!" : @"Watch closely, you're on a downward trend!";

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
