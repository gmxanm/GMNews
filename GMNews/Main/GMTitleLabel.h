//
//  GMTitleLabel.h
//  GMNews
//
//  Created by Gmxanm on 16/3/22.
//  Copyright © 2016年 Xnmawc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GMTitleLabel : UILabel

- (instancetype)init;

- (instancetype)initWithTitle:(NSString *)title;

@property (assign, nonatomic) CGFloat scale;

@end
