//
//  GMNewsVC.m
//  GMNews
//
//  Created by Gmxanm on 16/3/29.
//  Copyright © 2016年 Xnmawc. All rights reserved.
//

#import "GMNewsVC.h"

@interface GMNewsVC()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation GMNewsVC

- (void)viewDidLoad{
    [super viewDidLoad];
    
    _titleLabel.text = self.title;
}

@end
