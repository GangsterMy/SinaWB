//
//  Account.m
//  SinaWB
//
//  Created by 赵麦 on 8/11/16.
//  Copyright © 2016 歹徒. All rights reserved.
//

#import "Account.h"

@implementation Account

+(instancetype)accountWithDict:(NSDictionary *)dict {
    Account *account = [[self alloc] init];
    account.access_token = dict[@"access_token"];
    account.expires_in = dict[@"expires_in"];
    account.uid = dict[@"uid"];
    //获得账号存储的时间accessToken产生时间
    account.created_time = [NSDate date];
    return account;
}

//当一个对象要归档进沙盒中时 就会调用
//在方法中需要说明存进沙盒的对象属性
-(void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.access_token forKey:@"access_token"];
    [aCoder encodeObject:self.expires_in forKey:@"expires_in"];
    [aCoder encodeObject:self.uid forKey:@"uid"];
    [aCoder encodeObject:self.created_time forKey:@"created_time"];
    [aCoder encodeObject:self.name forKey:@"name"];
}

//解档
-(instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        self.access_token = [aDecoder decodeObjectForKey:@"access_token"];
        self.expires_in = [aDecoder decodeObjectForKey:@"expires_in"];
        self.uid = [aDecoder decodeObjectForKey:@"uid"];
        self.created_time = [aDecoder decodeObjectForKey:@"created_time"];
        self.name = [aDecoder decodeObjectForKey:@"name"];
    }
    return self;
}
@end
