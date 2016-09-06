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

+(void)initialize {
    //set all item appearance
    UIBarButtonItem *item = [UIBarButtonItem appearance];
    
    //set normal state
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = [UIColor orangeColor];
    textAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:13.0];
    [item setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    
    //set enable state
    NSMutableDictionary *disableTextAttrs = [NSMutableDictionary dictionary];
    disableTextAttrs[NSForegroundColorAttributeName] = [UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:0.7];
    
    //every pixel has its own color, every color counld consist of RGB
    // 12bit color: #f00 一个f是16进制位=4个二进制位 所以f(R) 0(G) 0(B) 三个 是12bit
    // 24bit color: #ff0000 ff = 255
    // 32bit color: #ff0000ff RGBA
    
    
    disableTextAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:13.0];
    [item setTitleTextAttributes:disableTextAttrs forState:UIControlStateDisabled];
}

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
