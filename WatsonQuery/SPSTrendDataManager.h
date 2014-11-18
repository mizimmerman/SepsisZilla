//
//  SPSTrendDataManager.h
//  WatsonQuery
//
//  Created by gazevedo on 11/10/14.
//  Copyright (c) 2014 EECS 481. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CGBase.h>
#import "SPSGraphDataSource.h"

@interface SPSTrendDataManager : NSObject

+(SPSTrendDataManager *)data;

-(NSString *)headerForGraph:(SPSGraphType)type;
-(NSString *)summaryForGraph:(SPSGraphType)type;
-(CGFloat)activityValueForIndex:(NSInteger)index;
-(CGFloat)sleepValueForIndex:(NSInteger)index;
-(CGFloat)heartRateValueForIndex:(NSInteger)index;
-(NSInteger)activityCount;
-(NSInteger)sleepCount;
-(NSInteger)heartRateCount;

@end
