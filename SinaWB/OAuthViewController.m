//
//  OAuthViewController.m
//  SinaWB
//
//  Created by 赵麦 on 8/7/16.
//  Copyright © 2016 歹徒. All rights reserved.
//

#import "OAuthViewController.h"
#import <AFNetworking.h>
#import "SWBTabBar.h"
#import "MainTabBarController.h"
#import "NewfeatureViewController.h"
#import "Account.h"
#import <MBProgressHUD.h>
#import "AccountTool.h"

@interface OAuthViewController () <UIWebViewDelegate>

@property (nonatomic, strong) AFHTTPSessionManager *manager;

@end

@implementation OAuthViewController

//- (AFHTTPSessionManager *)manager
//{
//    if (!_manager) {
//        _manager = [AFHTTPSessionManager manager];
//        _manager.responseSerializer.acceptableContentTypes = [_manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/plain"];
//    }
//    return _manager;
//}

-(void)viewDidLoad {
    [super viewDidLoad];
    
    //1.initiate webView
    UIWebView *webView = [[UIWebView alloc] init];
    webView.frame = self.view.bounds;
    webView.delegate = self;
    [self.view addSubview:webView];
    //2.let webView loading sina.com login page
    //https://api.weibo.com/oauth2/authorize?client_id=YOUR_CLIENT_ID&response_type=code&redirect_uri=YOUR_REGISTERED_REDIRECT_URI
    NSURL *url = [NSURL URLWithString:@"https://api.weibo.com/oauth2/authorize?client_id=352767047&response_type=code&redirect_uri=http://baidu.com"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
    
    SWBLog(@"%@", NSHomeDirectory());
    
}

#pragma mark - webViewDelegate
-(void)webViewDidFinishLoad:(UIWebView *)webView {
    //    SWBLog(@"-----webViewDidFinishLoad");
    [MBProgressHUD hideHUDForView:webView animated:YES];
}

-(void)webViewDidStartLoad:(UIWebView *)webView {
    //    SWBLog(@"-----webViewDidStartLoad");
    [MBProgressHUD showHUDAddedTo:webView animated:YES];
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [MBProgressHUD hideHUDForView:webView animated:YES];
}

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    //        SWBLog(@"shouldStartLoadWithRequest--%@", request.URL.absoluteString);
    
    /*拦截url截取code*/
    //1.get url
    NSString *url = request.URL.absoluteString;
    //2.判断是否为回调地址
    NSRange range = [url rangeOfString:@"code="];
    if (range.length != 0) { //是回调地址
        //截取code后的参数值
        long int fromIndex = range.location + range.length;
        NSString *code = [url substringFromIndex:fromIndex];
        //利用code换取accessToken
        [self accessTokenWithCode:code];
        return NO; //band redirectory url
        
        //        SWBLog(@"%@ %@", code, url);
    }
    
    return YES;
}


//利用code(授权成功后的request token)huanquyige accessToken
-(void)accessTokenWithCode:(NSString *)code {
    //1.请求管理者
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    mgr.responseSerializer = [AFJSONResponseSerializer serializer];
    
    //2.拼接请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"client_id"] = @"352767047";
    params[@"client_secret"] = @"d3a5e75512528e31561dc8c7268a48bf";
    params[@"grant_type"] = @"authorization_code";
    params[@"code"] = code;
    params[@"redirect_uri"] = @"http://baidu.com";
    
    //3.发送请求
    [mgr POST:@"https://api.weibo.com/oauth2/access_token" parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        //        SWBLog(@"%@", uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *responseObject) {
        //        SWBLog(@"success-%@", responseObject);
        
        Account *account = [Account accountWithDict:responseObject];
        [AccountTool saveAcoount:account];
        
        //switch rootViewController
        NSString *key = @"CFBundleVersion";
        //存储在沙盒中的last version
        NSString *lastVersion = [[NSUserDefaults standardUserDefaults] objectForKey:key];
        //Info.plist current version
        NSString *currentVersion = [NSBundle mainBundle].infoDictionary[key];
        //    SWBLog(@"%@", currentVersion);
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        if ([currentVersion isEqualToString:lastVersion]) {
            window.rootViewController = [[MainTabBarController alloc] init];
        } else {
            window.rootViewController = [[NewfeatureViewController alloc] init];
            
            //将current version 存进沙盒
            [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:key];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //        SWBLog(@"failure-%@", error.description);
        [MBProgressHUD hideAllHUDsForView:nil animated:YES];
    }];
}
@end
