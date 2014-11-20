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
-(NSString *)changeOfValues:(NSArray *)values ofTypes:(Class)type forBaseRange:(NSIndexSet *)baseRange currentRange:(NSIndexSet *)curRange;
-(NSNumber *)valueForPredicate:(NSPredicate *)predicate ofValues:(NSArray *)values ofType:(Class)type overRange:(NSIndexSet *)range;

@end
