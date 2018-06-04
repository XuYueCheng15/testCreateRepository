//
//  MMGridViewLabelCell.m
//  Putian Mobile
//
//  Created by Lai Fenghai on 14-6-30.
//  Copyright (c) 2014年 Lai fenghai. All rights reserved.
//

#import "MMGridViewLabelCell.h"

@implementation MMGridViewLabelCell

@synthesize textLabel;

- (id)initWithFrame:(CGRect)frame
{
    if ((self = [super initWithFrame:frame])) {
        
        // Label
        self.textLabel = [[UILabel alloc] initWithFrame:CGRectNull];
        self.textLabel.textAlignment = NSTextAlignmentCenter;
        self.textLabel.backgroundColor = [UIColor clearColor];
        self.textLabel.textColor = [UIColor colorWithRed:random()%255/255.f green:random()%230/255.f blue:random()%255/255.f alpha:1];
        self.textLabel.font = [UIFont systemFontOfSize:12];
        self.textLabel.layer.borderWidth=0.5f;
        self.textLabel.layer.borderColor=[[UIColor colorWithRed:204/255.0f green:204/255.0f blue:204/255.0f alpha:1] CGColor];
        [self addSubview:self.textLabel];
    }
    return self;
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    int inset = 0;
    
    // Layout label background
    CGRect f = CGRectMake(0,
                          0,
                          self.textLabel.superview.bounds.size.width,
                          self.textLabel.superview.bounds.size.height);
    self.textLabel.frame = CGRectInset(f, inset, 0);
    self.textLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
}

@end
