//
//  SWUser.m
//  SinaWB
//
//  Created by 赵麦 on 9/6/16.
//  Copyright © 2016 歹徒. All rights reserved.
//

#import "SWUser.h"

@implementation SWUser

-(void)setMbtype:(int)mbtype {
    _mbtype = mbtype;
    self.vip = mbtype > 2;
}

//-(BOOL)isVip {
//    return self.mbrank > 2;
//}

@end
