
//
//  GMTitleLabel.m
//  GMNews
//
//  Created by Gmxanm on 16/3/22.
//  Copyright © 2016年 Xnmawc. All rights reserved.
//

#import "GMTitleLabel.h"

@implementation GMTitleLabel

- (instancetype)initWithTitle:(NSString *)title {
    if (self = [super init]) {
        self.text = title;
        self.textAlignment = NSTextAlignmentCenter;
        self.font = [UIFont systemFontOfSize:21.0];
        self.userInteractionEnabled = YES;
        self.scale = 0.0;
    }
    return self;
}

- (instancetype)init {
    if (self = [super init]) {
        self.textAlignment = NSTextAlignmentCenter;
        self.font = [UIFont systemFontOfSize:21.0];
        self.userInteractionEnabled = YES;
        self.scale = 0.0;
    }
    return self;
}

#pragma mark -- Setter

- (void)setScale:(CGFloat)scale {
    _scale = scale;
    
    self.textColor = [UIColor colorWithRed:scale green:0 blue:0 alpha:.6];
    
    CGFloat minScale = 0.7;
    CGFloat trueScale = minScale + (1-minScale)*scale;
    self.transform = CGAffineTransformMakeScale(trueScale, trueScale);
}

@end
