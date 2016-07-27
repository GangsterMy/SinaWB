//
//  Test1ViewController.m
//  SinaWB
//
//  Created by 赵麦 on 7/20/16.
//  Copyright © 2016 歹徒. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "Test1ViewController.h"
#import "Test2ViewController.h"

@interface Test1ViewController ()

@end

@implementation Test1ViewController

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    Test2ViewController *test2 = [[Test2ViewController alloc] init];
    test2.title =@"test2controller";
    [self.navigationController pushViewController:test2 animated:YES];
}

@end
