//
//  PrimerateImgViewController.m
//  Putian Mobile
//
//  Created by Lai Fenghai on 14-1-8.
//  Copyright (c) 2014年 Lai fenghai. All rights reserved.
//

#import "PrimerateImgViewController.h"

@interface PrimerateImgViewController ()

@end

@implementation PrimerateImgViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    [MobClick beginLogPageView:[NSString stringWithFormat:@"%@",self.class]];
}

- (void)viewWillDisappear:(BOOL)animated {
    
//    [MobClick endLogPageView:[NSString stringWithFormat:@"%@",self.class]];
    [super viewWillDisappear:animated];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    [self setUpNav];

    if (IS_IPHONE_5)
    {
        self.csView = [[XLCycleScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 504)];
        //        csView.delegate = self;
        self.csView.theIndexPage = self.changeCount;
        self.csView.datasource = self;
        self.csView.pageControl.hidden = YES;
        [self.view addSubview:self.csView];
    }
    
    else
    {
        
        self.csView = [[XLCycleScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 416)];
        //        csView.delegate = self;
        self.csView.theIndexPage = self.changeCount;
        self.csView.backgroundColor = [UIColor clearColor];
        self.csView.datasource = self;
        self.csView.pageControl.hidden = YES;
        [self.view addSubview:self.csView];
    }
    
//    self.csView = [[XLCycleScrollView alloc] initWithFrame:[UIScreen mainScreen].bounds];
//    //        csView.delegate = self;
//    self.csView.theIndexPage = self.changeCount;
//    self.csView.datasource = self;
//    self.csView.pageControl.hidden = YES;
//    [self.view addSubview:self.csView];

}

#pragma mark -
#pragma mark - XLCycleScrollViewDatasource
- (NSInteger)numberOfPages
{
    return self.photoUrlAry.count;
}

- (UIView *)pageAtIndex:(NSInteger)index
{
    if (IS_IPHONE_5)
    {
        self.imgv = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-20-44)];
    }
    
    else
    {
        self.imgv = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-20-44)];
    }
    
    
    self.descLabel.textColor = [UIColor whiteColor];
//    self.descLabel.text = descStr;
    self.descLabel.numberOfLines = 0;
    self.descLabel.font = [UIFont systemFontOfSize:12.f];
    self.descLabel.backgroundColor = [UIColor clearColor];
    [self.imgv addSubview:self.descLabel];
    
    self.imgv.contentMode = UIViewContentModeScaleAspectFit;
    
    NSString *url = [self.photoUrlAry objectAtIndex:index];
    
    self.changeCountStr = [NSString stringWithFormat:@"%d",self.csView.currentPage + 1];

    [self.imgv sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"youhui_big.png"]];
    
    [self setUpNav];
    return self.imgv;
}


//- (void)gotoBack
//{
//    
//    [self.navigationController popViewControllerAnimated:YES];
//}

- (void)setUpNav
{
    self.middleView = [[UIView alloc]initWithFrame:CGRectMake(120, 0, 80, 44)];
    self.middleView.backgroundColor = [UIColor clearColor];

    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 80, 44)];
    label.text = [NSString stringWithFormat:@"%@/%lu",self.changeCountStr,(unsigned long)self.photoCount];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont boldSystemFontOfSize:19.f];
    [self.middleView addSubview:label];
    self.navigationItem.titleView = self.middleView;
    
//    UIImage *backBtnImg = [UIImage imageNamed:@"title_icon_back_nor.png"];
//    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    backBtn.frame = CGRectMake(0, 0, 22, 22);
//    [backBtn setImage:backBtnImg forState:UIControlStateNormal];
//    [backBtn addTarget:self action:@selector(gotoBack) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem *leftBar =[[UIBarButtonItem alloc] initWithCustomView:backBtn];
//    self.navigationItem.leftBarButtonItem = leftBar;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
