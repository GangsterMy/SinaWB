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
//created_at	string	微博创建时间
@property (nonatomic, copy) NSString *created_at;
//source	string	微博来源
@property (nonatomic, copy) NSString *source;
//pic_ids	object	微博配图ID。多图时返回多图ID，用来拼接图片url。用返回字段thumbnail_pic的地址配上该返回字段的图片ID，即可得到多个图片url。
@property (nonatomic, strong) NSArray *pic_urls;

@end
