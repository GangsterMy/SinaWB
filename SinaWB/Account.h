//
//  Account.h
//  SinaWB
//
//  Created by 赵麦 on 8/11/16.
//  Copyright © 2016 歹徒. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Account : NSObject <NSCoding>
//Oauth2/access token 返回数据

@property (nonatomic, copy) NSString *access_token;
@property (nonatomic, copy) NSNumber *expires_in;
//@property (nonatomic, copy) NSString *remind_in;
@property (nonatomic, copy) NSString *uid;

//accessToken获得时间
@property (nonatomic, strong) NSDate *created_time;

+(instancetype)accountWithDict:(NSDictionary *)dict;
@end
