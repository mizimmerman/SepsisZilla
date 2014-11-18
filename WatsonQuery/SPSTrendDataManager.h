//
//  SPSTrendDataManager.h
//  WatsonQuery
//
//  Created by gazevedo on 11/10/14.
//  Copyright (c) 2014 EECS 481. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CGBase.h>

@interface SPSTrendDataManager : NSObject

+(SPSTrendDataManager *)data;

@property (nonatomic) NSUInteger trendsCount;

-(NSString *)headerForIndex:(NSInteger)index;
-(NSString *)summaryForIndex:(NSInteger)index;
-(CGFloat)activityValueForDate:(NSInteger)index;
-(CGFloat)sleepValueForDate:(NSInteger)index;
-(CGFloat)heartRateValueForIndex:(NSInteger)index;

@end
