//
//  FifthViewController.m
//  LoginBoardDemo
//
//  Created by ChenRongQin on 16/8/9.
//  Copyright © 2016年 Afu. All rights reserved.
//


/*
 
 
 注意：添加第三方MMGridView时，要在Build Phases-》Compile sources 中MMGridViewCell.m\MMGridView.m\XLCycleScrollView.m文件中添加-fno-objc-arc，以支持非ARC
 */


#import "FifthViewController.h"

#import "SixthViewController.h"

#import "ZYQAssetPickerController.h"

#import "MMGridView.h"
#import "MMGridViewDefaultCell.h"
#import "UIImageView+WebCache.h"

#import "PrimerateImgViewController.h"

#import "MWPhotoBrowser.h"

@interface FifthViewController ()<MMGridViewDataSource,MMGridViewDelegate, ZYQAssetPickerControllerDelegate, UINavigationControllerDelegate, MWPhotoBrowserDelegate>


@property (weak, nonatomic) IBOutlet UIView *headView;
@property (nonatomic, strong)MMGridView *gridView;
@property (nonatomic, strong) UIPageControl * pageControl;
@property (nonatomic, strong)NSMutableArray *imageArray;



@property (nonatomic, retain) NSMutableArray *memoryImageAry;//存储选取图片的image
@property (nonatomic, strong)UIView *photoContentView;;
@property (nonatomic, strong)UIScrollView *sv;

@end

@implementation FifthViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setUpNav];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.imageArray = [NSMutableArray array];
    for (int i=0; i<10; i++)
    {
        [self.imageArray addObject:[NSString stringWithFormat:@"https://s3.amazonaws.com/fast-image-cache/demo-images/FICDDemoImage%03d.jpg", i]];
    }
    self.gridView = [[MMGridView alloc]initWithFrame:self.headView.bounds];
    self.gridView.cellMargin = 0;
    self.gridView.numberOfRows = 1;
    self.gridView.numberOfColumns = 3;
    self.gridView.backgroundColor = [UIColor clearColor];
    self.gridView.dataSource = self;
    self.gridView.delegate = self;
    [self.headView addSubview:self.gridView];
    self.pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake((self.headView.bounds.size.width - 64)/2, self.headView.bounds.size.height - 12, 64, 8)];
    [self.pageControl setCurrentPageIndicatorTintColor:[UIColor colorWithRed:35/255.f green:150/255.f blue:226/255.f alpha:1.0]];
    [self.pageControl setPageIndicatorTintColor:[UIColor colorWithRed:232/255.f green:232/255.f blue:232/255.f alpha:1.0]];
    self.pageControl.numberOfPages = self.gridView.numberOfPages;
    self.pageControl.currentPage = self.gridView.currentPageIndex;
    [self.headView addSubview:self.pageControl];
    
    
    
    
    
    
    //上传多张图片
    self.memoryImageAry = [NSMutableArray arrayWithCapacity:10];
    
    self.photoContentView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 64 - 216, SCREEN_WIDTH, 216)];
    self.photoContentView.backgroundColor = RGBA(249, 249, 249, 1);
//    self.photoContentView.hidden = YES;
    [self.view addSubview:self.photoContentView];
    
    self.sv = [[UIScrollView alloc]initWithFrame:CGRectMake(10, 10, SCREEN_WIDTH-10*2, 216-20)];
    self.sv.backgroundColor = [UIColor clearColor];
    [self.photoContentView addSubview:self.sv];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma - MMGridViewDataSource
- (NSInteger)numberOfCellsInGridView:(MMGridView *)gridView
{
    return self.imageArray.count;
}


- (MMGridViewCell *)gridView:(MMGridView *)gridView cellAtIndex:(NSUInteger)index
{
    MMGridViewDefaultCell *cell = [[MMGridViewDefaultCell alloc] initWithFrame:CGRectNull];

    [cell.iconImageVIew sd_setImageWithURL:[NSURL URLWithString:self.imageArray[index]] placeholderImage:[UIImage imageNamed:@"youhui_small.png"]];

    return cell;
}

#pragma mark - MMGridViewDelegate
- (void)gridView:(MMGridView *)gridView didSelectCell:(MMGridViewCell *)cell atIndex:(NSUInteger)index
{
    NSLog(@"index:%ld", index);
    PrimerateImgViewController *pImgVC = [[PrimerateImgViewController alloc]initWithNibName:@"PrimerateImgViewController" bundle:[NSBundle mainBundle]];
    pImgVC.photoUrlAry = self.imageArray;
    pImgVC.changeCount = index;
    pImgVC.photoCount = self.imageArray.count;
    [self.navigationController pushViewController:pImgVC animated:YES];
}

- (void)gridView:(MMGridView *)theGridView changedPageToIndex:(NSUInteger)index
{
    self.pageControl.numberOfPages = self.gridView.numberOfPages;
    self.pageControl.currentPage = self.gridView.currentPageIndex;
    NSLog(@"numberOfPages:%ld", self.gridView.numberOfPages);
    NSLog(@"currentPageIndex:%ld", self.gridView.currentPageIndex);
}

- (void)setUpNav
{
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectZero];
    label.text = @"5";
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
    SixthViewController *sixVC = [[SixthViewController alloc] init];
    [self.navigationController pushViewController:sixVC animated:YES];
}



//上传多张图片
- (IBAction)selectMultiImageAction:(UIButton *)sender
{
    if (self.memoryImageAry.count >= 9)
    {
        UIAlertController *alertViewCtr = [UIAlertController alertControllerWithTitle:nil message:@"最多上传9张图片" preferredStyle:UIAlertControllerStyleAlert];

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
        return;
    }
    
    ZYQAssetPickerController *picker = [[ZYQAssetPickerController alloc] init];
    picker.maximumNumberOfSelection = 9-[self.memoryImageAry count];
    picker.assetsFilter = [ALAssetsFilter allPhotos];
    picker.showEmptyGroups = NO;
    picker.delegate = self;
    [self presentViewController:picker animated:YES completion:NULL];
}

#pragma mark - ZYQAssetPickerController Delegate
- (void)assetPickerController:(ZYQAssetPickerController *)picker didFinishPickingAssets:(NSArray *)assets
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^
    {
        
        for (int i=0; i<assets.count; i++)
        {
            ALAsset *asset = assets[i];;
            UIImage *image = [UIImage imageWithCGImage:asset.defaultRepresentation.fullScreenImage];

            [self.memoryImageAry addObject:image];
        }
        
        NSLog(@"count:%ld", self.memoryImageAry.count);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self updateSVphoto];
//            [self badgeShowOrHide];
        });
    });
}

//- (void)assetPickerControllerDidCancel:(ZYQAssetPickerController *)picker
//{
//    [self badgeShowOrHide];
//}


//- (void)badgeShowOrHide {
//    if (self.memoryImageAry.count <= 0) {
//        self.toolView.frame = CGRectMake(0, SCREEN_HEIGHT -64-40, SCREEN_WIDTH, 40);
//        photoContentView.hidden = YES;
//    }
//    
//    self.badgeLab.text = [NSString stringWithFormat:@"%lu",(unsigned long)[self.memoryImageAry count]];
//    if (self.memoryImageAry.count > 0) {
//        self.badgeBg.hidden = NO;
//        self.badgeLab.hidden = NO;
//    }else {
//        self.badgeBg.hidden = YES;
//        self.badgeLab.hidden = YES;
//    }
//}

- (void)updateSVphoto
{
    NSUInteger count = [self.memoryImageAry count];
    int sumI = 3;
    CGFloat width = (SCREEN_WIDTH-10*2)/sumI;
    CGFloat height = 90;
    int remainder = count%sumI;
    int sumJ = remainder == 0 ? (int)count/sumI : (int)(count/sumI+1);
    if (self.sv)
    {
        for (id obj in self.sv.subviews)
        {
            [obj removeFromSuperview];
        }
    }
    for (int j = 1; j <= sumJ; j++)
    {
        for (int i = 1; i <= sumI; i++)
        {
            CGFloat w =  width * (i - 1);
            CGFloat h =  height * (j - 1);
            
            UIView *v = [[UIView alloc] initWithFrame:CGRectMake(w, h, width, height)];
            [v setBackgroundColor:[UIColor yellowColor]];
            [self.sv addSubview:v];
            
            UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, width-10, height-10)];
            img.image = self.memoryImageAry[(j - 1)*sumI + i - 1];
            img.contentMode = UIViewContentModeScaleAspectFit;
            img.layer.borderWidth = 0.5f;
            img.layer.borderColor = [RGBA(193, 193, 193, 1) CGColor];
            [v addSubview:img];
            
            UIButton *tapBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            tapBtn.tag = (j - 1)*sumI + i - 1;
            [tapBtn addTarget:self action:@selector(tapBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            tapBtn.frame = img.frame;
            [v addSubview:tapBtn];
            
            
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.tag = (j - 1)*sumI + i - 1;
            [btn setBackgroundImage:[UIImage imageNamed:@"img_del_nor"] forState:UIControlStateNormal];
            [btn setBackgroundImage:[UIImage imageNamed:@"img_del_pre"] forState:UIControlStateHighlighted];
            btn.frame = CGRectMake(width-15, 0, 15, 15);
            [btn addTarget:self action:@selector(delPhoto:) forControlEvents:UIControlEventTouchUpInside];
            [v addSubview:btn];
            
            
            if (((j - 1)*sumI + i - 1) == ([self.memoryImageAry count]-1) && [self.memoryImageAry count] > 0)
            {
                
                if (i%sumI == 0)
                {
                    if ([self.memoryImageAry count] < 9)
                    {
                        CGFloat tmpW =  0;
                        CGFloat tmpH =  height * j;
                        UIView *addView = [[UIView alloc]initWithFrame:CGRectMake(tmpW, tmpH, width, height)];
                        addView.backgroundColor = [UIColor clearColor];
                        [self.sv addSubview:addView];
                        
                        UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
                        [addBtn setBackgroundImage:[UIImage imageNamed:@"img_add_nor"] forState:UIControlStateNormal];
                        [addBtn setBackgroundImage:[UIImage imageNamed:@"img_add_pre"] forState:UIControlStateHighlighted];
                        addBtn.frame = CGRectMake(5, 5, width-10, height-10);
                        [addBtn addTarget:self action:@selector(addPhoto:) forControlEvents:UIControlEventTouchUpInside];
                        [addView addSubview:addBtn];
                    }
                    
                }
                
                else
                {
                    CGFloat tmpW =  width * i;
                    CGFloat tmpH =  height * (j-1);
                    UIView *addView = [[UIView alloc]initWithFrame:CGRectMake(tmpW, tmpH, width, height)];
                    addView.backgroundColor = [UIColor clearColor];
                    [self.sv addSubview:addView];
                    
                    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
                    [addBtn setBackgroundImage:[UIImage imageNamed:@"img_add_nor"] forState:UIControlStateNormal];
                    [addBtn setBackgroundImage:[UIImage imageNamed:@"img_add_pre"] forState:UIControlStateHighlighted];
                    addBtn.frame = CGRectMake(5, 5, width-10, height-10);
                    [addBtn addTarget:self action:@selector(addPhoto:) forControlEvents:UIControlEventTouchUpInside];
                    [addView addSubview:addBtn];
                }
            }
            
            if(j == sumJ && i == remainder)
            {
                break;
            }
        }
    }
    
    if ([self.memoryImageAry count] == 6)
    {
        [self.sv setContentSize:CGSizeMake(SCREEN_WIDTH-2*10, height*(sumJ+1))];
    }
    
    else
    {
        [self.sv setContentSize:CGSizeMake(SCREEN_WIDTH-2*10, height*sumJ)];
    }
    
}

- (void)tapBtnClick:(UIButton *)sender
{
    NSInteger index = sender.tag;
    
    MWPhotoBrowser *browser = [[MWPhotoBrowser alloc] initWithDelegate:self];
    browser.displayActionButton = YES;
    browser.displayNavArrows = YES;
    browser.displaySelectionButtons = NO;
    browser.alwaysShowControls = NO;
    browser.zoomPhotosToFill = YES;
    browser.enableGrid = NO;
    browser.startOnGrid = NO;
    browser.enableSwipeToDismiss = NO;
    [browser setCurrentPhotoIndex:index];
    
    UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:browser];
    nc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:nc animated:YES completion:nil];
}

- (void)addPhoto:(UIButton *)sender
{
    if (self.memoryImageAry.count >= 9)
    {
        UIAlertController *alertViewCtr = [UIAlertController alertControllerWithTitle:nil message:@"最多上传9张图片" preferredStyle:UIAlertControllerStyleAlert];
        
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
        return;
    }
    
    ZYQAssetPickerController *picker = [[ZYQAssetPickerController alloc] init];
    picker.maximumNumberOfSelection = 9-[self.memoryImageAry count];
    picker.assetsFilter = [ALAssetsFilter allPhotos];
    picker.showEmptyGroups = NO;
    picker.delegate = self;
    [self presentViewController:picker animated:YES completion:NULL];
}


- (void)delPhoto:(UIButton *)sender
{
    [self.memoryImageAry removeObjectAtIndex:sender.tag];
    [self updateSVphoto];
//    [self badgeShowOrHide];
}


#pragma mark - MWPhotoBrowserDelegate
- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser
{
    return self.memoryImageAry.count;
}

- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index
{
    return [MWPhoto photoWithImage:self.memoryImageAry[index]];
}
@end
