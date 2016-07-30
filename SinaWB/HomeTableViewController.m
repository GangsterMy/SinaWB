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

@interface HomeTableViewController ()

@end

@implementation HomeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(friendSearch) image:@"navigationbar_friendsearch" highImage:@"navigationbar_friendsearch_highlighted"];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(pop) image:@"navigationbar_pop" highImage:@"navigationbar_pop_highlighted"];
    
    SearchBar *searchBar = [SearchBar searchBar];
    searchBar.width = 300;
    searchBar.height = 30;
    
    [self.view addSubview:searchBar];
    
//    SWBLog(@"HomeTableViewController viewDidLoad");
}

-(void)friendSearch {
    SWBLog(@"friendSearch");
}

-(void)pop {
    NSLog(@"pop");
}

@end
