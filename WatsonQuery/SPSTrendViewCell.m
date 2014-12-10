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
        CGFloat headerSize = 20;
        CGFloat summarySize = 18;
        CGRect headerRect = CGRectMake(0, 10, self.frame.size.width, 100);
        CGRect graphRect = CGRectMake(30, 60, self.frame.size.width-60, 200);
        CGRect sumarryRect = CGRectMake(30, 220, self.frame.size.width-60, 400);
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            headerSize = 40;
            summarySize = 25;
        }

        self.headerLabel = [[UILabel alloc] initWithFrame:headerRect];
        [self.headerLabel setText:@"Sleep Cycles"];
        [self.headerLabel setTextAlignment:NSTextAlignmentCenter];
        [self.headerLabel setTextColor:[UIColor blackColor]];
        [self.headerLabel setFont:[UIFont fontWithName:@"Arial-BoldMT" size:headerSize]];
        [self addSubview:self.headerLabel];
        
        self.graphView = [[SPSGraphView alloc] initWithFrame:graphRect];
        [self addSubview:self.graphView];
        
        self.summaryLabel = [[UILabel alloc] initWithFrame:sumarryRect];
        [self.summaryLabel setText:@"Your sleep cycles have changed by..."];
        [self.summaryLabel setTextAlignment:NSTextAlignmentLeft];
        [self.summaryLabel setTextColor:[UIColor blackColor]];
        [self.summaryLabel setNumberOfLines:20];
        [self.summaryLabel setFont:[UIFont systemFontOfSize:summarySize]];
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
