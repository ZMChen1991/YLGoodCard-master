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

@interface YLBuyOrderController ()

@end

@implementation YLBuyOrderController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.skip.titles = self.titles;
    YLAccount *account = [YLAccountTool account];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:account.telephone forKey:@"telephone"];
    NSMutableArray *ctrs = [NSMutableArray array];
    for (NSInteger i = 0; i < self.titles.count; i++) {
        YLSubBuyOrderController *ctr = [[YLSubBuyOrderController alloc] init];
        [param setValue:self.params[i] forKey:@"status"];
        NSLog(@"buyOrder-param:%@", param);
        ctr.param = param;
        [self addChildViewController:ctr];
        [ctrs addObject:ctr];
    }
    self.skip.controllers = ctrs;
    [self.view addSubview:_skip];
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
