//
//  ViewController.m
//  快速集成下拉刷新
//
//  Created by mj on 13-11-3.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "DealsViewController.h"
#import "DealCell.h"

@interface DealsViewController ()

@end
#define kItemWidth 150
#define kItemHeight 150

@implementation DealsViewController

- (id)init
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(kItemWidth, kItemHeight);
    layout.minimumLineSpacing = 30;
    layout.sectionInset = UIEdgeInsetsMake(10, 5, 10, 5);
    return [self initWithCollectionViewLayout:layout];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.collectionView registerNib:[UINib nibWithNibName:@"DealCell" bundle:nil] forCellWithReuseIdentifier:@"deal"];
    self.collectionView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_deal.png"]];
    self.collectionView.alwaysBounceVertical = YES;
    
    _deals = [NSMutableArray array];
}

#pragma mark - Collection数据源
- (int)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _deals.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"deal";
    DealCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    
    cell.deal = _deals[indexPath.row];
    
    return cell;
}

@end
