//
//  RefreshViewController.m
//  快速集成下拉刷新
//
//  Created by mj on 13-11-3.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "RefreshViewController.h"
#import "Deal.h"

/*
 MJ友情提示：
 1> 在MJRefreshBaseView.h中：可以通过NeedAudio宏来控制是否需要刷新音效
 2> 在MJRefreshFooterView.m和MJRefreshHeaderView.m中可以修改刷新显示的文字
 3> 监听进入刷新状态有2种方式：
  * 设置delegate，通过代理方法监听
  * 设置beginRefreshingBlock，通过block回调监听
 4> 本框架兼容iPhone\iPad横竖屏
 */

// 1.主头文件
#import "MJRefresh.h"

// 2.刷新代理协议（达到刷新状态就会调用）
@interface RefreshViewController()  <MJRefreshBaseViewDelegate>
{
    MJRefreshHeaderView *_header;
    MJRefreshFooterView *_footer;
}
@end

@implementation RefreshViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 防止block循环retain，所以用__unsafe_unretained
    __unsafe_unretained RefreshViewController *vc = self;
    
    // 3.3行集成下拉刷新控件
    _header = [MJRefreshHeaderView header];
    _header.scrollView = self.collectionView;
    _header.delegate = self;
    
    // 4.3行集成上拉加载更多控件
    _footer = [MJRefreshFooterView footer];
    _footer.scrollView = self.collectionView;
    
    // 进入上拉加载状态就会调用这个方法
    _footer.beginRefreshingBlock = ^(MJRefreshBaseView *refreshView) {
        // 增加5个假数据
        for (int i = 0; i<5; i++) {
            [vc->_deals addObject:[vc randomDeal]];
        }
        
        
        // 2秒后刷新表格
        [vc performSelector:@selector(reloadDeals) withObject:nil afterDelay:2];
    };
    
    // 5.0.5秒后自动下拉刷新
    [_header performSelector:@selector(beginRefreshing) withObject:nil afterDelay:0.5];
}

#pragma mark - 刷新的代理方法---进入下拉刷新\上拉加载更多都有可能调用这个方法
- (void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
{
    if (refreshView == _header) { // 下拉刷新
        // 增加9个假数据
        for (int i = 0; i<7; i++) {
            [_deals insertObject:[self randomDeal] atIndex:0];
        }
        
        // 2秒后刷新表格
        [self performSelector:@selector(reloadDeals) withObject:nil afterDelay:2];
    }
}

#pragma mark - 
#pragma mark 随机产生团购
- (Deal *)randomDeal
{
    Deal *d = [[Deal alloc] init];
    d.price = arc4random_uniform(10000);
    d.buyCount = arc4random_uniform(10000);
    d.desc = [NSString stringWithFormat:@"团购大优惠--->>%d", _deals.count];
    return d;
}

#pragma mark 刷新团购
- (void)reloadDeals
{
    [self.collectionView reloadData];
    // 结束刷新状态
    [_header endRefreshing];
    [_footer endRefreshing];
}
@end
