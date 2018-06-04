//
//  TwoCell.m
//  CellAutoHeightDemo
//
//  Created by ChenRongQin on 16/8/9.
//  Copyright © 2016年 XYC. All rights reserved.
//

#import "TwoCell.h"

@implementation TwoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setUpDatas:(NSString *)titleStr;
{
    self.label.text = titleStr;
}

@end
