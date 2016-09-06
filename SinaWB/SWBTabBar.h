//
//  SWBTabBar.h
//  SinaWB
//
//  Created by 赵麦 on 8/2/16.
//  Copyright © 2016 歹徒. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SWBTabBar;

@protocol SWBTabBarDelegate <UITabBarDelegate>

@optional
-(void)tabBarDidClickPlusButton:(SWBTabBar *)tabBar;
@end

@interface SWBTabBar : UITabBar //最彻底的继承是UIView 用于自定义与系统自带有明显差别
@property (nonatomic, weak) id<SWBTabBarDelegate> delegate;

@end
