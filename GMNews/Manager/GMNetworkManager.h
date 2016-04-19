//
//  GMNetworkManager.h
//  GMNews
//
//  Created by Gmxanm on 16/3/21.
//  Copyright © 2016年 Xnmawc. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

@interface GMNetworkManager : AFHTTPSessionManager

+ (instancetype)shareInstance;

@end
