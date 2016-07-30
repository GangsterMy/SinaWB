//
//  DropdownMenu.h
//  SinaWB
//
//  Created by 赵麦 on 7/31/16.
//  Copyright © 2016 歹徒. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DropdownMenu : UIView

+(instancetype)menu;

-(void)showFrom:(UIView *)from;

-(void)dismiss;

@property (nonatomic, strong) UIView *content;
//便于menu.content = ... 赋值一个view
@property (nonatomic, strong) UIViewController *contentController;

@end
