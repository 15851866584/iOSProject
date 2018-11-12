//
//  AIBaseTabBarController.m
//  learning
//
//  Created by 祥伟 on 2018/8/3.
//  Copyright © 2018年 wanda. All rights reserved.
//

#import "AIBaseTabBarController.h"

@interface AIBaseTabBarController ()

@end

@implementation AIBaseTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUpViewControllers];

}

- (void)setUpViewControllers{
    
}

- (void)setUpViewControllersInNavClass:(Class)navClass
                             rootClass:(Class)rootClass
                            tabBarName:(NSString *)name
                       tabBarImageName:(NSString *)imageName{
    [self setUpViewControllersInNavClass:navClass rootClass:rootClass tabBarName:name size:AI_SYSTEM_Size(12) color:[UIColor grayColor] selColor:[UIColor darkGrayColor] tabBarImageName:imageName];
}

- (void)setUpViewControllersInNavClass:(Class)navClass
                             rootClass:(Class)rootClass
                            tabBarName:(NSString *)name
                                  size:(UIFont *)size
                                 color:(UIColor *)color
                              selColor:(UIColor *)selColor
                       tabBarImageName:(NSString *)imageName{
    UINavigationController *nav = [[navClass  alloc] initWithRootViewController:[rootClass new]];
    
    nav.title = name;//tabbar
    nav.navigationItem.title = name;//nav
    nav.tabBarItem.image = OrgIMG(imageName);
    NSString *selectedImage = [NSString stringWithFormat:@"%@_sel",imageName];
    nav.tabBarItem.selectedImage = OrgIMG(selectedImage);
    
    [nav.tabBarItem setTitleTextAttributes:
     @{NSForegroundColorAttributeName:color,NSFontAttributeName:size} forState:UIControlStateNormal];
    [nav.tabBarItem setTitleTextAttributes:
     @{NSForegroundColorAttributeName:selColor,NSFontAttributeName:size} forState:UIControlStateSelected];
    [self addChildViewController:nav];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
