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

@property (nonatomic) BEMSimpleLineGraphView *graph;

@end


@implementation SPSGraphView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.graph = [[BEMSimpleLineGraphView alloc] initWithFrame:self.bounds];
        [self.graph setDataSource:self];
        [self.graph setDelegate:self];
        
        [self.graph setColorLine:[UIColor whiteColor]];
        [self.graph setEnableBezierCurve:YES];
        [self.graph setEnablePopUpReport:YES];
        [self.graph setEnablePopUpReport:YES];
        [self.graph setWidthLine:3];
        [self.graph reloadGraph];
        [self addSubview:self.graph];
    }
    return self;
}

-(void)setDataSource:(id<SPSGraphDataSource>)dataSource
{
    _dataSource = dataSource;
    [self.graph reloadGraph];
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
    return [self.dataSource valueForGraph:self.type atXValue:index];
}

-(NSInteger)numberOfPointsInLineGraph:(BEMSimpleLineGraphView *)graph
{
    return [self.dataSource numberOfPointsForType:self.type];
}

-(NSString *)popUpSuffixForlineGraph:(BEMSimpleLineGraphView *)graph
{
    switch (self.type) {
        case SPSGraphTypeActivity:
            return @" steps";
        case SPSGraphTypeHR:
            return @" bpm";
        case SPSGraphTypeSleep:
            return @" hours";
        default:
            return @"";
    }
}

@end
