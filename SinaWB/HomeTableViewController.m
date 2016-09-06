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
    
    //load latest data
    [self loadNewStatus];
    
    
    //    SWBLog(@"%@", NSHomeDirectory());
}

-(void)loadNewStatus {
    
    //1.请求管理者
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    
    //2.拼接请求参数
    Account *account = [AccountTool account];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = account.access_token;
    
    //3.发送请求
    [mgr GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *responseObject) {
        
        //将"微博字典"数组转为"微博模型"数组
        self.statuses = [SWStatus mj_objectArrayWithKeyValuesArray:responseObject[@"statuses"]];
        
        //刷新表格
        [self.tableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        SWBLog(@"failure-%@", error);
    }];
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
