//
//  AITextInputViewController.m
//  learning
//
//  Created by 祥伟 on 2019/1/18.
//  Copyright © 2019年 wanda. All rights reserved.
//

#import "AITextInputViewController.h"

@interface AITextInputViewController ()<UITextFieldDelegate>
@property (nonatomic, strong) UITextField *textField;
@end

@implementation AITextInputViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.textField = [[UITextField alloc]initWithFrame:CGRectMake(50, 100, SCREEN_WIDTH-100, 50)];
    self.textField.delegate = self;
    self.textField.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.textField];
    
//    UIPasteboard *pd = [UIPasteboard generalPasteboard];
     [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(posted:) name:UIMenuControllerDidHideMenuNotification object:nil];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    return YES;
}

- (void)posted:(NSNotification*)s{
    DLog(@"%@",s.userInfo);
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    DLog(@"%@",string);
    return YES;
}

@end
