//
//  SWStatus.m
//  SinaWB
//
//  Created by 赵麦 on 9/6/16.
//  Copyright © 2016 歹徒. All rights reserved.
//

#import "SWStatus.h"
#import "MJExtension.h"
#import "SWPhoto.h"

@implementation SWStatus

+(NSDictionary *)mj_objectClassInArray {
    return @{@"pic_urls": [SWPhoto class]};

};

@end
