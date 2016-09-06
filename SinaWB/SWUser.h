//
//  SWUser.h
//  SinaWB
//
//  Created by 赵麦 on 9/6/16.
//  Copyright © 2016 歹徒. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SWUser : NSObject
//idstr	string	字符串型的用户UID //@"100"
//id	int64	用户UID //100 可能和自己的冲突 放弃
@property (nonatomic, copy) NSString *idstr;
//name	string	友好显示名称
@property (nonatomic, copy) NSString *name;
//profile_image_url	string	用户头像地址（中图），50×50像素
@property (nonatomic, copy) NSString *profile_image_url;

@end
