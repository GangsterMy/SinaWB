//
//  StatusFrame.m
//  SinaWB
//
//  Created by 赵麦 on 9/17/16.
//  Copyright © 2016 歹徒. All rights reserved.
//

#import "StatusFrame.h"
#import "SWStatus.h"
#import "SWUser.h"

//cell的边框宽度
#define StatusCellBorderW 10

@implementation StatusFrame

-(CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxW:(CGFloat)maxW {
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = font;
    
    CGSize maxSize = CGSizeMake(maxW, MAXFLOAT);
    return [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}

-(CGSize)sizeWithText:(NSString *)text font:(UIFont *)font {
    return [self sizeWithText:text font:font maxW:MAXFLOAT];
}

-(void)setStatus:(SWStatus *)status {
   
    _status = status;
    
    SWUser *user = status.user;
    
    //cell宽度
    CGFloat cellW = [UIScreen mainScreen].bounds.size.width;
    
    /* 原创微博 */
    //头像
    CGFloat iconWH = 50;
    CGFloat iconX = StatusCellBorderW;
    CGFloat iconY = StatusCellBorderW;
    self.iconViewF = CGRectMake(iconX, iconY, iconWH, iconWH);
   
    //昵称
    CGFloat nameX = CGRectGetMaxX(self.iconViewF) + StatusCellBorderW;
    CGFloat nameY = iconY;
    CGSize nameSize = [self sizeWithText:user.name font:StatusCellNameFont];
//    self.nameLabelF = CGRectMake(nameX, nameY, nameSize.width, nameSize.height);
    self.nameLabelF = (CGRect){{nameX, nameY}, nameSize};

    //会员图标
    if (status.user.isVip) {
        CGFloat vipX = CGRectGetMaxX(self.nameLabelF) + StatusCellBorderW;
        CGFloat vipY = nameY;
        CGFloat vipH = nameSize.height;
        CGFloat vipW = 14;
        self.vipViewF = CGRectMake(vipX, vipY, vipW, vipH);
    }
    
    //时间
    CGFloat timeX = nameX;
    CGFloat timeY = CGRectGetMaxY(self.nameLabelF) + StatusCellBorderW;
    CGSize timeSize = [self sizeWithText:status.created_at font:StatusCellTimeFont];
    self.timeLabelF = (CGRect){{timeX, timeY}, timeSize};
   
    //来源
    CGFloat sourceX = CGRectGetMaxX(self.timeLabelF) + StatusCellBorderW;
    CGFloat sourceY = timeY;
    CGSize sourceSize = [self sizeWithText:status.source font:StatusCellSourceFont];
    self.souceLabelF = (CGRect){{sourceX, sourceY}, sourceSize};
    
    //正文
    CGFloat contentX = iconX;
    CGFloat contentY = MAX(CGRectGetMaxY(self.iconViewF), CGRectGetMaxY(self.timeLabelF)) + StatusCellBorderW;
    CGFloat maxW = cellW - 2 * StatusCellBorderW;
    CGSize contentSize = [self sizeWithText:status.text font:StatusCellContentFont maxW:maxW];
    self.contentLabelF = (CGRect){{contentX, contentY}, contentSize};
    
    //配图
    CGFloat originalH = 0;
    if (status.pic_urls.count) {
        CGFloat photoWH = 100;
        CGFloat photoX = contentX;
        CGFloat photoY = CGRectGetMaxY(self.contentLabelF) + StatusCellBorderW;
        self.photoViewF = CGRectMake(photoX, photoY, photoWH, photoWH);
        originalH = CGRectGetMaxY(self.photoViewF) + StatusCellBorderW;
    } else {
        originalH = CGRectGetMaxY(self.contentLabelF) + StatusCellBorderW;
    }
    
    //原创微博整体
    CGFloat originalX = 0;
    CGFloat originalY = 0;
    CGFloat originalW = cellW;
    self.originalViewF = CGRectMake(originalX, originalY, originalW, originalH);

    self.cellHeight = CGRectGetMaxY(self.originalViewF);
    
    
}

@end
