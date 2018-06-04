//
//  HahaCell.h
//  CellAutoHeightDemo
//
//  Created by ChenRongQin on 16/7/19.
//  Copyright © 2016年 XYC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HahaCell : UITableViewCell<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UIImageView *myImageView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;

@property (weak, nonatomic) IBOutlet UIImageView *myImageView2;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewHeightConstraint;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageView2Height;

- (void)setUpDatas:(NSDictionary *)dict;

@property (nonatomic, strong)NSMutableArray *array;

@end
