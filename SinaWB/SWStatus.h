//
//  SWStatus.h
//  SinaWB
//
//  Created by 赵麦 on 9/6/16.
//  Copyright © 2016 歹徒. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SWUser;

@interface SWStatus : NSObject

//idstr	string	字符串型的微博ID
@property (nonatomic, copy) NSString *idstr;
//text	string	微博信息内容
@property (nonatomic, copy) NSString *text;
//user	object	微博作者的用户信息字段 详细
@property (nonatomic, strong) SWUser *user;

@end
