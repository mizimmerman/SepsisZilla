//
//  SPSTrendViewController.m
//  WatsonQuery
//
//  Created by gazevedo on 11/10/14.
//  Copyright (c) 2014 EECS 481. All rights reserved.
//

#import "SPSTrendViewController.h"
#import "SPSTrendDataManager.h"
#import "SPSTrendLayout.h"
#import "SPSTrendViewCell.h"
#import "SPSGraphDataSource.h"
#import "UIColor+SPSColors.h"
#import <HealthKit/HealthKit.h>

@interface SPSTrendViewController () <UICollectionViewDataSource, UICollectionViewDelegate, SPSGraphDataSource>

@property (nonatomic) UICollectionView *trendsCV;
@property (nonatomic) SPSTrendLayout *layout;
@property (nonatomic) HKHealthStore *healthStore;

@end

@implementation SPSTrendViewController

- (id)init
{
    self = [super init];
    if (self) {
        [self setTitle:@"Trends"];
    }
    return self;
}

-(void)loadView
{
    [super loadView];
    [self loadTrendsCV];
}

-(void)loadTrendsCV
{
    self.layout = [SPSTrendLayout new];
    [self.layout setItemSize:CGSizeMake(self.view.frame.size.width, self.view.frame.size.height)];
    self.trendsCV = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:self.layout];
    [self.trendsCV setDelegate:self];
    [self.trendsCV setDataSource:self];
    [self.trendsCV registerClass:[SPSTrendViewCell class] forCellWithReuseIdentifier:@"Cell"];
    [self.trendsCV setBackgroundColor:[UIColor blackColor]];//[UIColor colorWithRed:(40/255.0) green:(179/255.0) blue:(230/255.0) alpha:1]];
    [self.trendsCV setContentOffset:CGPointMake(0, 0)];
    [self.view addSubview:self.trendsCV];
    
    UIImageView *backgroundImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    UIImage *image = [UIImage imageNamed:@"bluefadetowhite"];
    [backgroundImage setImage:image];
    [self.trendsCV setBackgroundView:backgroundImage];
    
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.healthStore = [HKHealthStore new];
    if ([HKHealthStore isHealthDataAvailable]) {
//        NSSet *writeDataTypes = [self dataTypesToWrite];
        NSSet *readDataTypes = [self dataTypesToRead];
        
        [self.healthStore requestAuthorizationToShareTypes:nil readTypes:readDataTypes completion:^(BOOL success, NSError *error) {
            if (!success) {
                NSLog(@"You didn't allow HealthKit to access these read/write data types. In your app, try to handle this error gracefully when a user decides not to provide access. The error was: %@. If you're using a simulator, try it on a device.", error);
                
                return;
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
//                // Update the user interface based on the current user's health information.
//                [self updateUsersAgeLabel];
//                [self updateUsersHeightLabel];
//                [self updateUsersWeightLabel];
            });
        }];
    }
}


// Returns the types of data that Fit wishes to write to HealthKit.
//- (NSSet *)dataTypesToWrite {
//}

// Returns the types of data that Fit wishes to read from HealthKit.
- (NSSet *)dataTypesToRead {
    HKQuantityType *dietaryCalorieEnergyType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount];
    HKQuantityType *activeEnergyBurnType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDistanceWalkingRunning];
    HKQuantityType *heightType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierHeight];
    HKQuantityType *weightType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierBodyMass];
    HKQuantityType *energy = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierBasalEnergyBurned];
    HKQuantityType *hr = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierHeartRate];
    HKQuantityType *temp = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierBodyTemperature];
    HKQuantityType *breath = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierRespiratoryRate];
    HKCategoryType *sleep = [HKCategoryType categoryTypeForIdentifier:HKCategoryTypeIdentifierSleepAnalysis];
    HKCharacteristicType *dob = [HKCharacteristicType characteristicTypeForIdentifier:HKCharacteristicTypeIdentifierDateOfBirth];
    HKCharacteristicType *biologicalSexType = [HKObjectType characteristicTypeForIdentifier:HKCharacteristicTypeIdentifierBiologicalSex];

    return [NSSet setWithObjects:dietaryCalorieEnergyType, activeEnergyBurnType, heightType, weightType, energy, hr, temp, breath, sleep, dob, biologicalSexType, nil];
}


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SPSTrendViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    [cell setType:indexPath.row];
    [cell setGraphDataSource:self];
    cell.headerText = [[SPSTrendDataManager data] headerForGraph:indexPath.row];
    cell.summaryText = [[SPSTrendDataManager data] summaryForGraph:indexPath.row];
    return cell;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return SPSGraphCount;
}

-(CGFloat)valueForGraph:(SPSGraphType)type atXValue:(NSInteger)x
{
    x = [self numberOfPointsForType:type] - x - 1;
    switch (type) {
        case SPSGraphTypeActivity:
            return [[SPSTrendDataManager data] activityValueForIndex:x];
        case SPSGraphTypeSleep:
            return [[SPSTrendDataManager data] sleepValueForIndex:x];
        case SPSGraphTypeHR:
            return [[SPSTrendDataManager data] heartRateValueForIndex:x];
        default:
            return 0;
    }
}

-(NSInteger)numberOfPointsForType:(SPSGraphType)type
{
    switch (type) {
        case SPSGraphTypeActivity:
            return 7;
        case SPSGraphTypeSleep:
            return 7;
        case SPSGraphTypeHR:
            return [[SPSTrendDataManager data] heartRateCount];
        default:
            return 0;
    }
}

@end
