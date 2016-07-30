//
//  self.m
//  SinaWB
//
//  Created by 赵麦 on 7/30/16.
//  Copyright © 2016 歹徒. All rights reserved.
//

#import "SearchBar.h"

@implementation SearchBar

-(id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.font = [UIFont systemFontOfSize:15];
        self.placeholder = @"请输入搜索条件";
        self.background = [UIImage imageNamed:@"searchbar_textfield_background"];
        
        UIImageView *searchIcon = [[UIImageView alloc] init]; // no size
        searchIcon.image = [UIImage imageNamed:@"searchbar_textfield_search_icon"];
        
        searchIcon.width = 30;
        searchIcon.height = 30;
        searchIcon.contentMode = UIViewContentModeCenter; //居中
        self.leftView = searchIcon;
        self.leftViewMode = UITextFieldViewModeAlways;

    }
    return self;
}

+(instancetype)searchBar {
    return [[self alloc] init];
}

//DiscoverTVC.m
//- (void)viewDidLoad {
//    [super viewDidLoad];
//    
//    //    UISearchBar *searchBar = [[UISearchBar alloc] init];
//    //    searchBar.height = 30; //发现不能修改系统自带searchBar 所以需要自定义
//    //    searchBar.scopeBarBackgroundImage = [UIImage imageNamed:@"searchbar_textfield_background"];
//    //    self.navigationItem.titleView = searchBar;
//    UITextField *searchBar = [[UITextField alloc] init];
//    
//    //create search bar
//    searchBar.width = 300;
//    searchBar.height = 30;
//    searchBar.font = [UIFont systemFontOfSize:15];
//    searchBar.placeholder = @"请输入搜索条件";
//    searchBar.background = [UIImage imageNamed:@"searchbar_textfield_background"];
//    
//    //set left bar icon
//    //    UIImage *image = [UIImage imageNamed:@"searchbar_textfield_background"];
//    //通过initWithImage创建初始化UIImageView 其尺寸默认等于image尺寸
//    //    UIImageView *searchIcon = [[UIImageView alloc] initWithImage:image]; // default size
//    //通过init创建初始化绝大部分控件 没有尺寸
//    UIImageView *searchIcon = [[UIImageView alloc] init]; // no size
//    searchIcon.image = [UIImage imageNamed:@"searchbar_textfield_search_icon"];
//    
//    searchIcon.width = 30;
//    searchIcon.height = 30;
//    searchIcon.contentMode = UIViewContentModeCenter; //居中
//    searchBar.leftView = searchIcon;
//    searchBar.leftViewMode = UITextFieldViewModeAlways;
//    
//    self.navigationItem.titleView =searchBar;
//    
//    //    SWBLog(@"DiscoverTableViewController viewDidLoad");
//}


@end
