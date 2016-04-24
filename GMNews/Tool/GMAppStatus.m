


//
//  GMAppStatus.m
//  GMNews
//
//  Created by Gmxanm on 16/3/22.
//  Copyright © 2016年 Xnmawc. All rights reserved.
//

#import "GMAppStatus.h"
#import "UIColor+HexString.h"

@interface GMAppStatus()

/**
 *  主要参数字典
 */
@property (strong ,nonatomic ,readonly) NSDictionary *appInfoDic;

@end

@implementation GMAppStatus

+ (instancetype)shareInstance {
    
    static GMAppStatus *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [self new];
    });
    
    return instance;
}

#pragma mark -- Getter

-(NSDictionary *)appInfoDic {
    
    return [[NSDictionary alloc]initWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"AppBaseInfo" ofType:@"plist"]];
}

- (NSArray *)newsInfoArray {
    
    return [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"NewsURLs" ofType:@"plist"]];
}

- (UIColor *)appBaseColor {
    
    NSString *colorStr = [self.appInfoDic objectForKey:@"AppBaseColor"];
    UIColor *baseColor = [UIColor colorWithHexString:colorStr];

    return baseColor;
}

- (NSString *)baseUrl {

    NSString *url = [self.appInfoDic objectForKey:@"AppBaseUrl"];
 
    return url;
}

@end
