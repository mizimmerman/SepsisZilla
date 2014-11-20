//
//  SPSCoreDataHelper.m
//  iScore5
//
//  Created by Greg Azevedo on 10/14/14.
//  Copyright (c) 2014 iScore5 LLC. All rights reserved.
//

#import "SPSCoreDataHelper.h"

@interface SPSCoreDataHelper()

@property (nonatomic, readonly) NSPersistentStoreCoordinator *coordinator;
@property (nonatomic, readonly) NSManagedObjectModel *model;
@property (nonatomic, readonly) NSPersistentStore *store;

@end


@implementation SPSCoreDataHelper

+ (SPSCoreDataHelper *)data
{
    static SPSCoreDataHelper *sharedHelper = nil;
    if (!sharedHelper) {
        static dispatch_once_t predicate;
        dispatch_once(&predicate, ^{
            sharedHelper = [self new];
        });
        [sharedHelper setup];
    }
    return sharedHelper;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"SPSModel" ofType:@"momd"];
        NSURL *momURL = [NSURL fileURLWithPath:path];
        
        _model = [[NSManagedObjectModel alloc] initWithContentsOfURL:momURL];
        _coordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:_model];
        _context = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
        [_context setPersistentStoreCoordinator:_coordinator];
        [self setup];
    }
    return self;
}

- (void)setup
{
    [self loadStore];
}

- (void)loadStore
{
    if (!_store) {
        NSString *storeType = NSInMemoryStoreType; //NSSQLiteStoreType
        NSError *error = nil;
        _store = [_coordinator addPersistentStoreWithType:storeType
                                            configuration:nil URL:[self storeURL]
                                                  options:nil error:&error];
        
        if (!_store) {NSLog(@"Failed to add store. Error: %@", error);abort();}
        else { NSLog(@"Successfully added store: %@", _store); }
    }
}

#pragma mark - PATHS

NSString *storeFilename = @"iScore5.sqlite";

- (NSString *)applicationDocumentsDirectory
{
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask,YES) lastObject];
}

- (NSURL *)applicationStoresDirectory {
    NSURL *storesDirectory = [[NSURL fileURLWithPath:[self applicationDocumentsDirectory]]
                              URLByAppendingPathComponent:@"Stores"];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:[storesDirectory path]]) {
        NSError *error = nil;
        if (![fileManager createDirectoryAtURL:storesDirectory
                   withIntermediateDirectories:YES attributes:nil error:&error]) {
            NSLog(@"FAILED to create Stores directory: %@", error);
        }
    }
    return storesDirectory;
}

- (NSURL *)storeURL
{
    return [[self applicationStoresDirectory] URLByAppendingPathComponent:storeFilename];
}

#pragma mark - SAVING

- (void)saveContext
{
    if ([_context hasChanges]) {
        NSError *error = nil;
        if ([_context save:&error]) {
            NSLog(@"_context SAVED changes to persistent store");
        } else {
            NSLog(@"Failed to save _context: %@", error);
        }
    } else {
        NSLog(@"SKIPPED _context save, there are no changes!");
    }
}

@end
