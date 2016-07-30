//
//  DropdownMenu.m
//  SinaWB
//
//  Created by 赵麦 on 7/31/16.
//  Copyright © 2016 歹徒. All rights reserved.
//

#import "DropdownMenu.h"

@interface DropdownMenu()
@property (nonatomic, weak) UIImageView *containerView;

@end

@implementation DropdownMenu

- (UIImageView *)containerView {
    if (!_containerView) {
        //add dropdownmenu image
        UIImageView *containerView = [[UIImageView alloc] init];
        containerView.image = [UIImage imageNamed:@"popover_background"];
        containerView.width = 217;
        containerView.height = 217;
        containerView.userInteractionEnabled = YES;
        [self addSubview:containerView];
        self.containerView = containerView;
    }
    return _containerView;
}

-(id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor =[UIColor clearColor];
        //combine with show method is equal to overlap
        
    }
    return self;
}

+(instancetype)menu {
    return [[self alloc] init];
}

-(void)setContent:(UIView *)content {
    
    _content = content;
    
    //reset content position
    content.x = 10;
    content.y = 15;
    
    //reset content width
    content.width = self.containerView.width - 2 *content.x;
    
    //set menu size
    self.containerView.height = CGRectGetMaxY(content.frame) + 10;

    
    //add contents to menu
    [self.containerView addSubview:content];

    
}

-(void)setContentController:(UIViewController *)contentController {
    _contentController = contentController;
    
    self.content = contentController.view;
}

-(void)showFrom:(UIView *)from {
    //1.get the top layer window
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    
    //2.add to window
    [window addSubview:self];
    
    //3.set size
    self.frame = window.bounds;
    
    //4.reset menu image position
    //self point to cover
    self.containerView.x = (self.width - self.containerView.width) * 0.5;
    self.containerView.y = 50;
}

-(void)dismiss {
    [self removeFromSuperview];
}


//-(void)titleClick {
//        //get current top layer window
//        UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
//
//        //添加蒙板
//        UIView *cover = [[UIView alloc] init];
//        cover.backgroundColor = [UIColor clearColor];
//        cover.frame = window.bounds;
//        [window addSubview:cover];
//
//
//        //add popover image
//        UIImageView *dropdownMenu = [[UIImageView alloc] init];
//        dropdownMenu.image = [UIImage imageNamed:@"popover_background"];
//        dropdownMenu.width = 217;
//        dropdownMenu.height = 217;
//        dropdownMenu.y = 40;
//        dropdownMenu.userInteractionEnabled = YES; // 开启交互功能
//
//        [dropdownMenu addSubview:[UIButton buttonWithType:UIButtonTypeContactAdd]];
//
//        [cover addSubview:dropdownMenu];
//}

@end
