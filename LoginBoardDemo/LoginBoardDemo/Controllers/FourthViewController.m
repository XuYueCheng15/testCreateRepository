//
//  FourthViewController.m
//  LoginBoardDemo
//
//  Created by ChenRongQin on 16/8/8.
//  Copyright © 2016年 Afu. All rights reserved.
//

#import "FourthViewController.h"

#import "FifthViewController.h"

#import "SDCycleScrollView.h"

#import "AMRatingControl.h"

@interface FourthViewController ()<SDCycleScrollViewDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *demoContainerView;
@property (nonatomic, strong)SDCycleScrollView *cycleScrollView;

@property (weak, nonatomic) IBOutlet UIButton *headBtn;
@end

@implementation FourthViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // 如果你发现你的CycleScrollview会在viewWillAppear时图片卡在中间位置，你可以调用此方法调整图片位置
    //    [你的CycleScrollview adjustWhenControllerViewWillAppera];
    [self.cycleScrollView adjustWhenControllerViewWillAppera];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self setUpNav];
    // 情景二：采用网络图片实现
    NSArray *imagesURLStrings = @[
                                  @"https://ss2.baidu.com/-vo3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a4b3d7085dee3d6d2293d48b252b5910/0e2442a7d933c89524cd5cd4d51373f0830200ea.jpg",
                                  @"https://ss0.baidu.com/-Po3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a41eb338dd33c895a62bcb3bb72e47c2/5fdf8db1cb134954a2192ccb524e9258d1094a1e.jpg",
                                  @"http://c.hiphotos.baidu.com/image/w%3D400/sign=c2318ff84334970a4773112fa5c8d1c0/b7fd5266d0160924c1fae5ccd60735fae7cd340d.jpg"
                                  ];
    
    // 情景三：图片配文字
    NSArray *titles = @[@"新建交流QQ群：185534916 ",
                        @"感谢您的支持，如果下载的",
                        @"如果代码在使用过程中出现问题",
                        @"您可以发邮件到gsdios@126.com"
                        ];
    
    // 网络加载 --- 创建带标题的图片轮播器
    self.cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:self.demoContainerView.bounds delegate:nil placeholderImage:[UIImage imageNamed:@"placeholder"]];
    
    self.cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    self.cycleScrollView.titlesGroup = titles;
    self.cycleScrollView.currentPageDotColor = [UIColor whiteColor]; // 自定义分页控件小圆标颜色
    self.cycleScrollView.imageURLStringsGroup = imagesURLStrings;
    
    //    //         --- 模拟加载延迟
    //    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^
    //    {
    //        cycleScrollView2.imageURLStringsGroup = imagesURLStrings;
    //    });
    
    
    //block监听点击方式
    
    self.cycleScrollView.clickItemOperationBlock = ^(NSInteger index)
    {
        NSLog(@">>>>>  %ld", (long)index);
    };

    [self.demoContainerView addSubview:self.cycleScrollView];
    
    
    
    
    
    
    
    UIImage *dot, *star;
    dot = [UIImage imageNamed:@"pin_star_nor.png"];
    star = [UIImage imageNamed:@"pin_star_pre.png"];
    AMRatingControl *imagesRatingControl = [[AMRatingControl alloc] initWithLocation:CGPointMake(100, 215)
                                                                          emptyImage:dot
                                                                          solidImage:star
                                                                        andMaxRating:5];
    imagesRatingControl.backgroundColor = [UIColor redColor];
    imagesRatingControl.rating = 5;
    [imagesRatingControl addTarget:self action:@selector(updateEndRating:) forControlEvents:UIControlEventEditingDidEnd];
    [self.view addSubview:imagesRatingControl];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)updateEndRating:(id)sender
{
    NSLog(@"End Rating: %ld", (long)[(AMRatingControl *)sender rating]);
}

- (void)setUpNav
{
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectZero];
    label.text = @"4";
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
    FifthViewController *fifthVC = [[FifthViewController alloc] init];
    [self.navigationController pushViewController:fifthVC animated:YES];
}

- (IBAction)headAction:(UIButton *)sender
{
    UIAlertController *alertViewCtr = [UIAlertController alertControllerWithTitle:@"该分类下的商品将修改成未分类" message:@"确定要删除吗？" preferredStyle:UIAlertControllerStyleActionSheet];
    
    //    按钮事件
    
    //    UIAlertActionStyleCancel 取消风格只能有一个
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action)
                                   {
                                       NSLog(@"取消");
                                   }];
    
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    imagePicker.allowsEditing = YES;
    
    UIAlertAction *photaAction = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action)
                                  {
                                      BOOL isCamera =  [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear];
                                      if (!isCamera)
                                      {
                                          NSLog(@"不支持摄像头");
                                          return;
                                      }
                                      
                                      imagePicker.sourceType =  UIImagePickerControllerSourceTypeCamera;
                                      
                                      [self presentViewController:imagePicker animated:YES completion:^{
                                          
                                      }];
                                  }];
    
    UIAlertAction *imageAction = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action)
                                  {
                                      imagePicker.sourceType =  UIImagePickerControllerSourceTypePhotoLibrary;
                                      [self presentViewController:imagePicker animated:YES completion:^{
                                          
                                      }];
                                  }];
    
    
    //    把事件添加到控制器
    [alertViewCtr addAction:cancelAction];
    [alertViewCtr addAction:photaAction];//从上往下第一个位置
    [alertViewCtr addAction:imageAction];
    
    //    模态视图
    [self presentViewController:alertViewCtr animated:YES completion:^{
        
    }];
}


#pragma mark UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info;
{
//    NSLog(@"info = %@",info);
    
    //    UIImagePickerControllerEditedImage 编辑图片
    //    UIImagePickerControllerOriginalImage 原始图片
    
    UIImage *theImage = [info objectForKey:UIImagePickerControllerEditedImage];
    [self.headBtn setImage:theImage forState:UIControlStateNormal];
    [self dismissViewControllerAnimated:YES completion:^
    {
    }];
}
//- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker;
//{
//    [self dismissViewControllerAnimated:YES completion:^{
//        
//    }];
//}


- (IBAction)popOneAction:(UIButton *)sender
{
    UIAlertController *alertViewCtr = [UIAlertController alertControllerWithTitle:@"该分类下的商品将修改成未分类" message:@"确定要删除吗？" preferredStyle:UIAlertControllerStyleAlert];
    
    //    按钮事件
    
    //    UIAlertActionStyleCancel 取消风格只能有一个
    UIAlertAction *surelAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action)
                                   {
                                       NSLog(@"确定");
                                   }];
    
        //    把事件添加到控制器
    [alertViewCtr addAction:surelAction];

    
    //    模态视图
    [self presentViewController:alertViewCtr animated:YES completion:^
    {
        
    }];
}

- (IBAction)popTwoAction:(UIButton *)sender
{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"是否退出此次编辑？" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
    [alert show];
//    UIAlertController *alertViewCtr = [UIAlertController alertControllerWithTitle:/*@"该分类下的商品将修改成未分类"*/nil message:@"确定要删除吗？" preferredStyle:UIAlertControllerStyleAlert];
//    
//    //    按钮事件
//    
//    //    UIAlertActionStyleCancel 取消风格只能有一个
//    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action)
//                                   {
//                                       NSLog(@"取消");
//                                   }];
//
//    
//    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action)
//                                  {
//                                      NSLog(@"确定");
//                                  }];
//    
//    //    把事件添加到控制器
//    [alertViewCtr addAction:cancelAction];//取消在左边
//    [alertViewCtr addAction:sureAction];//确定在右边
//    
//    //    模态视图
//    [self presentViewController:alertViewCtr animated:YES completion:^{
//        
//    }];
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    switch (buttonIndex) {
        case 0:
        {
            NSLog(@"确定");
            [self.navigationController popViewControllerAnimated:YES];
            break;
        }
            
        default:
            break;
    }
}
@end
