//
//  SPSGraphDataSource.h
//  WatsonQuery
//
//  Created by gazevedo on 11/18/14.
//  Copyright (c) 2014 EECS 481. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, SPSGraphType) {
    SPSGraphTypeSleep,
    SPSGraphTypeActivity,
    SPSGraphTypeHR,
    SPSGraphCount
};

@protocol SPSGraphDataSource <NSObject>

-(CGFloat)valueForGraph:(SPSGraphType)type atXValue:(NSInteger)x;
-(NSInteger)numberOfPointsForType:(SPSGraphType)type;

@end
