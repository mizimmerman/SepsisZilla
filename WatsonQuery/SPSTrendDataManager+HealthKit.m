//
//  SPSTrendDataManager+HealthKit.m
//  Spotsis
//
//  Created by Greg Azevedo on 12/10/14.
//  Copyright (c) 2014 EECS 481. All rights reserved.
//

#import "SPSTrendDataManager+HealthKit.h"

@implementation SPSTrendDataManager (HealthKit)

-(void)loadHealthData {
    if ([HKHealthStore isHealthDataAvailable]) {
        NSSet *readDataTypes = [self dataTypesToRead];
        [self.healthStore requestAuthorizationToShareTypes:nil readTypes:readDataTypes completion:^(BOOL success, NSError *error) {
            if (!success) {
                NSLog(@"You didn't allow HealthKit to access these read/write data types. In your app, try to handle this error gracefully when a user decides not to provide access. The error was: %@. If you're using a simulator, try it on a device.", error);
                return;
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                HKSampleQuery *query = [[HKSampleQuery alloc]
                                        initWithSampleType:[HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount]
                                        predicate:nil limit:7 sortDescriptors:nil resultsHandler:^(HKSampleQuery *query, NSArray *results, NSError *error) {
                                            NSLog(@"results");
                                            for (HKQuantitySample *sample in results) {
                                                NSLog(@"sample: %@", sample.quantity);
                                                NSDate *date = [sample.metadata objectForKey:@"Modified Date"];
                                                NSNumber *count = [NSNumber numberWithDouble:[sample.quantity doubleValueForUnit:[HKUnit countUnit]]];
                                                [self.steps addObject:@{@"date": date, @"count":count}];
                                            }
//                                            [self.trendsCV reloadData];
                                        }];
                [self.healthStore executeQuery:query];
            });
        }];
    }
}

- (NSSet *)dataTypesToRead {
    NSMutableSet *trends = [NSMutableSet set];
    [trends addObject:[HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierHeartRate]];
    [trends addObject:[HKCategoryType categoryTypeForIdentifier:HKCategoryTypeIdentifierSleepAnalysis]];
    [trends addObject:[HKObjectType characteristicTypeForIdentifier:HKCharacteristicTypeIdentifierBiologicalSex]];
    [trends addObject:[HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount]];
    
    //    HKQuantityType *heightType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierHeight];
    //    HKQuantityType *weightType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierBodyMass];
    //    HKCharacteristicType *dob = [HKCharacteristicType characteristicTypeForIdentifier:HKCharacteristicTypeIdentifierDateOfBirth];
    return trends;
}

@end
