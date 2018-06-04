//
//  FirstViewController.m
//  LoginBoardDemo
//
//  Created by 林启源 on 16/8/6.
//  Copyright © 2016年 Afu. All rights reserved.
//

/*
 
 添加照片浏览器这个第三方，要在PCH文件中加入#import <UIKit/UIKit.h>
 
 */

#import "FirstViewController.h"

#import "SecondViewController.h"

#import "MWPhotoBrowser.h"

#import "MBProgressHUD.h"

#import "DVSwitch.h"

@interface FirstViewController ()<MWPhotoBrowserDelegate>

@property (nonatomic, strong)NSMutableArray *photoArray;

@property (nonatomic, strong)MBProgressHUD *hud;

@property (nonatomic, strong)DVSwitch *sc;

@property (weak, nonatomic) IBOutlet UIButton *registerBtn;


@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.registerBtn.alpha = 0;
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self setUpNav];
//    self.loginBtnHeightConstraint.constant = 0;
//    self.loginBtn.hidden = YES;
    
    self.photoArray = [NSMutableArray arrayWithCapacity:10];
    for (int i=0; i<10; i++)
    {
        [self.photoArray addObject:[NSString stringWithFormat:@"https://s3.amazonaws.com/fast-image-cache/demo-images/FICDDemoImage%03d.jpg", i]];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)callAction:(UIButton *)sender
{
    NSString *telNumber = [NSString stringWithFormat:@"tel:%@",@"0592-7279722"];
    UIWebView*callWebview =[[UIWebView alloc] init];
    NSURL *telURL =[NSURL URLWithString:telNumber];
    [callWebview loadRequest:[NSURLRequest requestWithURL:telURL]];
    //记得添加到view上
    [self.view addSubview:callWebview];
}

- (void)setUpNav
{
    self.sc = [DVSwitch switchWithStringsArray:@[@"聚焦", @"见闻", @"行摄",@"美食"]];
    self.sc.frame = CGRectMake(0, 0, self.view.frame.size.width - 20 * 2, 30);
    self.sc.font = [UIFont boldSystemFontOfSize:17];
    self.sc.backgroundColor = [UIColor clearColor];
    self.sc.sliderColor = [UIColor whiteColor];
    self.sc.labelTextColorInsideSlider = RGBA(61, 153, 223, 1);
    self.sc.labelTextColorOutsideSlider = [UIColor whiteColor];
    self.sc.cornerRadius = 3.0;
    [self.sc setPressedHandler:^(NSUInteger index)
    {
        NSLog(@"index:%ld", index);
    }];
    self.navigationItem.titleView = self.sc;
//    UILabel *label = [[UILabel alloc]initWithFrame:CGRectZero];
//    label.text = @"1";
//    label.textAlignment = NSTextAlignmentCenter;
//    label.font = [UIFont boldSystemFontOfSize:17.f];
//    label.backgroundColor = [UIColor clearColor];
//    label.textColor = [UIColor blackColor];
//    [label sizeToFit];
//    self.navigationItem.titleView = label;
    
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
    SecondViewController *secondVC = [[SecondViewController alloc] init];
    secondVC.loginSuccessBlock = ^(id params)
    {
        NSLog(@"params:%@", params);
        
    };
    [self.navigationController pushViewController:secondVC animated:YES];
}


- (IBAction)presentAction:(UIButton *)sender
{
    MWPhotoBrowser *browser = [[MWPhotoBrowser alloc] initWithDelegate:self];
    browser.displayActionButton = YES;
    browser.displayNavArrows = YES;
    browser.displaySelectionButtons = NO;
    browser.alwaysShowControls = NO;
    browser.zoomPhotosToFill = YES;
    browser.enableGrid = NO;
    browser.startOnGrid = NO;
    browser.enableSwipeToDismiss = NO;
    [browser setCurrentPhotoIndex:3];
    
    UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:browser];
    nc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:nc animated:YES completion:nil];
}

#pragma mark - MWPhotoBrowserDelegate
- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser
{
    return self.photoArray.count;
}

- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index
{
    return [MWPhoto photoWithURL:[NSURL URLWithString:[self.photoArray objectAtIndex:index]]];
}



- (IBAction)showNormalTextAction:(UIButton *)sender
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    hud.mode = MBProgressHUDModeCustomView;
    hud.detailsLabelText = @"请输入正确的联系电话！";
    [hud hide:YES afterDelay:2.0];
}

- (IBAction)zhuanQuanAction:(UIButton *)sender
{
    if (self.hud)
    {
        [self.hud removeFromSuperview];
    }
    
    self.hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    self.hud.detailsLabelText = @"正在保存...";
    [self performSelector:@selector(networkEndAction:) withObject:nil afterDelay:5];
}

- (IBAction)networkEndAction:(UIButton *)sender
{
//    self.hud.mode = MBProgressHUDModeCustomView;
//    self.hud.detailsLabelText = @"保存成功";
//    [self.hud hide:YES afterDelay:2.0];
    
    self.hud.mode = MBProgressHUDModeCustomView;
    self.hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"wrong.png"]];
    self.hud.detailsLabelText = @"清除失败";
    [self.hud hide:YES afterDelay:2.0];
}

- (IBAction)updateVersionAction:(UIButton *)sender
{
//    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"itms://itunes.apple.com/gb/app/yi-dong-cai-bian/id391945719?mt=8"]];
    
    //莆田移动
    int appid = 847276886;
    NSString *str = [NSString stringWithFormat:@"http://itunes.apple.com/us/app/id%d",appid];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
}

- (IBAction)registerAction:(UIButton *)sender
{
    NSLog(@"registerAction");
}


@end
