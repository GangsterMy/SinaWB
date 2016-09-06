//
//  DropdownMenu.h
//  SinaWB
//
//  Created by 赵麦 on 7/31/16.
//  Copyright © 2016 歹徒. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DropdownMenu;

@protocol DropdownMenuDelegate <NSObject>
@optional
-(void)dropdownMenuDidDismiss:(DropdownMenu *)menu;
-(void)dropdownMenuDidShow:(DropdownMenu *)menu;
@end

@interface DropdownMenu : UIView

@property (nonatomic, weak) id<DropdownMenuDelegate> delegate;

+(instancetype)menu;

-(void)showFrom:(UIView *)from;

-(void)dismiss;

@property (nonatomic, strong) UIView *content;
//便于menu.content = ... 赋值一个view
@property (nonatomic, strong) UIViewController *contentController;

@end
