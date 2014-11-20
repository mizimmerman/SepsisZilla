//
//  SPSCoreDataHelper.h
//  Spotsis
//
//  Created by Greg Azevedo on 10/14/14.
//  Copyright (c) 2014 Spotsis LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface SPSCoreDataHelper : NSObject

+ (SPSCoreDataHelper *)data;
- (void)saveContext;

@property (nonatomic, readonly) NSManagedObjectContext *context;

@end
