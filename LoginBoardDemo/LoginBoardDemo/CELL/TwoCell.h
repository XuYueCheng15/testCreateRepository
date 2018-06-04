//
//  TwoCell.h
//  CellAutoHeightDemo
//
//  Created by ChenRongQin on 16/8/9.
//  Copyright © 2016年 XYC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TwoCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *label;

- (void)setUpDatas:(NSString *)titleStr;

@end
