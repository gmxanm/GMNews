//
//  GMTabBarBaseVC.m
//  GMNews
//
//  Created by Gmxanm on 16/3/21.
//  Copyright © 2016年 Xnmawc. All rights reserved.
//

#import "GMTabBarBaseVC.h"
#import "GMAppStatus.h"

@interface GMTabBarBaseVC ()

@end

@implementation GMTabBarBaseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[UITabBar appearance] setTintColor:AppStatus.appBaseColor];
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
