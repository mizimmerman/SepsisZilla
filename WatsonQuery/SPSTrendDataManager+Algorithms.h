//
//  SPSTrendDataManager+Algorithms.h
//  WatsonQuery
//
//  Created by Greg Azevedo on 11/18/14.
//  Copyright (c) 2014 EECS 481. All rights reserved.
//

#import "SPSTrendDataManager.h"

@interface SPSTrendDataManager (Algorithms)

-(NSNumber *)averageOfValues:(NSArray *)values ofTypes:(Class)type;
-(NSNumber *)averageOfValues:(NSArray *)values ofTypes:(Class)type numberOfDays:(NSInteger)days;
-(NSNumber *)standardDeviationOfValues:(NSArray *)values ofTypes:(Class)type;
-(NSNumber *)findHighest:(NSArray *)values ofTypes:(Class)type numberOfDays:(NSInteger)days;
-(NSNumber *)findLowest:(NSArray *)values ofTypes:(Class)type numberOfDays:(NSInteger)days;
-(NSString *)changeOfValues:(NSArray *)values ofTypes:(Class)type forBaseRange:(NSIndexSet *)baseRange currentRange:(NSIndexSet *)curRange;
-(NSNumber *)valueForPredicate:(NSPredicate *)predicate ofValues:(NSArray *)values ofType:(Class)type overRange:(NSIndexSet *)range;
-(NSString *)shouldSendNotificationForValues:(NSArray *)values ofTypes:(Class)type forTrendType:(SPSGraphType)trendType;

@end
