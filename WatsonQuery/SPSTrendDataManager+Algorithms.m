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
// Sleep and activity (same algorithm with different data sources)
-(NSString *)shouldSendNotificationForValues:(NSArray *)values forTrendType:(SPSGraphType) trendType
{
    //switch(type)
        //conditionals per type
        //return message depending on conditional hit
}

@end
