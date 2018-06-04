//
//  ThirdViewController.m
//  LoginBoardDemo
//
//  Created by ChenRongQin on 16/8/8.
//  Copyright © 2016年 Afu. All rights reserved.
//

#import "ThirdViewController.h"

#import "FourthViewController.h"

@interface ThirdViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong)NSMutableArray *listArray;

@end

@implementation ThirdViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self setUpNav];
    self.listArray = [NSMutableArray arrayWithCapacity:10];
    [self.listArray addObjectsFromArray:[UIFont familyNames]];
    self.headBtn.hidden = YES;
    self.textFieldToBtnHeightConstraint.constant = - (self.headBtn.frame.size.height);
    CGFloat height = self.headView.frame.size.height - 30-18;
    CGRect rect = {{self.headView.frame.origin.x, self.headView.frame.origin.y}, {self.headView.frame.size.width, height}};
    self.headView.frame = rect;
    NSLog(@"rect:%@", NSStringFromCGRect(self.headView.frame));
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return self.listArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;  //3333
{
    //    静态标识符
    static NSString *cellIdentifier = @"myCell";
    
    //    dequeueReusableCellWithIdentifier 检测是否有空闲的单元格
    UITableViewCell *tabCell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (tabCell == nil)
    {
        tabCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    // Marion         Gill Sans
    NSString *nameStr = [self.listArray objectAtIndex:indexPath.row];
    tabCell.textLabel.text = nameStr;
    tabCell.textLabel.font = [UIFont fontWithName:nameStr size:16.0];
    return tabCell;
}

- (void)setUpNav
{
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectZero];
    label.text = @"3";
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont boldSystemFontOfSize:17.f];
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor blackColor];
    [label sizeToFit];
    self.navigationItem.titleView = label;
    
    UIButton *nextBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 44, 60)];
    [nextBtn setTitle:@"下一页" forState:UIControlStateNormal];
    [nextBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    nextBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [nextBtn addTarget:self action:@selector(nextBtnClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *nextBtnBar =[[UIBarButtonItem alloc] initWithCustomView:nextBtn];
    
    self.navigationItem.rightBarButtonItem = nextBtnBar;
}

- (void)nextBtnClick;
{
    FourthViewController *fourthVC = [[FourthViewController alloc] init];
    [self.navigationController pushViewController:fourthVC animated:YES];
}

@end
