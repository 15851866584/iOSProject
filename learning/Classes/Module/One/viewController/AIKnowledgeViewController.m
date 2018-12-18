//
//  AIKnowledgeViewController.m
//  learning
//
//  Created by 祥伟 on 2018/8/20.
//  Copyright © 2018年 wanda. All rights reserved.
//

#import "AIKnowledgeViewController.h"
#import "Knowledge.h"
@interface AIKnowledgeViewController ()

@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, strong) UISlider *slider;

@end

@implementation AIKnowledgeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.navigationItem.title = self.navTitle;
    [self.view addSubview:self.textView];
    [self.view addSubview:self.slider];
    self.textView.text = [Knowledge showKnowledge:self.navTitle];    
   
}

//static void resolveMethod(id self,SEL sel,id value){
//    NSLog(@"resolveMethod");
//}
//
//+ (BOOL)resolveInstanceMethod:(SEL)sel{
//    NSLog(@"1");
//    if (![self respondsToSelector:sel]) {
//        class_addMethod([self class], sel, (IMP)resolveMethod, "v@:@");
//        return YES;
//    }
//    return [super resolveInstanceMethod:sel];
//}
//- (id)forwardingTargetForSelector:(SEL)aSelector{
//    NSLog(@"2");
//    return [super forwardingTargetForSelector:aSelector];
//}
//
//- (void)forwardInvocation:(NSInvocation *)anInvocation{
//    NSLog(@"4");
//}
//
//
//- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector{
//    NSLog(@"3");
//    NSMethodSignature *methodSignature = [NSMethodSignature methodSignatureForSelector:aSelector];
//    if (!methodSignature) {
//        methodSignature = [NSMethodSignature signatureWithObjCTypes:"v@:@"];
//    }
//    return methodSignature;
//}


- (void)sliderAction:(UISlider *)slider{
    _textView.font = AI_SYSTEM_Size((slider.value+1)*12);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UITextView *)textView{
    if (!_textView) {
        _textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, VW(self.view), ViewHN-60)];
        _textView.font = AI_SYSTEM_Size(12);
    }
    return _textView;
}

- (UISlider *)slider{
    if (!_slider) {
        _slider = [[UISlider alloc]initWithFrame:CGRectMake(50, ViewHN-40, VW(self.view)-100, 10)];
        [_slider addTarget:self action:@selector(sliderAction:) forControlEvents:UIControlEventValueChanged];
    }
    return _slider;
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
