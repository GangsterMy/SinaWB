//
//  SWStatus.m
//  SinaWB
//
//  Created by 赵麦 on 9/6/16.
//  Copyright © 2016 歹徒. All rights reserved.
//

#import "SWStatus.h"
#import "SWUser.h"

@implementation SWStatus

+(instancetype)statusWithDic:(NSDictionary *)dict {
    SWStatus *status = [[self alloc] init];
    status.idstr = dict[@"idstr"];
    status.text = dict[@"text"];
    status.user = [SWUser userWithDict:dict[@"user"]];
    return status;
}

@end
