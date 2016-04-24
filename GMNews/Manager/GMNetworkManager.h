//
//  GMNetworkManager.h
//  GMNews
//
//  Created by Gmxanm on 16/3/21.
//  Copyright © 2016年 Xnmawc. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

@interface GMNetworkManager : AFHTTPSessionManager
/**
 *  NewsArray
 */
@property (strong, nonatomic) NSArray *newsArray;

+ (instancetype)shareInstanceWithBaseUrl:(NSString *)url;

+ (instancetype)shareInstanceWithoutBaseUrl;

/**
 * Get news array;
 */

//- (void)newsArrayWithUrl:(NSString *)url;

@end
