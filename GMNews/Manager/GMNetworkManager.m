//
//  GMNetworkManager.m
//  GMNews
//
//  Created by Gmxanm on 16/3/21.
//  Copyright © 2016年 Xnmawc. All rights reserved.
//

#import "GMNetworkManager.h"
#import "GMNewsEntity.h"

@implementation GMNetworkManager

#pragma mark -- Init

+ (instancetype)shareInstanceWithBaseUrl:(NSString *)url {
    static GMNetworkManager *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        NSURLSessionConfiguration *urlSessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
        instance = [[self alloc]initWithBaseURL:[NSURL URLWithString:url] sessionConfiguration:urlSessionConfig];
        instance.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];
    });
    
    return instance;
}

+ (instancetype)shareInstanceWithoutBaseUrl {
    static GMNetworkManager *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        NSURLSessionConfiguration *urlSessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
        
        instance = [[self alloc]initWithSessionConfiguration:urlSessionConfig];
        instance.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];
    });
    
    return instance;
}

//#pragma mark -- NewsArray
//
//- (void)newsArrayWithUrl:(NSString *)url {
//    __block NSMutableArray *newsArray = nil;
//    @WeakObj(self);
//    [[GMNetworkManager shareInstanceWithBaseUrl:AppStatus.baseUrl]GET:@"/nc/article/headline/T1348647853363/0-20.html" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        @StrongObj(self);
//        if ([responseObject isKindOfClass:[NSDictionary class]]) {
//            NSDictionary *newsDic = (NSDictionary *)responseObject;
//            NSString *key = [newsDic.keyEnumerator nextObject];
//            NSArray *dicArray = [newsDic objectForKey:key];
//            for (NSDictionary *dic in dicArray) {
//                GMNewsEntity *news = [GMNewsEntity modelWithDictionary:dic];
//                [newsArray addObject:news];
//            }
//            self.newsArray = newsArray;
//        }
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        
//        NSLog(@"Get news failed");
//    }];
//}


@end
