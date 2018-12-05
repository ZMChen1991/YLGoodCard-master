//
//  YLFunctionController.m
//  YLGoodCard
//
//  Created by lm on 2018/11/13.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import "YLFunctionController.h"
#import "YLSubController.h"
#import "YLAccountTool.h"
#import "YLAccount.h"

@interface YLFunctionController ()

@end

@implementation YLFunctionController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.skip.titles = self.titles;
    YLAccount *account = [YLAccountTool account];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:account.telephone forKey:@"telephone"];
    NSMutableArray *ctrs = [NSMutableArray array];
    for (NSInteger i = 0; i < self.titles.count; i++) {
        YLSubController *ctr1 = [[YLSubController alloc] init];
//        ctr1.cellType = YLCellTypeBargain;
        [param setValue:self.params[i] forKey:@"status"];
        ctr1.param = param;
        // 传请求
        NSLog(@"%@", ctr1.param);
        [self addChildViewController:ctr1];
        [ctrs addObject:ctr1];
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
