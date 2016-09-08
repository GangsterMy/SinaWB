//
//  LoadMoreFooter.m
//  SinaWB
//
//  Created by 赵麦 on 9/8/16.
//  Copyright © 2016 歹徒. All rights reserved.
//

#import "LoadMoreFooter.h"

@implementation LoadMoreFooter

+(instancetype)footer {
    return [[[NSBundle mainBundle] loadNibNamed:@"LoadMoreFooter" owner:nil options:nil] lastObject];
}

@end
