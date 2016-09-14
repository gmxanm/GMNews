//
//  GMNewsDetailVC.m
//  GMNews
//
//  Created by Gmxanm on 25/4/16.
//  Copyright © 2016 Xnmawc. All rights reserved.
//

#import "GMNewsDetailVC.h"
#import "UINavigationController+FDFullscreenPopGesture.h"

@interface GMNewsDetailVC ()

@property (weak, nonatomic) IBOutlet UIWebView *webView;

- (IBAction)popToNewsVC:(id)sender;

@end

@implementation GMNewsDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.fd_prefersNavigationBarHidden = YES;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
     [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
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

#pragma mark -- Action Event

- (IBAction)popToNewsVC:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
