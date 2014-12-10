//
//  SPSTrendDataManager+Algorithms.m
//  WatsonQuery
//
//  Created by Greg Azevedo on 11/18/14.
//  Copyright (c) 2014 EECS 481. All rights reserved.
//

#import "SPSTrendDataManager+Algorithms.h"
#import <math.h>

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

// Calculate the standard deviation of the supplied set of values
-(NSNumber *)standardDeviationOfValues:(NSArray *)values ofTypes:(Class)type
{
    if (type == [NSNumber class]) {
        // Find mean
        float mean = [[self averageOfValues:values ofTypes:type] floatValue];
        
        // Sum for all N (val - mean)^2
        float sum = 0;
        for (int i = 0; i < values.count; ++i) {
            float valAtIndex = [[values objectAtIndex:i] floatValue];
            sum += ((mean - valAtIndex) * (mean - valAtIndex));
        }
        // Divide by N
        sum /= values.count;
        
        // Square root
        float result = sqrt(sum);
        return [NSNumber numberWithFloat:result];
    }
    return nil;
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

-(NSNumber *)changeOfValues:(NSArray *)values ofTypes:(Class)type forBaseRange:(NSIndexSet *)baseRange currentRange:(NSIndexSet *)curRange
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
    return [NSNumber numberWithFloat:change];

}


//used for returning largest and smallest values of a trend over an interval
-(NSNumber *)valueForPredicate:(NSPredicate *)predicate ofValues:(NSArray *)values ofType:(Class)type overRange:(NSIndexSet *)range
{
    return 0;
}

// Algorithms for determining whether to send a health alert
// Currently checks values in the sleeps, steps, and heartRates arrays
// TODO: HK and figure out how to do HR
-(NSArray *)shouldSendHealthNotifications
{
    // Get age from HK for max heart rate calculation and recommended sleep numbers
    NSInteger userAge = 22; //Filler
    /* //Uncomment once Healthkit is available.
    NSInteger age;
    NSError *error;
    NSDate *dateOfBirth = nil;
    if ([HKHealthStore isHealthDataAvailable]) {
        dateOfBirth = [self.healthStore dateOfBirthWithError:&error]; //TODO where is the healthStore
    }
    
    if (!dateOfBirth) {
        NSLog(@"Either an error occured fetching the user's age information or none has been stored yet. Setting age to 15.");
        age = 15;
    } else {
        // Compute the age (in years) of the user.
        NSDate *now = [NSDate date];
        NSDateComponents *ageComponents = [[NSCalendar currentCalendar] components:NSCalendarUnitYear fromDate:dateOfBirth toDate:now options:NSCalendarWrapComponents];
        age = [ageComponents year];
    }
    */

    NSArray *values;
    NSMutableArray *notificationStrings = [NSMutableArray array];
    // case SPSGraphTypeSleep:
    // Outside of target range for age or individual standard deviation for 5 days
    NSInteger sleepBaseline;
    values = [self sleeps];
    if (userAge <= 12) {
        sleepBaseline = 10;
    } else if (userAge <= 18) {
        sleepBaseline = 9;
    } else {
        sleepBaseline = 8;
    }
    NSInteger basePlusMinus = 2;
    NSNumber *averageSleep = [self averageOfValues:values ofTypes:[NSNumber class]];
    float sleepStdDev = [[self standardDeviationOfValues:values ofTypes:[NSNumber class]] floatValue];
    
    if (values.count >= 5) {
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
            [notificationStrings addObject: @"Your sleep has been dangerously abnormal for the past 5 nights, which may be a sign of decreasing health. Contact your doctor."];
        } else if (trendingHigh) {
            [notificationStrings addObject: @"Your amount of sleep has been unusually high for the past 5 nights. Consider contacting your doctor."];
        } else if (trendingLow) {
            [notificationStrings addObject: @"Your amount of sleep has been unusually low for the past 5 nights. Consider contacting your doctor."];
        }
    }
            

    // case SPSGraphTypeActivity:
    values = [self activities];
    // Outside of target range or standard deviation for 5 days
    NSInteger activityBaseline = 6000;
    basePlusMinus = 1500;
    float averageActivity = [[self averageOfValues:values ofTypes:[NSNumber class]] floatValue];
    float activityStdDev = [[self standardDeviationOfValues:values ofTypes:[NSNumber class]] floatValue];
    
    if (values.count >= 5) {
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
            [notificationStrings addObject: @"Your activity has been too low for the past 5 days, which may be a sign of decreasing health. Contact your doctor."];
        } else if (trendingLow) {
            [notificationStrings addObject: @"Your level of activity has been unusually low compared to your average for the past 5 days. Consider contacting your doctor."];
        }
    }


    // case SPSGraphTypeHR:
    values = [self heartRates];
    float mostRecentHR = [[values objectAtIndex:0] floatValue];
    if (mostRecentHR > 220 - userAge) {
        [notificationStrings addObject: @"Most recent heart rate value is dangerously large. If this is not a mistake, contact your doctor immediately."];
    } else if (mostRecentHR < 60) {
        [notificationStrings addObject: @"Most recent heart rate value is dangerously small. If this is not a mistake, contact your doctor immediately."];
    }
    
    //5 days of continuous downward/upward trend, other characteristics of person should also effect that
    // TODO Check against trends here
    
    
    return notificationStrings;
}

@end
