//
//  DealCell.h
//  快速集成下拉刷新
//
//  Created by mj on 13-11-3.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Deal;
@interface DealCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIButton *buyCount;
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UILabel *desc;

@property (nonatomic, strong) Deal *deal;
@end
