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

/**
 *  数据源数组
 */
@property (strong ,nonatomic ,readonly) NSArray *newsInfoArray;
/**
 *  URL
 */
@property (copy , nonatomic, readonly) NSString *baseUrl;
/**
 *  主色
 */
@property (strong ,nonatomic ,readonly) UIColor *appBaseColor;

@end
