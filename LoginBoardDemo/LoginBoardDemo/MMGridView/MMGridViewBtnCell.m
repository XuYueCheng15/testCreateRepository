//
//  MMGridViewBtnCell.m
//  Putian Mobile
//
//  Created by Lai Fenghai on 14-7-2.
//  Copyright (c) 2014年 Lai fenghai. All rights reserved.
//

#import "MMGridViewBtnCell.h"

@implementation MMGridViewBtnCell

@synthesize bg;
@synthesize descLab;
@synthesize staticLab;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.bg = [[UIView alloc] initWithFrame:CGRectNull];
        self.bg.layer.borderWidth=0.5f;
        self.bg.layer.borderColor=[[UIColor colorWithRed:204/255.0f green:204/255.0f blue:204/255.0f alpha:1] CGColor];
        self.bg.backgroundColor = [UIColor colorWithRed:233/255.f green:233/255.f blue:233/255.f alpha:1];
        [self addSubview:self.bg];
        
        self.staticLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 90, 20)];
        self.staticLab.textColor = [UIColor colorWithRed:103/255.f green:103/255.f blue:103/255.f alpha:1];
        self.staticLab.textAlignment = NSTextAlignmentCenter;
        self.staticLab.font = [UIFont systemFontOfSize:12.f];
        [self.bg addSubview:self.staticLab];
        
        self.descLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, 90, 20)];
        self.descLab.textAlignment = NSTextAlignmentCenter;
        self.descLab.font = [UIFont systemFontOfSize:12.f];
        self.descLab.textColor = [UIColor colorWithRed:103/255.f green:103/255.f blue:103/255.f alpha:1];
        [self.bg addSubview:self.descLab];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(cellClick)
                                                     name:@"MMGridViewBtnCell"
                                                   object:nil];
        self.smallIcon = [[UIImageView alloc]initWithFrame:CGRectMake(90-15, 0, 15, 15)];
        self.smallIcon.image = [UIImage imageNamed:@"huibibang_youshangjiao"];
        self.smallIcon.hidden = YES;
        [self.bg addSubview:self.smallIcon];
    }
    return self;
}

- (void)cellClick
{
    self.smallIcon.hidden = NO;
    self.bg.layer.borderColor=[[UIColor colorWithRed:204/255.0f green:204/255.0f blue:204/255.0f alpha:1] CGColor];
    self.descLab.textColor = [UIColor colorWithRed:103/255.f green:103/255.f blue:103/255.f alpha:1];
    self.staticLab.textColor = [UIColor colorWithRed:103/255.f green:103/255.f blue:103/255.f alpha:1];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    if (self.isShowLogo) {
        self.smallIcon.hidden = NO;
    }else {
        self.smallIcon.hidden = YES;
    }
    int inset = 0;
    CGRect f = CGRectMake(0, 0, self.bg.superview.bounds.size.width, self.bg.superview.bounds.size.height);
    self.bg.frame = CGRectInset(f, inset, 0);
    self.bg.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
}

@end
