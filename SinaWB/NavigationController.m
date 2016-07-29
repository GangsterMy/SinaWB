//
//  NavigationController.m
//  SinaWB
//
//  Created by 赵麦 on 7/25/16.
//  Copyright © 2016 歹徒. All rights reserved.
//

#import "NavigationController.h"

@interface NavigationController ()

@end

@implementation NavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
  
    if (self.viewControllers.count > 0) { //这是push进来的控制器不是第一个rootviewcontroller 数组 0为第一个
        /* auto show or hide bottom bar */
        
        viewController.hidesBottomBarWhenPushed = YES;
        
        /* set navcontroller's content */
        //set left back button
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(back) image:@"navigationbar_back" highImage:@"navigationbar_back_highlighted"];
       
        //set right more button
        viewController.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(more) image:@"navigationbar_more" highImage:@"navigationbar_more_highlighted"];
        
    }

    
    [super pushViewController:viewController animated:animated];
    
}

-(void)back {
    [self popViewControllerAnimated:YES];
}

-(void)more {
    [self popToRootViewControllerAnimated:YES];
}

@end
