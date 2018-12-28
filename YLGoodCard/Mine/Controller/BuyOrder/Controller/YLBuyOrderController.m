//
//  YLBuyOrderController.m
//  YLGoodCard
//
//  Created by lm on 2018/11/30.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import "YLBuyOrderController.h"
#import "YLSubBuyOrderController.h"
#import "YLAccountTool.h"
#import "YLAccount.h"

#import "YLSubAllBuyOrderController.h"
#import "YLSubRecheckBuyOrderController.h"
#import "YLSubDoneBuyOrderController.h"
#import "YLSubCancelBuyOrderController.h"


@interface YLBuyOrderController ()

@end

@implementation YLBuyOrderController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.skip.titles = self.titles;
    YLSubAllBuyOrderController *all = [[YLSubAllBuyOrderController alloc] init];
    YLSubRecheckBuyOrderController *reCheck = [[YLSubRecheckBuyOrderController alloc] init];
    YLSubDoneBuyOrderController *done = [[YLSubDoneBuyOrderController alloc] init];
    YLSubCancelBuyOrderController *cancel = [[YLSubCancelBuyOrderController alloc] init];
    self.skip.controllers = [NSMutableArray arrayWithObjects:all, reCheck, done, cancel, nil];
    
    [self addChildViewController:all];
    [self addChildViewController:reCheck];
    [self addChildViewController:done];
    [self addChildViewController:cancel];
    
//    NSMutableArray *ctrs = [NSMutableArray array];
//    for (NSInteger i = 0; i < self.titles.count; i++) {
//        YLSubBuyOrderController *ctr = [[YLSubBuyOrderController alloc] init];
//        [param setValue:self.params[i] forKey:@"status"];
//        NSLog(@"buyOrder-param:%@", param);
//        ctr.param = param;
//        [self addChildViewController:ctr];
//        [ctrs addObject:ctr];
//    }
//    self.skip.controllers = ctrs;
    [self.view addSubview:_skip];
}

- (YLSkipView *)skip {
    
    if (!_skip) {
        _skip = [[YLSkipView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-64)];
    }
    return _skip;
}

- (void)setParams:(NSArray *)params {
    _params = params;
}


@end
