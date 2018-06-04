//
//  SecondViewController.m
//  LoginBoardDemo
//
//  Created by 林启源 on 16/8/6.
//  Copyright © 2016年 Afu. All rights reserved.
//


#import "SecondViewController.h"

#import "ThirdViewController.h"

#import "HMSegmentedControl.h"

#import "JGActionSheet.h"

#import "UIImage+ImageWithColor.h"

@interface SecondViewController ()

@property (weak, nonatomic) IBOutlet UIView *headView;

@property (nonatomic, strong)JGActionSheet *sheet;;

@end

@implementation SecondViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setUpNav];
    [self setUpTab];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setUpTab
{
    HMSegmentedControl *segmentedControl = [[HMSegmentedControl alloc] initWithSectionTitles:@[@"我的帖子", @"我的回复123456", @"回复我的",  @"体育明星" ,  @"天气预报",  @"服装设计"]];
    
    [self.headView addSubview:segmentedControl];
    
    segmentedControl.layer.borderWidth=0.5f;
    segmentedControl.layer.borderColor=[[UIColor colorWithRed:204/255.0f green:204/255.0f blue:204/255.0f alpha:1] CGColor];
    [segmentedControl setIndexChangeBlock:^(NSInteger index)
    {
        NSLog(@"index:%ld", index);
    }];
    [segmentedControl setSelectionIndicatorHeight:2.0f];
    [segmentedControl setBackgroundColor:[UIColor whiteColor]];
    [segmentedControl setTextColor:[UIColor colorWithRed:51/255.f green:51/255.f blue:51/255.f alpha:1]];
    [segmentedControl setFont:[UIFont systemFontOfSize:15.f]];
    [segmentedControl setSelectedTextColor:[UIColor colorWithRed:61/255.f green:153/255.f blue:223/255.f alpha:1]];
    [segmentedControl setSelectionIndicatorColor:[UIColor colorWithRed:61/255.f green:153/255.f blue:223/255.f alpha:1]];
    [segmentedControl setSelectionStyle:HMSegmentedControlSelectionStyleFullWidthStripe];
    [segmentedControl setSelectedSegmentIndex:0];
    [segmentedControl setSelectionIndicatorLocation:HMSegmentedControlSelectionIndicatorLocationDown];
    segmentedControl.scrollEnabled = YES;

    segmentedControl.frame = self.headView.bounds;

}

- (void)setUpNav
{
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)])
    {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectZero];
    label.text = @"2";
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont boldSystemFontOfSize:17.f];
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor blackColor];
    [label sizeToFit];
    self.navigationItem.titleView = label;
    
    UIButton *shareBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    [shareBtn setTitle:@"分享" forState:UIControlStateNormal];
    [shareBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    shareBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [shareBtn addTarget:self action:@selector(tttt) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *shareBar =[[UIBarButtonItem alloc] initWithCustomView:shareBtn];
    
    UIButton *nextBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 44, 60)];
    [nextBtn setTitle:@"下一页" forState:UIControlStateNormal];
    [nextBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    nextBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [nextBtn addTarget:self action:@selector(nextBtnClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *nextBtnBar =[[UIBarButtonItem alloc] initWithCustomView:nextBtn];
    
    self.navigationItem.rightBarButtonItems = @[nextBtnBar, shareBar];
}

- (void)shareBtnClick;
{
    NSArray *shareTextAry = [NSArray arrayWithObjects:@"朋友圈",@"微信",@"新浪微博",@"腾讯微博"/*,@"短信"*/, nil];
    CGFloat width = (SCREEN_WIDTH-30)/shareTextAry.count;
    CGFloat height = 60;
    CGFloat margin = 0;
    UIView *shareView=[[UIView alloc]initWithFrame:CGRectMake(0, 12+21, SCREEN_WIDTH-30, height)];
    for (NSUInteger i = 0; i < [shareTextAry count]; i++)
    {
        UIView *v = [[UIView alloc]initWithFrame:CGRectMake(width*i+margin*i, 0, width, height)];
        v.backgroundColor = [UIColor clearColor];
//        if (i == 0||i==4)
//        {
//            v.backgroundColor = [UIColor redColor];
//        }
//        
//        if (i == 1||i==3)
//        {
//            v.backgroundColor = [UIColor yellowColor];
//        }
//        
//        if (i == 2)
//        {
//            v.backgroundColor = [UIColor purpleColor];
//        }
        
        
        [shareView addSubview:v];
        
        NSString *imageName = [NSString stringWithFormat:@"shareIcon%lu",(unsigned long)i];
        UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(width/2-20, 0, 40, 40)];
        img.image = [UIImage imageNamed:imageName];
        
        
        UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(0, height-21, width, 21)];
        lab.font = [UIFont systemFontOfSize:10];
        lab.textColor = RGBA(51, 51, 51, 1);
        lab.backgroundColor = [UIColor clearColor];
        lab.textAlignment = NSTextAlignmentCenter;
        lab.text = shareTextAry[i];
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = i;
        btn.frame = CGRectMake(0, 0, width, height);
        [btn addTarget:self action:@selector(shareOnClick:) forControlEvents:UIControlEventTouchUpInside];
        [v addSubview:img];
        [v addSubview:lab];
        [v addSubview:btn];
    }
    
    UIButton *btn3 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn3 setTitle:@"取消" forState:UIControlStateNormal];
    [btn3 setTitleColor:RGBA(255, 100, 15, 1) forState:UIControlStateNormal];
    [btn3 setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithWhite:0.9f alpha:1.0f]] forState:UIControlStateHighlighted];
    btn3.tag = 100;
    [btn3 addTarget:self action:@selector(shareOnClick:) forControlEvents:UIControlEventTouchUpInside];
    btn3.frame = CGRectMake(0, 0, SCREEN_WIDTH-30, 40);
    
    JGActionSheetSection *section1 = [JGActionSheetSection sectionWithTitle:@"分享到" message:nil contentView:shareView];
    JGActionSheetSection *section2 = [JGActionSheetSection sectionWithTitle:nil message:nil contentView:btn3];
    
    NSArray *sections = (@[section1, section2]);
    
    if (self.sheet)
    {
        for (id obj in self.sheet.subviews)
        {
            [obj removeFromSuperview];
        }
        self.sheet = nil;
    }
    
    self.sheet = [[JGActionSheet alloc] initWithSections:sections];
    [self.sheet showInView:[UIApplication sharedApplication].keyWindow animated:YES];
}

- (void)tttt;
{
    UIView *middleView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-30, 88)];
    middleView.backgroundColor = [UIColor clearColor];
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];

    [btn1 setTitle:@"收藏" forState:UIControlStateNormal];

    [btn1 setTitleColor:RGBA(61, 154, 224, 1) forState:UIControlStateNormal];
    [btn1 setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithWhite:0.9f alpha:1.0f]] forState:UIControlStateHighlighted];
    btn1.tag = 101;
    [btn1 addTarget:self action:@selector(shareOnClick:) forControlEvents:UIControlEventTouchUpInside];
    btn1.frame = CGRectMake(0, 0, SCREEN_WIDTH-30, 44);
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn2 setTitle:@"举报" forState:UIControlStateNormal];
    [btn2 setTitleColor:RGBA(61, 154, 224, 1) forState:UIControlStateNormal];
    [btn2 setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithWhite:0.9f alpha:1.0f]] forState:UIControlStateHighlighted];
    btn2.tag = 102;
    [btn2 addTarget:self action:@selector(shareOnClick:) forControlEvents:UIControlEventTouchUpInside];
    btn2.frame = CGRectMake(0, 44, SCREEN_WIDTH-30, 44);
    
    UIImageView *line = [[UIImageView alloc]initWithFrame:CGRectMake(0, 44, SCREEN_WIDTH-30, 0.5)];
    line.backgroundColor = RGBA(221, 221, 221, 1);
    
    [middleView addSubview:btn1];
    [middleView addSubview:btn2];
    [middleView addSubview:line];
    
    UIButton *btn3 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn3 setTitle:@"取消" forState:UIControlStateNormal];
    [btn3 setTitleColor:RGBA(255, 100, 15, 1) forState:UIControlStateNormal];
    [btn3 setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithWhite:0.9f alpha:1.0f]] forState:UIControlStateHighlighted];
    btn3.tag = 103;
    [btn3 addTarget:self action:@selector(shareOnClick:) forControlEvents:UIControlEventTouchUpInside];
    btn3.frame = CGRectMake(0, 0, SCREEN_WIDTH-30, 44);
    
    JGActionSheetSection *section2 = [JGActionSheetSection sectionWithTitle:nil message:nil contentView:middleView];
    JGActionSheetSection *section3 = [JGActionSheetSection sectionWithTitle:nil message:nil contentView:btn3];
    NSArray *sections = (@[section2, section3]);

    self.sheet = [[JGActionSheet alloc] initWithSections:sections];
    [self.sheet showInView:[UIApplication sharedApplication].keyWindow animated:YES];
}

- (void)shareOnClick:(UIButton *)sender;
{
    NSLog(@"tag:%ld", sender.tag);
    [self.sheet dismissAnimated:YES];
}

- (void)nextBtnClick;
{
    ThirdViewController *thirdVC = [[ThirdViewController alloc] init];
    [self.navigationController pushViewController:thirdVC animated:YES];
}

- (IBAction)backAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
    self.loginSuccessBlock(@"loginSuccessful");
}
@end
