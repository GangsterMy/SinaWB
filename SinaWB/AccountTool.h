//
//  AccountTool.h
//  SinaWB
//
//  Created by 赵麦 on 8/13/16.
//  Copyright © 2016 歹徒. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Account;
@interface AccountTool : NSObject

+(void)saveAcoount:(Account *)account;

//return account information
//如果过期 return nil;
+(Account *)account;

@end
