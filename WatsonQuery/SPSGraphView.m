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
        
        [self.graph setColorLine:[UIColor blackColor]];//colorWithRed:(40/255.0) green:(179/255.0) blue:(230/255.0) alpha:1]];
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
    return 0;
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

- (NSString *)lineGraph:(BEMSimpleLineGraphView *)graph labelOnXAxisForIndex:(NSInteger)index {
    NSString *label;
    
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *comps = [gregorian components:NSWeekdayCalendarUnit fromDate:[NSDate date]];
    int day = [comps weekday];
    
    if (self.type == SPSGraphTypeActivity || self.type == SPSGraphTypeSleep) {
        switch (index) {
            case 0:
                if (day-6 < 1)
                    day += 7;
                label = [self weekday:day-6];
                break;
            case 1:
                if (day-5 < 1)
                    day += 7;
                label = [self weekday:day-5];
                break;
            case 2:
                if (day-4 < 1)
                    day += 7;
                label = [self weekday:day-4];
                break;
            case 3:
                if (day-3 < 1)
                    day += 7;
                label = [self weekday:day-3];
                break;
            case 4:
                if (day-2 < 1)
                    day += 7;
                label = [self weekday:day-2];
                break;
            case 5:
                if (day-1 < 1)
                    day += 7;
                label = [self weekday:day-1];
                break;
            case 6:
                label = [self weekday:day];
                break;
            
            default:
                label = @"";
                break;
        }
    }
    else {
        label = @"";
    }
    return label;
}

- (NSInteger)numberOfYAxisLabelsOnLineGraph:(BEMSimpleLineGraphView *)graph {
    return 6;
}

- (NSString*)weekday:(int)day
{
    NSString *label;
    switch (day) {
        case 2:
            label = @"Mon";
            break;
        case 3:
            label = @"Tue";
            break;
        case 4:
            label = @"Wed";
            break;
        case 5:
            label = @"Thu";
            break;
        case 6:
            label = @"Fri";
            break;
        case 7:
            label = @"Sat";
            break;
        case 1:
            label = @"Sun";
            break;
            
        default:
            label = @"";
            break;
    }
    return label;
}

@end
