//
//  SPSTrendDataManager.h
//  WatsonQuery
//
//  Created by gazevedo on 11/10/14.
//  Copyright (c) 2014 EECS 481. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SPSTrendDataManager : NSObject

+(SPSTrendDataManager *)data;

@property (nonatomic) NSUInteger trendsCount;

@end
