//
//  StatusCell.h
//  SinaWB
//
//  Created by 赵麦 on 9/15/16.
//  Copyright © 2016 歹徒. All rights reserved.
//

#import <UIKit/UIKit.h>
@class StatusFrame;

@interface StatusCell : UITableViewCell

+(instancetype)cellWithTableView:(UITableView *)tableView;

@property (nonatomic, strong) StatusFrame *statusFrame;

@end
