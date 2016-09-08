//
//  HomeTableViewController.m
//  SinaWB
//
//  Created by 赵麦 on 7/20/16.
//  Copyright © 2016 歹徒. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "HomeTableViewController.h"
#import "SearchBar.h"
#import "DropdownMenu.h"
#import "TitleMenuTVC.h"
#import <AFNetworking.h>
#import "AccountTool.h"
#import <MBProgressHUD.h>
#import "TitleButton.h"
#import <UIImageView+WebCache.h>
#import "SWUser.h"
#import "SWStatus.h"
#import "MJExtension/MJExtension.h"
#import "LoadMoreFooter.h"

@interface HomeTableViewController () <DropdownMenuDelegate>
//一个字典代表一条微博 -> 数组里面放的是status模型
@property (nonatomic, strong) NSMutableArray *statuses;

@end

@implementation HomeTableViewController

- (NSMutableArray *)statuses {
    if (!_statuses) {
        self.statuses = [[NSMutableArray alloc] init];
    }
    return _statuses;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    //set nav content
    [self setupNav];
    
    //get user info (昵称)
    [self setupUserInfo];
    
    //集成刷新控件
    [self setupDownRefresh];
    
    //集成上拉刷新
    [self setupUpRefresh];
    
    //获得未读数
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(setupUnreadCount) userInfo:nil repeats:YES];
    //主线程也会抽时间处理一下timer (不管主线程是否正在处理其他事件)
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    
    //    SWBLog(@"%@", NSHomeDirectory());
}

/**
 *  获得未读数
 */
-(void)setupUnreadCount {
    
    //1.请求管理者
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    
    //2.拼接请求参数
    Account *account = [AccountTool account];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = account.access_token;
    params[@"uid"] = account.uid;
    
    //3.发送请求
    [mgr GET:@"https://rm.api.weibo.com/2/remind/unread_count.json" parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *responseObject) {
        //微博的未读数
        //       int status = [responseObject[@"status"] intValue];
        //设置提醒数字
        //        self.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d", status];
        
        NSString *status = [responseObject[@"status"] description];
        if ([status isEqualToString:@"0"]) {
            //如果是零 清空现有数字
            self.tabBarItem.badgeValue = nil;
            [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
        } else {
            self.tabBarItem.badgeValue = status;
//            UIUserNotificationSettings *settings = [UIUserNotificationSettings
//                                                    settingsForTypes:UIUserNotificationTypeBadge categories:nil];
//            
//            [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
            [UIApplication sharedApplication].applicationIconBadgeNumber = status.intValue;
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        SWBLog(@"failure-%@", error);
    }];
}

/**
 *  集成上拉刷新控件
 */
-(void)setupUpRefresh {
    LoadMoreFooter *footer = [LoadMoreFooter footer];
    footer.hidden = YES;
    self.tableView.tableFooterView = footer;
}

/**
 *  集成下拉刷新控件
 */
-(void)setupDownRefresh {
    
    //添加刷新控件
    UIRefreshControl *control = [[UIRefreshControl alloc] init];
    //手动下拉触发
    [control addTarget:self action:@selector(loadNewStatus:) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:control];
    
    //2.立即进入刷新状态 (进显示刷新菊花 不会触发UIControlEventValuewChanged事件)
    [control beginRefreshing];
    
    //3.立即加载数据
    [self loadNewStatus:control];
}
/**
 *  UIRefreshControl进入刷新状态:加载最新数据
 */
-(void)loadNewStatus:(UIRefreshControl *)control {
    
    //1.请求管理者
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    
    //2.拼接请求参数
    Account *account = [AccountTool account];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = account.access_token;
    
    //取出最前面的微博(最新微博 since_id最大的微博)
    SWStatus *firstStatus = [self.statuses firstObject];
    if (firstStatus) {
        //若指定此参数，则返回ID比since_id大的微博（即比since_id时间晚的微博），默认为0。
        params[@"since_id"] = firstStatus.idstr;
    }
    
    //3.发送请求
    [mgr GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *responseObject) {
        
        //将"微博字典"数组转为"微博模型"数组
        NSArray *newStatuses = [SWStatus mj_objectArrayWithKeyValuesArray:responseObject[@"statuses"]];
        
        //将最新的微博数据添加到总数组的最前前前前前面
        NSRange range = NSMakeRange(0, newStatuses.count);
        NSIndexSet *set = [NSIndexSet indexSetWithIndexesInRange:range];
        [self.statuses insertObjects:newStatuses atIndexes:set];
        
        //刷新表格
        [self.tableView reloadData];
        
        //结束刷新
        [control endRefreshing];
        
        //显示最新微博数量
        [self showNewStatusCount:newStatuses.count];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        SWBLog(@"failure-%@", error);
        //结束刷新
        [control endRefreshing];
    }];
    
}

-(void)loadMoreStatus {
    //1.请求管理者
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    
    //2.拼接请求参数
    Account *account = [AccountTool account];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = account.access_token;
    
    SWStatus *lastStatus = [self.statuses lastObject];
    if (lastStatus) {
        long long maxId = lastStatus.idstr.longLongValue - 1;
        params[@"max_id"] = @(maxId);
    }
    
    //3.发送请求
    [mgr GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *responseObject) {
        
        //将"微博字典"数组转为"微博模型"数组
        NSArray *newStatuses = [SWStatus mj_objectArrayWithKeyValuesArray:responseObject[@"statuses"]];
        
        //将之前的微博数据添加到总数组的最后面
        [self.statuses addObjectsFromArray:newStatuses];
        
        //刷新表格
        [self.tableView reloadData];
        
        self.tableView.tableFooterView.hidden = YES;
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        SWBLog(@"failure-%@", error);
        
        self.tableView.tableFooterView.hidden = YES;
    }];

}

/**
 *  显示最新微博数量
 *
 *  @param count 最新微博的数量
 */
-(void)showNewStatusCount:(int)count {
    //刷新成功 清空未读数字
    self.tabBarItem.badgeValue = nil;
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    
    //1.create label
    UILabel *label = [[UILabel alloc] init];
    label.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"timeline_new_status_background"]];
    label.width = [UIScreen mainScreen].bounds.size.width;
    label.height = 35;
    
    //2.set other attributes
    if (count == 0) {
        label.text = @"没有新的微博, 请稍后再试";
    } else {
        label.text = [NSString stringWithFormat:@"共有%d条新的微博", count];
    }
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:16];
    
    //3.添加
    label.y = 64 - label.height;
    //将label添加到导航控制器的View中 并隐藏在导航栏的下层
    [self.navigationController.view insertSubview:label belowSubview:self.navigationController.navigationBar];
    //4.动画
    CGFloat duration = 1.0; //动画过程/路径时长
    [UIView animateWithDuration:duration animations:^{
        //        label.y += label.height;
        label.transform = CGAffineTransformMakeTranslation(0, label.height);
    } completion:^(BOOL finished) {
        CGFloat delay = 1.0; //动画延迟 停留显现时长
        [UIView animateWithDuration:duration delay:delay options:UIViewAnimationOptionCurveLinear animations:^{
            //            label.y -= label.height;
            label.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            [label removeFromSuperview];
        }];
    }];
    
    //如果动画执行完回到执行前状态 建议使用transform做动画
    
}

-(void)setupUserInfo {
    
    //1.请求管理者
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    
    //2.拼接请求参数
    Account *account = [AccountTool account];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = account.access_token;
    params[@"uid"] = account.uid;
    
    //3.发送请求
    [mgr GET:@"https://api.weibo.com/2/users/show.json" parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        //        SWBLog(@"%@", uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *responseObject) {
        
        //标题按钮
        TitleButton *titleBtn = (TitleButton *)self.navigationItem.titleView;
        
        //设置名字
        SWUser *user = [SWUser mj_objectWithKeyValues:responseObject];
        [titleBtn setTitle:user.name forState:UIControlStateNormal];
        
        //存储昵称到沙盒
        account.name = user.name;
        [AccountTool saveAcoount:account];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        SWBLog(@"failure-%@", error);
    }];
    
}

-(void)setupNav {
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(friendSearch) image:@"navigationbar_friendsearch" highImage:@"navigationbar_friendsearch_highlighted"];
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(pop) image:@"navigationbar_pop" highImage:@"navigationbar_pop_highlighted"];
    
    /* title button */
    TitleButton *titleBtn = [[TitleButton alloc] init];
    
    //set image and font
    NSString *name = [AccountTool account].name;
    [titleBtn setTitle:name?name:@"首页" forState:UIControlStateNormal];
    
    //监听标题点击
    [titleBtn addTarget:self action:@selector(titleClick: ) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView = titleBtn;
    
    //按钮内部图片文字固定时建议使用imageEdgeInsets titleEdgeInsets设置间距
    //标题宽度
    //    CGFloat titleW = titleBtn.titleLabel.width;
    //    //乘上scale系数 保证retina屏幕上宽度正确
    //    CGFloat imageW = titleBtn.imageView.width * [UIScreen mainScreen].scale;
    //    CGFloat left = titleW + imageW;
    //    titleBtn.imageEdgeInsets = UIEdgeInsetsMake(0, left, 0, 0);
    
}

-(void)titleClick:(UIButton *)titleBtn {
    
    //1.set dropdownmenu
    DropdownMenu *menu = [DropdownMenu menu];
    menu.delegate = self;
    
    //2.set content
    //    menu.content = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 0, 100)];
    TitleMenuTVC *vc = [[TitleMenuTVC alloc] init];
    vc.view.height = 44 * 3;
    vc.view.width = 150;
    menu.contentController = vc;
    
    //3.show
    [menu showFrom:titleBtn];
    
}

-(void)friendSearch {
    SWBLog(@"friendSearch");
}

-(void)pop {
    SWBLog(@"pop");
}

#pragma mark - DropdownMenuDelegate
-(void)dropdownMenuDidDismiss:(DropdownMenu *)menu {
    UIButton *titleBtn = (UIButton *) self.navigationItem.titleView;
    titleBtn.selected = NO;
    //    [titleBtn setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
    
}

-(void)dropdownMenuDidShow:(DropdownMenu *)menu {
    UIButton *titleBtn = (UIButton *) self.navigationItem.titleView;
    titleBtn.selected = YES;
    //    [titleBtn setImage:[UIImage imageNamed:@"navigationbar_arrow_up"] forState:UIControlStateNormal];
    
}

#pragma mark - Table view data source

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.statuses.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"status";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    
    //取出这行对应的微博字典 ->微博字典模型
    //    NSDictionary *status = self.statuses[indexPath.row];
    SWStatus  *status = self.statuses[indexPath.row];
    
    //取出这条微博的作者(用户)
    //    NSDictionary *user = status[@"user"];
    //    cell.textLabel.text = user[@"name"];
    SWUser *user = status.user;
    cell.textLabel.text = user.name;
    
    //设置微博的文字
    //    cell.detailTextLabel.text = status[@"text"];
    cell.detailTextLabel.text = status.text;
    
    //设置头像
    //    NSString *imageUrl = user[@"profile_image_url"];
    NSString *imageUrl = user.profile_image_url;
    UIImage *placehoder = [UIImage imageNamed:@"avatar_default_small"];
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:placehoder];
    //    SWBLog(@"%@",user);
    
    return cell;
}


@end
