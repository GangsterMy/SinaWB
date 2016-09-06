//
//  Test2ViewController.m
//  SinaWB
//
//  Created by 赵麦 on 7/20/16.
//  Copyright © 2016 歹徒. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Test2ViewController.h"
#import "Test3TVController.h"

@interface Test2ViewController ()

@end

@implementation Test2ViewController

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    Test3TVController *test3 = [[Test3TVController alloc] init];
    test3.title = @"test3controller";
    [self.navigationController pushViewController:test3 animated:YES];
}


@end
