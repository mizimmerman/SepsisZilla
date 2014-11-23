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
        
        UIImageView *backgroundImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width,self.frame.size.height)];
        UIImage *image = [UIImage imageNamed:@"bluefadetowhite"];
        [backgroundImage setImage:image];
        [self addSubview:backgroundImage];
        //[self setBackgroundColor:[UIColor colorWithRed:(40/255.0) green:(179/255.0) blue:(230/255.0) alpha:1]];
        
        self.headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, 0, 200, 100)];
        [self.headerLabel setText:@"Sleep Cycles"];
        [self.headerLabel setTextAlignment:NSTextAlignmentCenter];
        [self.headerLabel setTextColor:[UIColor blackColor]];
        [self addSubview:self.headerLabel];
        
        self.graphView = [[SPSGraphView alloc] initWithFrame:CGRectMake(30, 80, 290, 200)];
//        [self.graphView setType:SPSGraphTypeHR];
        [self addSubview:self.graphView];
        
        self.summaryLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 200, 290, 400)];
        [self.summaryLabel setText:@"Your sleep cycles have changed by..."];
        [self.summaryLabel setTextAlignment:NSTextAlignmentLeft];
        [self.summaryLabel setTextColor:[UIColor blackColor]];
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
