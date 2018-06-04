//
//  PrimerateImgViewController.h
//  Putian Mobile
//
//  Created by Lai Fenghai on 14-1-8.
//  Copyright (c) 2014年 Lai fenghai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XLCycleScrollView.h"
#import "UIImageView+WebCache.h"

@interface PrimerateImgViewController : UIViewController <XLCycleScrollViewDatasource>

@property (nonatomic, retain) UIView *middleView;
@property (nonatomic, assign) NSUInteger photoCount;
@property (nonatomic, assign) NSUInteger changeCount;
@property (nonatomic, retain) XLCycleScrollView *csView;
@property (nonatomic, retain) NSArray *photoUrlAry;
@property (nonatomic, retain) UIImageView *imgv;
@property (nonatomic, retain) UILabel *descLabel;
@property (nonatomic, retain) NSString *changeCountStr;

@end
