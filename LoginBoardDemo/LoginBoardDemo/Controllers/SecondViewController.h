//
//  SecondViewController.h
//  LoginBoardDemo
//
//  Created by 林启源 on 16/8/6.
//  Copyright © 2016年 Afu. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^secondViewControllerBlock)(id);
@interface SecondViewController : UIViewController

@property(nonatomic,copy)secondViewControllerBlock loginSuccessBlock;

@end
