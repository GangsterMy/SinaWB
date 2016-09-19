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

//视频中的代码如下:

//-(NSDictionary *)objectClassInArray {
//    return @{@"pic_urls": [SWPhoto class]};
//}

- (NSDictionary *)objectClassInArrayForClass:(SWPhoto *)c
{
    return @{@"pic_urls": c};
}

//MJExtension.h中更新了转模型的方法

///** 模型数组中的模型类型 */
//- (void)setObjectClassInArray:(Class)objectClass forClass:(Class)c
//{
//    if (!objectClass) return;
//    self.objectClassInArrayDict[NSStringFromClass(c)] = objectClass;
//}
//- (Class)objectClassInArrayForClass:(Class)c
//{
//    return self.objectClassInArrayDict[NSStringFromClass(c)];
//}

@end
