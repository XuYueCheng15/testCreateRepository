//
//  MMGridViewBtnCell.h
//  Putian Mobile
//
//  Created by Lai Fenghai on 14-7-2.
//  Copyright (c) 2014年 Lai fenghai. All rights reserved.
//

#import "MMGridViewCell.h"

@interface MMGridViewBtnCell : MMGridViewCell{
    UIView *bg;
    UILabel *staticLab;
    UILabel *descLab;
}
@property (nonatomic, retain) UIView *bg;
@property (nonatomic, retain) UILabel *staticLab;
@property (nonatomic, retain) UILabel *descLab;
@property (nonatomic, strong) UIImageView *smallIcon;
@property (nonatomic, assign) BOOL isShowLogo;

@end
