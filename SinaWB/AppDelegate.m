//
//  AppDelegate.m
//  SinaWB
//
//  Created by 赵麦 on 7/20/16.
//  Copyright © 2016 歹徒. All rights reserved.
//

#import "AppDelegate.h"
#import <UIKit/UIKit.h>
#import "OAuthViewController.h"
#import "AccountTool.h"
#import <SDWebImageManager.h>

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    //1.create window
    self.window = [[UIWindow alloc] init];
    
    //3.show window
    [self.window makeKeyAndVisible];
    
    
    //2.set rootViewController
    Account *account = [AccountTool account];
    
    if (account) { //已经成功登录过
        
        [self.window switchRootViewController];
        
    } else {
       
        self.window.rootViewController = [[OAuthViewController alloc] init];
    }
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    /**
     *  app的状态
     *  1.死亡状态:没有打开app
     *  2.前台运行状态
     *  3.后台暂停状态:停止一切动画,定时器,多媒体,联网 很那再做其他操作
     *  4.后台运行状态
     */
    
    //向操作系统申请后台运行资格 但是能维持多久是不确定的
    UIBackgroundTaskIdentifier task = [application beginBackgroundTaskWithExpirationHandler:^{
        //当申请的后台运行时间已经结束(过期) 就会调用这个block
        
        //赶紧结束任务
        [application endBackgroundTask:task];
    }];
    
    //做一个0kb的MP3文件 没有声音
    //循环播放
    
    //以前的后台模式只有以下三种:
    //保持网络连接
    //多媒体应用
    //VOIP:网络电话
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

-(void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    
    SDWebImageManager *mgr = [SDWebImageManager sharedManager];
    
    //1.取消下载
    [mgr cancelAll];
    
    //2.清除内存中所有图片
    [mgr.imageCache clearMemory];
}

@end
