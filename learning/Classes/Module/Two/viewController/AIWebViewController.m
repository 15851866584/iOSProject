//
//  AIWebViewController.m
//  learning
//
//  Created by 祥伟 on 2018/12/5.
//  Copyright © 2018年 wanda. All rights reserved.
//

#import "AIWebViewController.h"
#import <WebKit/WebKit.h>

@interface AIWebViewController ()<WKNavigationDelegate,WKUIDelegate>
@property (nonatomic, strong) WKWebView *webView;

@end

@implementation AIWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.webView = [[WKWebView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-AI_TabbarHeight)];
//    self.webView.navigationDelegate = self;
//    self.webView.UIDelegate = self;
    
    [self.view addSubview:self.webView];
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.jianshu.com/u/1ce8edc3912f"]]];
}


#pragma - mark WKNavigationDelegate,WKUIDelegate
//- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
//    decisionHandler(WKNavigationActionPolicyAllow);
//}
//
//- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
//    
//    self.navigationItem.title = self.webView.title;
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
