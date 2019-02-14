//
//  AIGetHeightViewController.m
//  learning
//
//  Created by 祥伟 on 2018/12/19.
//  Copyright © 2018年 wanda. All rights reserved.
//

#import "AIGetHeightViewController.h"

@interface AIGetHeightViewController ()

@end

@implementation AIGetHeightViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    NSAttributedString * attrStr = [[NSAttributedString alloc] initWithData:[[self defineHTML] dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
    UITextView *textView = [[UITextView alloc]initWithFrame:CGRectMake(15, 50, SCREEN_WIDTH-30, 0)];
    CGFloat height = [UITextView getTextViewHeightWithAttributedString:attrStr width:SCREEN_WIDTH-30];
    textView.height = height;
    textView.backgroundColor = [UIColor redColor];
    textView.attributedText = attrStr;
    textView.selectable = NO;
    textView.bounces = NO;
    [self.view addSubview:textView];
    
}

- (NSString *)defineHTML{
    return @"<h1>尊敬的用户</h1><p class=MsoNormal><span style='font-family:宋体'>由于您此前申请的借款测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试</span></p><p class=MsoNormal><span style='font-family:宋体'>现本app已关闭您的还款功能测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试</span></p><h2>如有疑问或协商还款可咨询：</h2><p class=MsoNormal><span style='font-family:宋体'>北极资产客服热线：400-880-7733,181-2006-2007 或关注微信公众号：北极资产</span></p>";
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
