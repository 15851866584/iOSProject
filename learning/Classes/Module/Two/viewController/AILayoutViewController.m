//
//  AILayoutViewController.m
//  learning
//
//  Created by 祥伟 on 2018/12/3.
//  Copyright © 2018年 wanda. All rights reserved.
//

#import "AILayoutViewController.h"

@interface AILayoutViewController ()
@property (weak, nonatomic) IBOutlet UILabel *xibLabel1;
@property (weak, nonatomic) IBOutlet UILabel *xibLabel2;

@property (strong, nonatomic) UILabel *label1;
@property (strong, nonatomic) UILabel *label2;

@property (nonatomic, strong) UISlider *slider;

@end

@implementation AILayoutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.view addSubview:self.slider];
}


- (void)sliderAction:(UISlider *)slider{
    _xibLabel1.font = _xibLabel2.font = AI_SYSTEM_Size((slider.value+0.5)*17);
}

- (UISlider *)slider{
    if (!_slider) {
        _slider = [[UISlider alloc]initWithFrame:CGRectMake(50, ViewHN-100, VW(self.view)-100, 20)];
        _slider.value = 0.5;
        [_slider addTarget:self action:@selector(sliderAction:) forControlEvents:UIControlEventValueChanged];
    }
    return _slider;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
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
