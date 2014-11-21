//
//  SPSTrendDataManager+Algorithms.m
//  WatsonQuery
//
//  Created by Greg Azevedo on 11/18/14.
//  Copyright (c) 2014 EECS 481. All rights reserved.
//

#import "SPSTrendDataManager+Algorithms.h"

@implementation SPSTrendDataManager (Algorithms)

-(NSNumber *)averageOfValues:(NSArray *)values ofTypes:(Class)type
{
    NSInteger change = 0;
    if (type == [NSNumber class]) {
        //just basic array
        NSInteger sum = 0;
        for (NSNumber *point in values) {
            sum += [point integerValue];
        }
        change = sum / values.count;
    }
    return [NSNumber numberWithInteger:change];
}

/* Calculates average of the given values over a span of the most recent number of days specified */
-(NSNumber *)averageOfValues:(NSArray *)values ofTypes:(Class)type numberOfDays:(NSInteger)days
{
    NSInteger avg = 0;
    if (type == [NSNumber class]) {
        //just basic array
        NSInteger sum = 0;
        NSInteger max = ((NSUInteger)days < [values count]) ? days : [values count];
        for (int i=0; i < max; i++) {
            NSNumber* num = [values objectAtIndex:i];
            sum += [num intValue];
        }
        avg = sum / max;
    }
    return [NSNumber numberWithInteger:avg];
}

/* Calculates maximum of the given values over a span of the most recent number of days specified */
-(NSNumber *)findHighest:(NSArray *)values ofTypes:(Class)type numberOfDays:(NSInteger)days
{
    NSNumber *max;
    if (type == [NSNumber class]) {
        NSArray *range = [values subarrayWithRange:NSMakeRange(0, days)];
        max = [range valueForKeyPath:@"@max.intValue"];
    }
    return max;
}

/* Calculates minimum of the given values over a span of the most recent number of days specified */
-(NSNumber *)findLowest:(NSArray *)values ofTypes:(Class)type numberOfDays:(NSInteger)days
{
    NSNumber *min;
    if (type == [NSNumber class]) {
        NSArray *range = [values subarrayWithRange:NSMakeRange(0, days)];
        min = [range valueForKeyPath:@"@min.intValue"];
    }
    return min;
}

-(NSString *)changeOfValues:(NSArray *)values ofTypes:(Class)type forBaseRange:(NSIndexSet *)baseRange currentRange:(NSIndexSet *)curRange
{
    float change;
    if (type == [NSNumber class]) {
        __block float sumBase = 0;
        [baseRange enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL *stop) {
            sumBase += [[values objectAtIndex:idx] floatValue];
        }];
        float avgBase = sumBase / baseRange.count;
        
        __block float sumCur = 0;
        [curRange enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL *stop) {
            sumCur += [[values objectAtIndex:idx] floatValue];
        }];
//        NSNumber *fullAverage = [self averageOfValues:values ofTypes:type];
        
        float avgCur = sumCur / curRange.count;
        float numer = (avgCur - avgBase);
        float denom = (curRange.count);
        change = numer / denom;
    }
    
    NSNumberFormatter *formatter = [NSNumberFormatter new];
    formatter.numberStyle = NSNumberFormatterDecimalStyle;
    formatter.maximumFractionDigits = 2;  //Set number of fractional digits
    NSString *roundedNum = [formatter stringFromNumber:[NSNumber numberWithFloat:change]];

    return roundedNum;
}


//used for returning largest and smallest values of a trend over an interval
-(NSNumber *)valueForPredicate:(NSPredicate *)predicate ofValues:(NSArray *)values ofType:(Class)type overRange:(NSIndexSet *)range
{
    return 0;
}

// Algorithms for determining whether to send a health alert
-(NSString *)shouldSendNotificationForValues:(NSArray *)values ofTypes:(Class)type forTrendType:(SPSGraphType) trendType
{
    switch(trendType) {
        case SPSGraphTypeSleep: {
            // Outside of target range or standard deviation for 5 days
            NSInteger sleepBaseline = 8; //TODO get this from somewhere
            NSInteger basePlusMinus = 2;
            NSNumber *averageSleep = [self averageOfValues:values ofTypes:type];
            float sleepStdDev = 1.5; //TODO
            
            if ([values count] >= 5) {
                BOOL badSleep = true;
                BOOL trendingHigh = true;
                BOOL trendingLow = true;
                for (int night = 0; night < 5; ++night) {
                    NSInteger sleepForNight = [[values objectAtIndex:night] floatValue];
                    if (sleepForNight >= sleepBaseline - basePlusMinus && sleepForNight <= sleepBaseline + basePlusMinus) {
                        badSleep = false;
                    } else if (sleepForNight >= [averageSleep floatValue] - sleepStdDev) {
                        trendingLow = false;
                    } else if (sleepForNight <= [averageSleep floatValue] + sleepStdDev) {
                        trendingHigh = false;
                    }
                }
                if (badSleep) {
                    return @"Your sleep has been dangerously abnormal for the past 5 nights, which may be a sign of decreasing health. Contact your doctor.";
                } else if (trendingHigh) {
                    return@"Your amount of sleep has been unusually high for the past 5 nights. Consider contacting your doctor.";
                } else if (trendingLow) {
                    return@"Your amount of sleep has been unusually low for the past 5 nights. Consider contacting your doctor.";
                }
            }
            
            return nil;
        }
        case SPSGraphTypeActivity: {
            // Outside of target range or standard deviation for 5 days
            NSInteger activityBaseline = 6000; //TODO get this from somewhere
            NSInteger basePlusMinus = 1500; //TODO choose
            float averageActivity = [[self averageOfValues:values ofTypes:type] floatValue];
            float activityStdDev = 1000; //TODO
            
            if ([values count] >= 5) {
                BOOL badActivity = true;
                BOOL trendingLow = true;
                for (int day = 0; day < 5; ++day) {
                    NSInteger activityForDay = [[values objectAtIndex:day] floatValue];
                    if (activityForDay >= activityBaseline - basePlusMinus) {
                        badActivity = false;
                    } else if (activityForDay >= averageActivity - activityStdDev) {
                        trendingLow = false;
                    }
                }
                if (badActivity) {
                    return @"Your activity has been too low for the past 5 days, which may be a sign of decreasing health. Contact your doctor.";
                } else if (trendingLow) {
                    return@"Your level of sleep has been unusually low compared to your average for the past 5 days. Consider contacting your doctor.";
                }
            }
            return nil;
        }
        case SPSGraphTypeHR: {
            NSInteger age = 15; //TODO: get age
            float mostRecentHR = [[values objectAtIndex:0] floatValue];
            if (mostRecentHR > 220 - age) {
                return @"Most recent heart rate value is dangerously large. If this is not a mistake, contact your doctor immediately.";
            } else if (mostRecentHR < 60) {
                return @"Most recent heart rate value is dangerously small. If this is not a mistake, contact your doctor immediately.";
            }
            
            //5 days of continuous downward/upward trend, other characteristics of person should also effect that
            // TODO Check against trends here
            
            return nil;
        }
        default:
            return nil;
    }
}

@end
