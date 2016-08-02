//
//  SWBTabBar.m
//  SinaWB
//
//  Created by 赵麦 on 8/2/16.
//  Copyright © 2016 歹徒. All rights reserved.
//

#import "SWBTabBar.h"

@interface SWBTabBar()
@property (nonatomic, weak) UIButton *plusBtn;

@end

@implementation SWBTabBar

-(id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        //3.add a button to middle of tabbar
        UIButton *plusBtn = [[UIButton alloc] init];
        [plusBtn setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button"] forState:UIControlStateNormal];
        [plusBtn setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button_highlighted"] forState:UIControlStateHighlighted];
        [plusBtn setImage:[UIImage imageNamed:@"tabbar_compose_icon_add"] forState:UIControlStateNormal];
        [plusBtn setImage:[UIImage imageNamed:@"tabbar_compose_icon_add_highlighted"] forState:UIControlStateHighlighted];
        plusBtn.size = plusBtn.currentBackgroundImage.size;
        [plusBtn addTarget:self action:@selector(plusClick) forControlEvents:UIControlEventTouchUpInside];
        self.plusBtn = plusBtn;
        [self addSubview:plusBtn];
    }
    return self;
}

-(void)plusClick {
    //通知代理
    if ([self.delegate respondsToSelector:@selector(tabBarDidClickPlusButton:)]) {
        [self.delegate tabBarDidClickPlusButton:self];
    }
}

-(void)layoutSubviews {
    [super layoutSubviews];
    
    //1.set plusBtn position
    self.plusBtn.centerX = self.width * 0.5;
    self.plusBtn.centerY = self.height * 0.5;
    
    //2.set other tabbarBtn position and size
    CGFloat tabbarButtonW = self.width /5;
    CGFloat tabbarButtonIndex = 0;
    
    for (UIView *child in self.subviews) {
        Class class = NSClassFromString(@"UITabBarButton");
        if ([child isKindOfClass:class]) {
            //set width
            child.width = tabbarButtonW;
            //set x
            child.x = tabbarButtonIndex * tabbarButtonW;
            //add index
            tabbarButtonIndex++;
            if (tabbarButtonIndex ==2 ) {
                tabbarButtonIndex++;
            }
        }
        
    }
    
    
    
    //    int count = self.subviews.count;
    //    for (int i = 0; i < count; i++) {
    //        UIView *child = self.subviews[i];
    //        Class class = NSClassFromString(@"UITabBarButton");
    //        if ([child isKindOfClass:class]) {
    //            //set width
    //            child.width = tabbarButtonW;
    //            //set x
    //            child.x = tabbarButtonIndex * tabbarButtonW;
    //            //add index
    //            tabbarButtonIndex++;
    //            if (tabbarButtonIndex ==2 ) {
    //                tabbarButtonIndex++;
    //            }
    //        }
    //    }
    
    //    SWBLog(@"%@", self.subviews);
}

@end
