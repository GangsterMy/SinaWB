//
//  UIWindow+Extension.m
//  SinaWB
//
//  Created by 赵麦 on 8/15/16.
//  Copyright © 2016 歹徒. All rights reserved.
//

#import "UIWindow+Extension.h"
#import "MainTabBarController.h"
#import "NewfeatureViewController.h"

@implementation UIWindow (Extension)

-(void)switchRootViewController {
    
    NSString *key = @"CFBundleVersion";
   
    //存储在沙盒中的last version
    NSString *lastVersion = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    //Info.plist current version
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[key];
    //    SWBLog(@"%@", currentVersion);
    
    if ([currentVersion isEqualToString:lastVersion]) {
       
        self.rootViewController = [[MainTabBarController alloc] init];
   
    } else {
       
        self.rootViewController = [[NewfeatureViewController alloc] init];
        
        //将current version 存进沙盒
        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }

}

@end
