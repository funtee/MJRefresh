//
//  DealCell.m
//  快速集成下拉刷新
//
//  Created by mj on 13-11-3.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "DealCell.h"
#import "Deal.h"

@implementation DealCell

- (void)setDeal:(Deal *)deal
{
    _deal = deal;
    
    [_buyCount setTitle:[NSString stringWithFormat:@"%d", deal.buyCount] forState:UIControlStateNormal];
    _price.text = [NSString stringWithFormat:@"%d", deal.price];
    _desc.text = deal.desc;
}

@end
