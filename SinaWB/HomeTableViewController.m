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

@interface HomeTableViewController () <DropdownMenuDelegate>

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
    [titleBtn setImage:[UIImage imageNamed:@"navigationbar_arrow_up"] forState:UIControlStateSelected];
//    titleBtn.imageView.backgroundColor = [UIColor redColor];
//    titleBtn.titleLabel.backgroundColor = [UIColor blueColor];
    titleBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 70, 0, 0);
    titleBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 40);
    
    //监听标题点击
    [titleBtn addTarget:self action:@selector(titleClick: ) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView = titleBtn;
    
//    SWBLog(@"%@", NSHomeDirectory());
    
    //    SWBLog(@"HomeTableViewController viewDidLoad");
}

-(void)titleClick:(UIButton *)titleBtn {
    
    //1.set dropdownmenu
    DropdownMenu *menu = [DropdownMenu menu];
    menu.delegate = self;
    
    //2.set content
//    menu.content = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 0, 100)];
    TitleMenuTVC *vc = [[TitleMenuTVC alloc] init];
    vc.view.height = 44 * 3;
    vc.view.width = 150;
    menu.contentController = vc;
    
    //3.show
    [menu showFrom:titleBtn];
    
}

-(void)friendSearch {
    SWBLog(@"friendSearch");
}

-(void)pop {
    SWBLog(@"pop");
}

#pragma mark - DropdownMenuDelegate
-(void)dropdownMenuDidDismiss:(DropdownMenu *)menu {
    UIButton *titleBtn = (UIButton *) self.navigationItem.titleView;
    titleBtn.selected = NO;
//    [titleBtn setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];

}

-(void)dropdownMenuDidShow:(DropdownMenu *)menu {
    UIButton *titleBtn = (UIButton *) self.navigationItem.titleView;
    titleBtn.selected = YES;
//    [titleBtn setImage:[UIImage imageNamed:@"navigationbar_arrow_up"] forState:UIControlStateNormal];

}

@end
