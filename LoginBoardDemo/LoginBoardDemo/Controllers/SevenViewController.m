//
//  SevenViewController.m
//  LoginBoardDemo
//
//  Created by ChenRongQin on 16/8/22.
//  Copyright © 2016年 Afu. All rights reserved.
//

#import "SevenViewController.h"

#import "HMSegmentedControl.h"

@interface SevenViewController ()

@end

@implementation SevenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    HMSegmentedControl *segmentedControl = [[HMSegmentedControl alloc] initWithSectionTitles:@[@"我的帖子", @"我的回复123456", @"回复我的",  @"体育明星" ,  @"天气预报",  @"服装设计"]];
    
    [self.view addSubview:segmentedControl];
    
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
    
    segmentedControl.frame = CGRectMake(0, 100, SCREEN_WIDTH, 40);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
