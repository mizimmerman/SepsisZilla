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
    SPSGraphTypeHR
};

@protocol SPSGraphDataSource <NSObject>
-(CGFloat)valueForGraph:(SPSGraphType)type atXValue:(NSInteger)x;
//-(CGFloat)valueForIndex:(NSInteger)index;
//-(SPSGraphType)type;

@end
