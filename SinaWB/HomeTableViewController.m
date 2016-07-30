//
//  HomeTableViewController.m
//  SinaWB
//
//  Created by 赵麦 on 7/20/16.
//  Copyright © 2016 歹徒. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "HomeTableViewController.h"
#import "SearchBar.h"
#import "DropdownMenu.h"
#import "TitleMenuTVC.h"

@interface HomeTableViewController ()

@end

@implementation HomeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(friendSearch) image:@"navigationbar_friendsearch" highImage:@"navigationbar_friendsearch_highlighted"];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(pop) image:@"navigationbar_pop" highImage:@"navigationbar_pop_highlighted"];
    
    /* title button */
//    UIButton *titleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIButton *titleBtn = [[UIButton alloc] init];
    titleBtn.width = 150;
    titleBtn.height = 30;
//    titleBtn.backgroundColor = WBRandomColor;
    
    //set image and font
    [titleBtn setTitle:@"首页" forState:UIControlStateNormal];
    [titleBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    titleBtn.titleLabel.font = [UIFont boldSystemFontOfSize:17];
    [titleBtn setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
//    titleBtn.imageView.backgroundColor = [UIColor redColor];
//    titleBtn.titleLabel.backgroundColor = [UIColor blueColor];
    titleBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 70, 0, 0);
    titleBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 40);
    
    //监听标题点击
    [titleBtn addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView = titleBtn;
    
//    SWBLog(@"HomeTableViewController viewDidLoad");
}

-(void)titleClick:(UIButton *)titleBtn {
    
    //set dropdownmenu
    DropdownMenu *menu = [DropdownMenu menu];
    
    //set content
//    menu.content = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 0, 100)];
    TitleMenuTVC *vc = [[TitleMenuTVC alloc] init];
    vc.view.height = 44 * 3;
    menu.contentController = vc;
    
    
    //show
    [menu showFrom:titleBtn];
//    [menu dismiss];
}

-(void)friendSearch {
    SWBLog(@"friendSearch");
}

-(void)pop {
    SWBLog(@"pop");
}

@end
