//
//  AccountTool.m
//  SinaWB
//
//  Created by 赵麦 on 8/13/16.
//  Copyright © 2016 歹徒. All rights reserved.
//

#define AccountPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"account.archive"]
#import "AccountTool.h"
#import "Account.h"

@implementation AccountTool

+(void)saveAcoount:(Account *)account {
    //沙盒路径
    //    NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    //    NSString *path = [doc stringByAppendingPathComponent:@"account.archive"];
    
    //获得账号存储的时间accessToken产生时间
    account.created_time = [NSDate date];
    
    //自定义对象的存储必须用NSKeyedArchiver 不再有writeToFile
    [NSKeyedArchiver archiveRootObject:account toFile:AccountPath];
}

+(Account *)account {
    //沙盒路径
    //    NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    //    NSString *path = [doc stringByAppendingPathComponent:@"account.archive"];
    
    //加载模型
    Account *account = [NSKeyedUnarchiver unarchiveObjectWithFile:AccountPath];
    
    //验证账号是否过期
    //过期秒数
    long long expires_in = [account.expires_in longLongValue];
    //获得过期时间
    NSDate *expiresTime = [account.created_time dateByAddingTimeInterval:expires_in];
    //获得当前时间
    NSDate *now = [NSDate date];
    
    NSComparisonResult result = [expiresTime compare:now];
    if (result != NSOrderedDescending) {
        return nil;
    }
//    SWBLog(@"%@ %@", expiresTime, now);
    return  account;
}

@end
