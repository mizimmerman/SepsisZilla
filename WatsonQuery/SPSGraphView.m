//
//  SPSGraphView.m
//  WatsonQuery
//
//  Created by gazevedo on 11/10/14.
//  Copyright (c) 2014 EECS 481. All rights reserved.
//

#import "SPSGraphView.h"
#import "BEMSimpleLineGraphView.h"

@interface SPSGraphView () <BEMSimpleLineGraphDataSource, BEMSimpleLineGraphDelegate>


@end


@implementation SPSGraphView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setBackgroundColor:[UIColor yellowColor]];
        BEMSimpleLineGraphView *graph = [[BEMSimpleLineGraphView alloc] initWithFrame:self.bounds];
        [graph setDataSource:self];
        [graph setDelegate:self];
        [self addSubview:graph];
    }
    return self;
}

-(NSInteger)numberOfGapsBetweenLabelsOnLineGraph:(BEMSimpleLineGraphView *)graph
{
    return 10;
}

-(BOOL)lineGraph:(BEMSimpleLineGraphView *)graph alwaysDisplayPopUpAtIndex:(CGFloat)index
{
    return YES;
    
}

@end
