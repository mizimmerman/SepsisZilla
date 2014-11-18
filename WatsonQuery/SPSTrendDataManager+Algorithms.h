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
-(NSNumber *)changeOfValues:(NSArray *)values ofTypes:(Class)type forBaseInterval:(NSIndexSet *)base currentInterval:(NSIndexSet *)cur;

@end
