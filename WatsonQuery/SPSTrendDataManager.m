//
//  SPSTrendDataManager.m
//  WatsonQuery
//
//  Created by gazevedo on 11/10/14.
//  Copyright (c) 2014 EECS 481. All rights reserved.
//

#import "SPSTrendDataManager.h"

@implementation SPSTrendDataManager

+(SPSTrendDataManager *)data
{
    static SPSTrendDataManager *singleton = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        singleton = [SPSTrendDataManager new];
    });
    return singleton;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.trendsCount = 3;
    }
    return self;
}

@end
