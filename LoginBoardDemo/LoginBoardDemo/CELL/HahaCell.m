//
//  HahaCell.m
//  CellAutoHeightDemo
//
//  Created by ChenRongQin on 16/7/19.
//  Copyright © 2016年 XYC. All rights reserved.
//

#import "HahaCell.h"

#import "TwoCell.h"

@implementation HahaCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    // Initialization code
//    NSLog(@"haha");
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)setUpDatas:(NSDictionary *)dict;
{
    //array
    self.array = [NSMutableArray arrayWithArray:dict[@"array"]];
    
    
    self.myImageView.image = [UIImage imageNamed:dict[@"image"]];
    
    self.titleLabel.text = dict[@"title"];
    
    self.descriptionLabel.text = dict[@"description"];
    
    NSString *image2Str = dict[@"image2"];
    
    if (image2Str.length > 0)
    {
        self.myImageView2.image = [UIImage imageNamed:dict[@"image2"]];
        self.imageView2Height.constant = 80;
    }
    
    else
    {
        self.imageView2Height.constant = 0;
    }
    
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;

    [self.tableView reloadData];
    self.tableViewHeightConstraint.constant = self.tableView.contentSize.height;
}


#pragma mark-UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return self.array.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    static NSString *cellIdentifier = @"TwoCell";
    TwoCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell==nil)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"TwoCell" owner:self options:nil] lastObject];
    }
    
    NSString *str = self.array[indexPath.row];
    [cell setUpDatas:str];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
    NSLog(@"row:%ld", indexPath.row);
}

@end
