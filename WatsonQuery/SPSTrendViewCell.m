//
//  SPSTrendViewCell.m
//  WatsonQuery
//
//  Created by gazevedo on 11/10/14.
//  Copyright (c) 2014 EECS 481. All rights reserved.
//

#import "SPSTrendViewCell.h"
#import "SPSGraphView.h"

@interface SPSTrendViewCell ()

@property (nonatomic) SPSGraphView *graphView;
@property (nonatomic) UILabel *headerLabel;
@property (nonatomic) UILabel *summaryLabel;

@end

@implementation SPSTrendViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor whiteColor]];
        
        self.headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 20, 200, 100)];
        [self.headerLabel setText:@"Sleep Cycles"];
        [self.headerLabel setTextAlignment:NSTextAlignmentCenter];
        [self.headerLabel setTextColor:[UIColor darkGrayColor]];
        [self addSubview:self.headerLabel];
        
        self.graphView = [[SPSGraphView alloc] initWithFrame:CGRectMake(50, 120, 200, 150)];
//        [self.graphView setType:SPSGraphTypeHR];
        [self addSubview:self.graphView];
        
        self.summaryLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 290, 200, 200)];
        [self.summaryLabel setText:@"Your sleep cycles have changed by..."];
        [self.summaryLabel setTextAlignment:NSTextAlignmentCenter];
        [self.summaryLabel setTextColor:[UIColor darkGrayColor]];
        [self.summaryLabel setNumberOfLines:10];
        [self addSubview:self.summaryLabel];        
    }
    return self;
}

-(void)setHeaderText:(NSString *)headerText
{
    [self.headerLabel setText:headerText];
}

-(void)setSummaryText:(NSString *)summaryText
{
    [self.summaryLabel setText:summaryText];
}

-(void)setGraphDataSource:(id<SPSGraphDataSource>)dataSource
{
    [self.graphView setDataSource:dataSource];
}

-(void)setType:(SPSGraphType)type
{
    [self.graphView setType:type];
}

@end
