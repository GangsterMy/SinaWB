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

@interface SWBTabBar : UITabBar
@property (nonatomic, weak) id<SWBTabBarDelegate> delegate;

@end
