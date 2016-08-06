//
//  NewfeatureViewController.m
//  SinaWB
//
//  Created by 赵麦 on 8/4/16.
//  Copyright © 2016 歹徒. All rights reserved.
//

#import "NewfeatureViewController.h"
#define NewfeatureCount 4

@interface NewfeatureViewController () <UIScrollViewDelegate>
@property (nonatomic, weak) UIPageControl *pageControl;
@end

@implementation NewfeatureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //1.create a scrollView: show newfeature images
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.frame = self.view.bounds;
    [self.view  addSubview:scrollView];
    
    //2. add images to scrollView
    CGFloat scrollW = scrollView.width;
    CGFloat scrollH = scrollView.height;
    for (int i = 0; i < NewfeatureCount; i++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.width = scrollW;
        imageView.height = scrollH;
        imageView.y = 0;
        imageView.x = i * scrollW;
        NSString *name = [NSString stringWithFormat:@"new_feature_%d", i + 1];
        imageView.image = [UIImage imageNamed:name];
        
        [scrollView addSubview:imageView];
        
#warning 默认情况下scrollView内部已经存在部分子控件
        //if is last imageView add button
        if (i == NewfeatureCount - 1) {
            [self setupLastImageView:imageView];
        }
        
    }
    
    //3.set scrollView
    scrollView.contentSize = CGSizeMake(NewfeatureCount * scrollW, 0);
    //去除弹簧效果
    scrollView.bounces = NO;
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.delegate = self;
    
    //4.add pageController
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    pageControl.numberOfPages = NewfeatureCount;
    
    pageControl.currentPageIndicatorTintColor = WBColor(253, 98, 42);
    pageControl.pageIndicatorTintColor = WBColor(189, 189, 189);
    
    pageControl.centerX = scrollW * 0.5;
    pageControl.centerY = scrollH - 50;
    [self.view addSubview:pageControl];
    self.pageControl = pageControl;
    
    //UIPageControll could show without size, equal to userInteractionEnabled = NO
    //        pageControl.width = 100;
    //        pageControl.height = 50;
    //        pageControl.userInteractionEnabled = NO;
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    //double 0.5 1.5 2.5 3.5 四舍五入 (int)(page + 0.5)
    double page = scrollView.contentOffset.x / scrollView.width;
    self.pageControl.currentPage = (int)(page + 0.5);
}

-(void)setupLastImageView:(UIView *)imageView {
    
    imageView.userInteractionEnabled = YES;
    
    //1.share checkbox
    UIButton *shareBtn = [[UIButton alloc] init];
    [shareBtn setImage:[UIImage imageNamed:@"new_feature_share_false"] forState:UIControlStateNormal];
    [shareBtn setImage:[UIImage imageNamed:@"new_feature_share_true"] forState:UIControlStateSelected];
    [shareBtn setTitle:@"分享给大家" forState:UIControlStateNormal];
    [shareBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    shareBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    
    shareBtn.width = 150;
    shareBtn.height = 30;
    shareBtn.centerX = imageView.width * 0.5;
    shareBtn.centerY = imageView.height * 0.7;
    
    [shareBtn addTarget:self action:@selector(shareClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [imageView addSubview:shareBtn];
    shareBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    
    //2.start weibo
    UIButton *startBtn = [[UIButton alloc] init];
    [startBtn setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button"] forState:UIControlStateNormal];
    [startBtn setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button_highlighted"] forState:UIControlStateHighlighted];
    startBtn.size = startBtn.currentBackgroundImage.size;
    startBtn.centerX = shareBtn.centerX;
    startBtn.centerY = imageView.height * 0.8;
    [startBtn setTitle:@"开始微博" forState:UIControlStateNormal];
    startBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 5);
    [imageView addSubview:startBtn];
}

-(void)shareClick:(UIButton *)shareBtn {
    shareBtn.selected = !shareBtn.isSelected;
}

@end
