//
//  YLBargainHistoryController.m
//  YLGoodCard
//
//  Created by lm on 2018/11/30.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import "YLBargainHistoryController.h"
#import "YLSubBargainHistoryController.h"
#import "YLAccountTool.h"
#import "YLAccount.h"

#import "YLSubBuyerBargianHistoryController.h"
#import "YLSubSellerBargainHistoryController.h"

@interface YLBargainHistoryController ()

@end

@implementation YLBargainHistoryController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.skip.titles = self.titles;
    YLSubBuyerBargianHistoryController *buyer = [[YLSubBuyerBargianHistoryController alloc] init];
    YLSubSellerBargainHistoryController *seller = [[YLSubSellerBargainHistoryController alloc] init];
    
    [self addChildViewController:buyer];
    [self addChildViewController:seller];
    
    self.skip.controllers = [NSMutableArray arrayWithObjects:buyer, seller, nil];
    [self.view addSubview:self.skip];
}

- (YLSkipView *)skip {
    
    if (!_skip) {
        _skip = [[YLSkipView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64)];
    }
    return _skip;
}

- (void)setParams:(NSArray *)params {
    _params = params;
}

@end
