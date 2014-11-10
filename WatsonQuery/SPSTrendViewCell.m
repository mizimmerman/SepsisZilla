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

@end

@implementation SPSTrendViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor blueColor]];
        self.graphView = [SPSGraphView new];
        [self.graphView setFrame:CGRectMake(50, 20, 200, 150)];
        [self addSubview:self.graphView];
    }
    return self;
}

@end
