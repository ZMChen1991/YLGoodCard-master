//
//  YLCollectController.m
//  YLGoodCard
//
//  Created by lm on 2018/11/30.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import "YLCollectController.h"
#import "YLCollectingCarController.h"
#import "YLCollectedCarController.h"
//#import "YLSubCollectController.h"
//#import "YLAccountTool.h"
//#import "YLAccount.h"

@interface YLCollectController ()

@end

@implementation YLCollectController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.skip.titles = self.titles;
    
    YLCollectingCarController *collecting = [[YLCollectingCarController alloc] init];
    YLCollectedCarController *collected = [[YLCollectedCarController alloc] init];
    
    [self addChildViewController:collecting];
    [self addChildViewController:collected];
    
//    YLAccount *account = [YLAccountTool account];
//    NSMutableDictionary *param = [NSMutableDictionary dictionary];
//    [param setValue:account.telephone forKey:@"telephone"];
//    NSMutableArray *ctrs = [NSMutableArray array];
//    for (NSInteger i = 0; i < self.titles.count; i++) {
//        YLSubCollectController *ctr = [[YLSubCollectController alloc] init];
//        [param setValue:self.params[i] forKey:@"status"];
//        ctr.param = param;
////        ctr.view.backgroundColor = YLRandomColor;
//        // 传请求
//        NSLog(@"%@", ctr.param);
//        [self addChildViewController:ctr];
//        [ctrs addObject:ctr];
//    }
    self.skip.controllers = [NSMutableArray arrayWithObjects:collecting, collected, nil];
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
