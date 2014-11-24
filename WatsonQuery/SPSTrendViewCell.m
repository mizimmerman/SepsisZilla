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
        
        self.headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, 0, 200, 100)];
        [self.headerLabel setText:@"Sleep Cycles"];
        [self.headerLabel setTextAlignment:NSTextAlignmentCenter];
        [self.headerLabel setTextColor:[UIColor blackColor]];
        [self addSubview:self.headerLabel];
        
        self.graphView = [[SPSGraphView alloc] initWithFrame:CGRectMake(30, 80, self.frame.size.width-60, 200)];
        [self addSubview:self.graphView];
        
        self.summaryLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 220, self.frame.size.width-60, 400)];
        [self.summaryLabel setText:@"Your sleep cycles have changed by..."];
        [self.summaryLabel setTextAlignment:NSTextAlignmentLeft];
        [self.summaryLabel setTextColor:[UIColor blackColor]];
        [self.summaryLabel setNumberOfLines:20];
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
