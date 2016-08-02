//
//  MainTabBarController.m
//  SinaWB
//
//  Created by 赵麦 on 7/20/16.
//  Copyright © 2016 歹徒. All rights reserved.
//

#import "MainTabBarController.h"
#import "HomeTableViewController.h"
#import "MessageCenterTableViewController.h"
#import "DiscoverTableViewController.h"
#import "ProfileTableViewController.h"
#import "NavigationController.h"
#import "SWBTabBar.h"

@interface MainTabBarController () <SWBTabBarDelegate>

@end

@implementation MainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //1.initiate childViewController
    HomeTableViewController *home = [[HomeTableViewController alloc] init];
    [self addChildVc:home title:@"首页" image:@"tabbar_home" selectedImage:@"tabbar_home_selected"];
    
    MessageCenterTableViewController *messageCenter = [[MessageCenterTableViewController alloc] init];
    [self addChildVc:messageCenter title:@"消息" image:@"tabbar_message_center" selectedImage:@"tabbar_message_center_selected"];
    
    DiscoverTableViewController *discover = [[DiscoverTableViewController alloc] init];
    [self addChildVc:discover title:@"发现" image:@"tabbar_discover" selectedImage:@"tabbar_discover_selected"];
    
    ProfileTableViewController *profile = [[ProfileTableViewController alloc] init];
    [self addChildVc:profile title:@"我" image:@"tabbar_profile" selectedImage:@"tabbar_profile_selected"];
    
    //2.change system tabbar
    //    self.tabBar = [[SWBTabBar alloc] init]; //read only kvc
    SWBTabBar *tabBar = [[SWBTabBar alloc] init];
    tabBar.delegate = self;
    [self setValue:[[SWBTabBar alloc] init] forKeyPath:@"tabBar"];
    //    SWBLog(@"%@", self.tabBar);
    //    SWBLog(@"%@", self.tabBar.subviews);
    
}

-(void)viewWillAppear:(BOOL)animated {
    
    //    SWBLog(@"%@", self.tabBar.subviews);
}

- (void)addChildVc:(UIViewController *)childVc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage {
    //set childVc's title
    childVc.title = title;
    //    childVc.navigationItem.title = title;
    //    childVc.tabBarItem.title = title;
    
    //set childVc's image
    childVc.tabBarItem.image = [UIImage imageNamed:image];
    childVc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    //set text attribute
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    NSMutableDictionary *selectedTextAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = WBColor(123, 123, 123);
    selectedTextAttrs[NSForegroundColorAttributeName] = [UIColor orangeColor];
    [childVc.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    [childVc.tabBarItem setTitleTextAttributes:selectedTextAttrs forState:UIControlStateSelected];
    //    childVc.view.backgroundColor = WBRandomColor;
    //make four views created before add?
    
    //add a NavigationController to childVcs
    NavigationController *nav = [[NavigationController alloc] initWithRootViewController:childVc];
    
    //add to childVc
    [self addChildViewController:nav];
}

#pragma mark - SWBTabBarDelegate
-(void)tabBarDidClickPlusButton:(SWBTabBar *)tabBar {
    UIViewController *vc = [[UIViewController alloc] init];
    vc.view.backgroundColor = [UIColor redColor];
    [self presentViewController:vc animated:YES completion:nil];
}

@end
