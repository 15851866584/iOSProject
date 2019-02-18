//
//  WeChatSearchController.m
//  learning
//
//  Created by 祥伟 on 2019/2/15.
//  Copyright © 2019年 wanda. All rights reserved.
//

#import "WeChatSearchController.h"
#import "WeChatSearchResultController.h"

@interface WeChatSearchController ()

@end

@implementation WeChatSearchController

+ (WeChatSearchController *)initSearchController{
    WeChatSearchResultController *resultContoller = [[WeChatSearchResultController alloc]init];
    
    WeChatSearchController *searchController = [[WeChatSearchController alloc]initWithSearchResultsController:resultContoller];
    searchController.searchResultsUpdater = resultContoller;
 
    return searchController;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = WeChatRGB241;
    
    [[UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[UISearchBar class]]] setTintColor:WeChatRGB40];
    [[UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[UISearchBar class]]] setTitle:@"取消"];
    self.searchBar.tintColor = [UIColor greenColor];
   
}

//MLeakFinder白名单
- (BOOL)willDealloc {
    return YES;
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
