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

-(NSNumber *)changeOfValues:(NSArray *)values ofTypes:(Class)type forBaseInterval:(NSIndexSet *)base currentInterval:(NSIndexSet *)cur
{
    NSInteger change = 5;
    if (type == [NSNumber class]) {
        __block NSInteger sumBase = 0;
        [base enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL *stop) {
            sumBase += [[values objectAtIndex:idx] integerValue];
        }];
        NSInteger avgBase = sumBase / base.count;
        
        __block NSInteger sumCur = 0;
        [cur enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL *stop) {
            sumCur += [[values objectAtIndex:idx] integerValue];
        }];
//        NSNumber *fullAverage = [self averageOfValues:values ofTypes:type];
        
        NSInteger avgCur = sumCur / cur.count;
        NSInteger numer = (avgCur - avgBase);
        NSInteger denom = (cur.count);
        change = numer / denom;
    }
    return [NSNumber numberWithInteger:change];
}

@end
