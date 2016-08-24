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

@interface HomeTableViewController () <DropdownMenuDelegate>

@end

@implementation HomeTableViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    //set nav content
    [self setupNav];
    
    //get user info (昵称)
    [self setupUserInfo];
    
    //    SWBLog(@"%@", NSHomeDirectory());
    
}

-(void)setupUserInfo {
    
    //    https://api.weibo.com/2/users/show.json
    //    access_token	true	string	采用OAuth授权方式为必填参数，OAuth授权后获得。
    //    uid
    //    GET
    
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
        //        SWBLog(@"success-%@", responseObject);
        //标题按钮
        UIButton *titleBtn = (UIButton *)self.navigationItem.titleView;
        //设置名字
        NSString *name = responseObject[@"name"];
        [titleBtn setTitle:name forState:UIControlStateNormal];
        
        //存储昵称到沙盒
        account.name = name;
        [AccountTool saveAcoount:account];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        SWBLog(@"failure-%@", error);
    }];
    
}

-(void)setupNav {
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(friendSearch) image:@"navigationbar_friendsearch" highImage:@"navigationbar_friendsearch_highlighted"];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(pop) image:@"navigationbar_pop" highImage:@"navigationbar_pop_highlighted"];
    
    /* title button */
    //    UIButton *titleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIButton *titleBtn = [[UIButton alloc] init];
    titleBtn.width = 150;
    titleBtn.height = 30;
    
    //set image and font
    NSString *name = [AccountTool account].name;
    [titleBtn setTitle:name?name:@"首页" forState:UIControlStateNormal];
    [titleBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    titleBtn.titleLabel.font = [UIFont boldSystemFontOfSize:17];
    [titleBtn setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
    [titleBtn setImage:[UIImage imageNamed:@"navigationbar_arrow_up"] forState:UIControlStateSelected];
    
    titleBtn.backgroundColor = [UIColor redColor];
    titleBtn.imageView.backgroundColor = [UIColor yellowColor];
    titleBtn.titleLabel.backgroundColor = [UIColor colorWithRed:0 green:0 blue:1.0 alpha:0.2];
    
//    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
//    attrs[NSFontAttributeName] = titleBtn.titleLabel.font;
//    CGFloat titleW = [titleBtn.currentTitle sizeWithAttributes:attrs].width;
    CGFloat titleW = titleBtn.titleLabel.width;
    //乘上scale系数 保证retina屏幕上宽度正确
    CGFloat imageW = titleBtn.imageView.width * [UIScreen mainScreen].scale;
    CGFloat left = titleW + imageW;
    
    titleBtn.imageEdgeInsets = UIEdgeInsetsMake(0, left, 0, 0);
    
    //监听标题点击
    [titleBtn addTarget:self action:@selector(titleClick: ) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView = titleBtn;
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

@end
