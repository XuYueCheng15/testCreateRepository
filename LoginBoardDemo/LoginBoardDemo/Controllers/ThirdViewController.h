//
//  ThirdViewController.h
//  LoginBoardDemo
//
//  Created by ChenRongQin on 16/8/8.
//  Copyright © 2016年 Afu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ThirdViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UIView *headView;

@property (weak, nonatomic) IBOutlet UIButton *headBtn;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *textFieldToBtnHeightConstraint;


@end
