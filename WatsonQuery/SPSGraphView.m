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
        BEMSimpleLineGraphView *graph = [[BEMSimpleLineGraphView alloc] initWithFrame:self.frame];
        [graph setBackgroundColor:[UIColor redColor]];
        [graph setDataSource:self];
        [graph setDelegate:self];
        graph.colorBackgroundXaxis = [UIColor greenColor];
        graph.colorBottom = [UIColor greenColor];
        graph.colorXaxisLabel = [UIColor greenColor];
        graph.colorYaxisLabel = [UIColor greenColor];
        [graph reloadGraph];
        [self addSubview:graph];
    }
    return self;
}

-(NSInteger)numberOfGapsBetweenLabelsOnLineGraph:(BEMSimpleLineGraphView *)graph
{
    return 2;
}

-(BOOL)lineGraph:(BEMSimpleLineGraphView *)graph alwaysDisplayPopUpAtIndex:(CGFloat)index
{
    return YES;
    
}

-(CGFloat)lineGraph:(BEMSimpleLineGraphView *)graph valueForPointAtIndex:(NSInteger)index
{
    return 100 % rand();
}

-(NSInteger)numberOfPointsInLineGraph:(BEMSimpleLineGraphView *)graph
{
    return 30;
}


@end
