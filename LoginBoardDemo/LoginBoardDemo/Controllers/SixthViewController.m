//
//  FirstViewController.m
//  CellAutoHeightDemo
//
//  Created by ChenRongQin on 16/7/19.
//  Copyright © 2016年 XYC. All rights reserved.
//

#import "SixthViewController.h"

#import "HahaCell.h"

@interface SixthViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;//2
@property (nonatomic, strong)NSMutableArray *listArray;

@end

@implementation SixthViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setUpNav];
    //预计高度为81
    self.tableView.estimatedRowHeight = 44.0f;
    
    //自适应高度
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.listArray = [NSMutableArray array];
//    self.imageView.image = [UIImage imageNamed:dict[@"image"]];
//    
//    self.titleLabel.text = dict[@"title"];
//    
//    self.descriptionLabel.text = dict[@"description"];
    NSDictionary *dict0 =  @{@"image":@"guidePage1",
                             @"title":@"1",
                             @"description":@"2015年6月16日 - CocoaChina » iOS开发 » 求助 关于ios8 tableViewCell 自动化适应高度的...完全没有问题的,你刷新一下表",
                             @"image2":@"",
                             @"array":@[]
                             };
    NSDictionary *dict1 =  @{@"image":@"guidePage2",
                             @"title":@"2",
                             @"description":@"222",
                             @"image2":@"guidePage2",
                             @"array":@[@"a"]
                             };
    NSDictionary *dict2 =  @{@"image":@"guidePage3",
                             @"title":@"3",
                             @"description":@"实现这个效果，我除了设置了 autoLayout，还设置了 tableView 的 rowHeight = UITableViewAutomaticDimension，然后就是这样了。一点计算 cell 高度的代码都没有！！我连 heightForRowAtIndexPath都不用实现，真的是爽出味啊！所以如果已经在开发 iOS 8 Only 的应用了一定要用autolayout，把烦人的计算交给 autolayout 去吧。",
                             @"image2":@"",
                             @"array":@[@"1", @"2", @"3",@"4", @"5", @"6"]
                             };
    [self.listArray addObject:dict0];
    [self.listArray addObject:dict1];
    [self.listArray addObject:dict2];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return self.listArray.count;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
//{
//    return 10;
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    static NSString *cellIdentifier = @"HahaCell";
    HahaCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell==nil)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"HahaCell" owner:self options:nil] lastObject];
    }
    
    //设置选中没有颜色显示
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    NSDictionary *dict = self.listArray[indexPath.row];
    [cell setUpDatas:dict];
    
    return cell;
}

- (void)setUpNav
{
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectZero];
    label.text = @"6";
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont boldSystemFontOfSize:17.f];
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor blackColor];
    [label sizeToFit];
    self.navigationItem.titleView = label;
}

@end
