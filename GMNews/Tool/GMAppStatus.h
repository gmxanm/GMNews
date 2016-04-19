//
//  GMAppStatus.h
//  GMNews
//
//  Created by Gmxanm on 16/3/22.
//  Copyright © 2016年 Xnmawc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface GMAppStatus : NSObject

+ (instancetype)shareInstance;

@property (strong ,nonatomic ,readonly) UIColor *appBaseColor;

@property (strong ,nonatomic ,readonly) NSDictionary *appInfoDic;

@property (strong ,nonatomic ,readonly) NSArray *newsInfoArray;


@end
