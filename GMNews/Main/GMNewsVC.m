//
//  GMNewsVC.m
//  GMNews
//
//  Created by Gmxanm on 16/3/29.
//  Copyright © 2016年 Xnmawc. All rights reserved.
//

#import "GMNewsVC.h"
#import "GMNetworkManager.h"
#import "GMNewsCell.h"
#import "MJRefresh.h"

@interface GMNewsVC()<UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) NSMutableArray *newsArray;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation GMNewsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self loadNews];
    }];
    _tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self loadMoreNews];
    }];
    
    [_tableView.mj_header beginRefreshing];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

#pragma mark -- UITableViewDelegate && UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _newsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GMNewsEntity *newEntity = _newsArray[indexPath.row];
    GMNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:[GMNewsCell idForRow:newEntity] forIndexPath:indexPath];
    cell.model = newEntity;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    GMNewsEntity *newEntity = _newsArray[indexPath.row];
    CGFloat height = [GMNewsCell heightForRow:newEntity];
    return height;
}

#pragma mark -- Private

- (void)loadMoreNews {
    NSString *url = [NSString stringWithFormat:@"/nc/article/%@/%ld-20.html",_urlStr,_newsArray.count - _newsArray.count%10];
    [self fetchNewsWithUrl:url type:1];
}

- (void)loadNews {
    if (!_newsArray) {
        _newsArray = [NSMutableArray array];
    }
    NSString *url = [NSString stringWithFormat:@"/nc/article/%@/0-20.html",_urlStr];
    
    [self fetchNewsWithUrl:url type:0];
}

- (void)fetchNewsWithUrl:(NSString *)urlStr type:(NSInteger)type {
    @WeakObj(self);
    __block NSMutableArray *newsArray = [NSMutableArray array];
    [[GMNetworkManager shareInstanceWithBaseUrl:AppStatus.baseUrl]GET:urlStr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        @StrongObj(self);
        NSLog(@"%@",responseObject);
        
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            NSDictionary *newsDic = (NSDictionary *)responseObject;
            NSString *key = [newsDic.keyEnumerator nextObject];
            NSArray *dicArray = [newsDic objectForKey:key];
            for (NSDictionary *dic in dicArray) {
                GMNewsEntity *news = [GMNewsEntity modelWithDictionary:dic];
                [newsArray addObject:news];
            }
            type == 0 ? self.newsArray = newsArray : [self.newsArray addObjectsFromArray:newsArray];
            dispatch_async_on_main_queue(^{
                [self.tableView reloadData];
                type == 0 ? [self.tableView.mj_header endRefreshing]:[self.tableView.mj_footer endRefreshing];
            });
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"Get news failed");
    }];
}



@end
