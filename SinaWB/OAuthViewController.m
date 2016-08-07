//
//  OAuthViewController.m
//  SinaWB
//
//  Created by 赵麦 on 8/7/16.
//  Copyright © 2016 歹徒. All rights reserved.
//

#import "OAuthViewController.h"

@interface OAuthViewController () <UIWebViewDelegate>

@end

@implementation OAuthViewController

-(void)viewDidLoad {
    [super viewDidLoad];
    
    //1.initiate webView
    UIWebView *webView = [[UIWebView alloc] init];
    webView.frame = self.view.bounds;
    webView.delegate = self;
    [self.view addSubview:webView];
    //2.let webView loading sina.com login page
    //https://api.weibo.com/oauth2/authorize?client_id=YOUR_CLIENT_ID&response_type=code&redirect_uri=YOUR_REGISTERED_REDIRECT_URI
    NSURL *url = [NSURL URLWithString:@"https://api.weibo.com/oauth2/authorize?client_id=352767047&response_type=code&redirect_uri=http://"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
    
}

#pragma mark - webViewDelegate
-(void)webViewDidFinishLoad:(UIWebView *)webView {
    SWBLog(@"-----webViewDidFinishLoad");
}

-(void)webViewDidStartLoad:(UIWebView *)webView {
    SWBLog(@"-----webViewDidStartLoad");
}

@end
