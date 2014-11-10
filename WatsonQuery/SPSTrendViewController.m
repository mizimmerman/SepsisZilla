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

@interface SPSTrendViewController () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic) UICollectionView *trendsCV;
@property (nonatomic) SPSTrendLayout *layout;
@end

@implementation SPSTrendViewController

- (id)init {
    self = [super init];
    if (self) {
        [self setTitle:@"Trends"];
    }
    return self;
}

-(void)loadView {
    [super loadView];
    [self loadTrendsCV];
}

-(void)loadTrendsCV {
    self.layout = [SPSTrendLayout new];
    [self.layout setItemSize:CGSizeMake(self.view.frame.size.width-20, self.view.frame.size.height-50)];
    self.trendsCV = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:self.layout];
    [self.trendsCV setDelegate:self];
    [self.trendsCV setDataSource:self];
    [self.trendsCV registerClass:[SPSTrendViewCell class] forCellWithReuseIdentifier:@"Cell"];
    [self.trendsCV setBackgroundColor:[UIColor whiteColor]];
    [self.trendsCV setContentOffset:CGPointMake(-20, 0)];
    [self.view addSubview:self.trendsCV];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    SPSTrendViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    return cell;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [SPSTrendDataManager data].trendsCount;
}

@end
