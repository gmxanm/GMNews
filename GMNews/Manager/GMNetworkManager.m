//
//  GMNetworkManager.m
//  GMNews
//
//  Created by Gmxanm on 16/3/21.
//  Copyright © 2016年 Xnmawc. All rights reserved.
//

#import "GMNetworkManager.h"

static NSString *urlString = @"http://c.m.163.com/";

@implementation GMNetworkManager

+ (instancetype)shareInstance
{
    static GMNetworkManager *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        NSURL *url = [NSURL URLWithString:urlString];
        NSURLSessionConfiguration *urlSessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
        
        instance = [[self alloc]initWithBaseURL:url sessionConfiguration:urlSessionConfig];
        instance.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];
    });
    
    return instance;
}

@end
