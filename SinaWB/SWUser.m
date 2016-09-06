//
//  SWUser.m
//  SinaWB
//
//  Created by 赵麦 on 9/6/16.
//  Copyright © 2016 歹徒. All rights reserved.
//

#import "SWUser.h"

@implementation SWUser

+(instancetype)userWithDict:(NSDictionary *)dict {
    SWUser *user = [[self alloc] init];
    user.idstr = dict[@"idstr"];
    user.name = dict[@"name"];
    user.profile_image_url = dict[@"profile_image_url"];
    return user;
}

@end
