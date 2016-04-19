//
//  GMMainVC.m
//  GMNews
//
//  Created by Gmxanm on 16/3/29.
//  Copyright © 2016年 Xnmawc. All rights reserved.
//

#import "GMMainVC.h"
#import "GMNewsVC.h"
#import "GMNetworkManager.h"
#import "GMAppStatus.h"
#import "GMTitleLabel.h"

@interface GMMainVC()<UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *titleSV;
@property (weak, nonatomic) IBOutlet UIScrollView *controllerSV;

@property (strong, nonatomic) NSMutableArray *childVCArray;
@property (strong, nonatomic) GMNewsVC *selectedPageVC;

@end

@implementation GMMainVC

#pragma mark -- LifeCycle

- (void)viewDidLoad{
    
    [super viewDidLoad];
    
    [self net];
    
    self.title = @"黄易";
    
    // To fix the scrollView problem
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self initTitleSV];
    [self initContentSV];
    [self initChildVC];
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
}

#pragma mark -- UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if (scrollView != _controllerSV) return;
    
    // 取出绝对值 避免最左边往右拉时形变超过1
    CGFloat value = ABS(scrollView.contentOffset.x / scrollView.frame.size.width);
    NSUInteger leftIndex = (int)value;
    NSUInteger rightIndex = leftIndex + 1;
    CGFloat scaleRight = value - leftIndex;
    CGFloat scaleLeft = 1 - scaleRight;
    GMTitleLabel *labelLeft = _titleSV.subviews[leftIndex];
    
    labelLeft.scale = scaleLeft;
    
    // 在第一个title的时候滑动不再改变其他title scale
    if (rightIndex == 1 && scrollView.contentOffset.x < 0)return;
    
    // 考虑到最后一个板块，如果右边已经没有板块了 就不在下面赋值scale了
    if (rightIndex < _titleSV.subviews.count) {
        
        GMTitleLabel *labelRight = _titleSV.subviews[rightIndex];
        labelRight.scale = scaleRight;
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    [self scrollViewDidEndScrollingAnimation:scrollView];
}

/**
 *  手动设置Offset触发该方法
 *
 *  @param scrollView
 */

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    
    if (scrollView != _controllerSV) return;
    
    NSInteger tag = [self currentPage];
    
    [self setCurrentTitleOffsetWithTag:tag];
    [self showCurrentPageWithTag:tag];
    [self setUnselectedTitle];
}

#pragma mark -- Touch Event

- (void)didTapTitle:(UITapGestureRecognizer *)tap{
    
    if ([tap.view isKindOfClass:[GMTitleLabel class]]) {
        
        __block GMTitleLabel *selectedLabel = (GMTitleLabel *)tap.view;
        selectedLabel.scale = 1;
        
        [self setCurrentPageOffsetWithTag:selectedLabel.tag];
    }
}

#pragma mark -- Privete

/**
 *  初始化界面
 */

- (void)initTitleSV{
    
    @WeakObj(self);
    
    [AppStatus.newsInfoArray enumerateObjectsUsingBlock:^(NSDictionary *dic, NSUInteger idx, BOOL * _Nonnull stop) {
        
        @StrongObj(self);
        
        GMTitleLabel *titleLabel = [[GMTitleLabel alloc]initWithTitle:[dic objectForKey:@"title"]];
        titleLabel.tag = idx;
        titleLabel.frame = CGRectMake(idx*60, 0, 60.0, 40.0);
        
        [_titleSV addSubview:titleLabel];
        
        if (stop) {
            self.titleSV.contentSize = CGSizeMake(CGRectGetMaxX(titleLabel.frame), 40.0);
        }
        
        if (idx == 0) {
            titleLabel.scale = 1;
        }
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(didTapTitle:)];
        [titleLabel addGestureRecognizer:tap];
    }];
    
    _titleSV.showsVerticalScrollIndicator = NO;
    _titleSV.showsHorizontalScrollIndicator = NO;
    _titleSV.scrollsToTop = NO;
    _titleSV.delegate = self;
}

- (void)initContentSV{
    
    _controllerSV.showsHorizontalScrollIndicator = NO;
    _controllerSV.scrollsToTop = NO;
    _controllerSV.pagingEnabled = YES;
    _controllerSV.delegate = self;
    _controllerSV.bounces = NO;
    _controllerSV.contentSize = CGSizeMake(AppStatus.newsInfoArray.count * ScreenWidth, _controllerSV.frame.size.height);
}

- (void)initChildVC{
    
    _childVCArray = [NSMutableArray new];
    
    @WeakObj(self);
    
    [AppStatus.newsInfoArray enumerateObjectsUsingBlock:^(NSDictionary *dic, NSUInteger idx, BOOL * _Nonnull stop) {
        
        @StrongObj(self);
        
        GMNewsVC *newVC = [[UIStoryboard storyboardWithName:@"GMNews" bundle:[NSBundle mainBundle]]instantiateInitialViewController];
        newVC.title = [dic objectForKey:@"title"];
        [self addChildViewController:newVC];
        
        if (idx == 0) {
            
            newVC.view.frame = _controllerSV.bounds;
            [_controllerSV addSubview:newVC.view];
            [newVC didMoveToParentViewController:self];
            self.selectedPageVC = newVC;
        }
        
        [_childVCArray addObject:newVC];
    }];
}

/**
 *  显示新的新闻控制器
 *
 *  @param newsVC
 */

- (void)showCurrentPageWithTag:(NSInteger)tag{
    
    //    [_selectedPageVC willMoveToParentViewController:nil];
    //    [_selectedPageVC removeFromParentViewController];
    //    [_selectedPageVC.view removeFromSuperview];
    
    GMNewsVC *newsVC = _childVCArray[tag];
    
    if (newsVC.view.superview)return;
    
    _selectedPageVC = newsVC;
    _selectedPageVC.view.frame = _controllerSV.bounds;
    [_controllerSV addSubview:_selectedPageVC.view];
    [_selectedPageVC didMoveToParentViewController:self];
    
    NSLog(@"%@",newsVC.title);
}

/**
 *  滚动内容栏
 *
 *  @param tag
 */

- (void)setCurrentPageOffsetWithTag:(NSInteger)tag{
    
    CGFloat offsetX = tag * _controllerSV.frame.size.width;
    CGFloat offsetY = _controllerSV.contentOffset.y;
    CGPoint offset1 = CGPointMake(offsetX, offsetY);
    
    [_controllerSV setContentOffset:offset1 animated:YES];
}

/**
 *  滚动标题栏
 *
 *  @param tag
 */

- (void)setCurrentTitleOffsetWithTag:(NSInteger)tag{
    
    GMTitleLabel *titleLable = (GMTitleLabel *)_titleSV.subviews[tag];
    
    CGFloat offsetx = titleLable.center.x - _titleSV.frame.size.width * 0.5;
    CGFloat offsetMax = _titleSV.contentSize.width - _titleSV.frame.size.width;
    if (offsetx < 0) {
        offsetx = 0;
    }else if (offsetx > offsetMax){
        offsetx = offsetMax;
    }
    
    CGPoint offset = CGPointMake(offsetx, _titleSV.contentOffset.y);
    [_titleSV setContentOffset:offset animated:YES];
}

/**
 *  设置Title回初始状态
 */

- (void)setUnselectedTitle{
    
    [_titleSV.subviews enumerateObjectsUsingBlock:^(GMTitleLabel *titleLabel, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if (titleLabel.tag != [self currentPage]) {
            titleLabel.scale = 0;
        }
    }];
}

/**
 *  当前页面标签
 *
 *  @return
 */

- (NSInteger)currentPage{
    
    CGFloat value = ABS(_controllerSV.contentOffset.x / _controllerSV.frame.size.width);
    NSInteger tag = (int)value;
    return tag;
}



- (void)net
{
    // http://c.m.163.com//nc/article/headline/T1348647853363/0-30.html
    
    [[GMNetworkManager shareInstance] GET:@"/nc/article/headline/T1348647853363/0-20.html" parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
}



@end
