//
//  StatusCell.m
//  SinaWB
//
//  Created by 赵麦 on 9/15/16.
//  Copyright © 2016 歹徒. All rights reserved.
//

#import "StatusCell.h"
#import "StatusFrame.h"
#import "SWStatus.h"
#import "SWUser.h"
#import <UIImageView+WebCache.h>

@interface StatusCell ()
//原创微博整体
@property (nonatomic, weak) UIView *originalView;
//头像
@property (nonatomic, weak) UIImageView *iconView;
//会员图标
@property (nonatomic, weak) UIImageView *vipView;
//配图
@property (nonatomic, weak) UIImageView *photoView;
//昵称
@property (nonatomic, weak) UILabel *nameLabel;
//时间
@property (nonatomic, weak) UILabel *timeLabel;
//来源
@property (nonatomic, weak) UILabel *souceLabel;
//正文
@property (nonatomic, weak) UILabel *contentLabel;
@end

@implementation StatusCell

+(instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *ID = @"status";
    StatusCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[StatusCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}


/**
 cell的初始化方法 一个cell只会调用一次
 一般在这里添加所有可能显示的子控件 以及子控件的一次性设置
 */
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // 1.原创微博的整体
        
        //原创微博整体
        UIView *originalView = [[UIView alloc] init];
        [self.contentView addSubview:originalView];
        self.originalView = originalView;
        
        //头像
        UIImageView *iconView = [[UIImageView alloc] init];
        [originalView addSubview:iconView];
        self.iconView = iconView;
        
        //会员图标
        UIImageView *vipView = [[UIImageView alloc] init];
        vipView.contentMode = UIViewContentModeCenter;
        [originalView addSubview:vipView];
        self.vipView = vipView;
        
        //配图
        UIImageView *photoView = [[UIImageView alloc] init];
        [originalView addSubview:photoView];
        self.photoView = photoView;
        
        //昵称
        UILabel *nameLabel = [[UILabel alloc] init];
        nameLabel.font = StatusCellNameFont;
        [originalView addSubview:nameLabel];
        self.nameLabel = nameLabel;
        
        //时间
        UILabel *timeLabel = [[UILabel alloc] init];
        timeLabel.font = StatusCellTimeFont;
        [originalView addSubview:timeLabel];
        self.timeLabel = timeLabel;
        
        //来源
        UILabel *souceLabel = [[UILabel alloc] init];
        souceLabel.font = StatusCellSourceFont;
        [originalView addSubview:souceLabel];
        self.souceLabel = souceLabel;
        
        //正文
        UILabel *contentLabel = [[UILabel alloc] init];
        contentLabel.font = StatusCellContentFont;
        contentLabel.numberOfLines = 0;
        [originalView addSubview:contentLabel];
        self.contentLabel = contentLabel;
        
    }
    return self;
}

-(void)setStatusFrame:(StatusFrame *)statusFrame {
    
    _statusFrame = statusFrame;
    
    SWStatus *status = statusFrame.status;
    SWUser *user = status.user;
    
    //原创微博整体
    self.originalView.frame = statusFrame.originalViewF;
    
    //头像
    self.iconView.frame = statusFrame.iconViewF;
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:user.profile_image_url] placeholderImage:[UIImage imageNamed:@"avatar_default_small"]];
    
    //会员图标
    if (user.isVip) {
        self.vipView.hidden = NO;
        
        self.vipView.frame = statusFrame.vipViewF;
        NSString *vipName = [NSString stringWithFormat:@"common_icon_membership_level%d", user.mbrank];
        self.vipView.image = [UIImage imageNamed:vipName];
        
        self.nameLabel.textColor = [UIColor orangeColor];
        
    } else {
        self.nameLabel.textColor = [UIColor blackColor];
        self.vipView.hidden = YES;
    }
    
    //配图
    self.photoView.frame = statusFrame.photoViewF;
    self.photoView.backgroundColor = [UIColor redColor];
    
    //昵称
    self.nameLabel.text = user.name;
    self.nameLabel.frame = statusFrame.nameLabelF;
    
    //时间
    self.timeLabel.text = status.created_at;
    self.timeLabel.frame = statusFrame.timeLabelF;
    
    //来源
    self.souceLabel.text =status.source;
    self.souceLabel.frame = statusFrame.souceLabelF;
    
    //正文
    self.contentLabel.text = status.text;
    self.contentLabel.frame = statusFrame.contentLabelF;
    
    
}

@end
