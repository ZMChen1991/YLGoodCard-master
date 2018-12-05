//
//  YLMessageController.m
//  YLGoodCard
//
//  Created by lm on 2018/11/2.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import "YLMessageController.h"
#import "YLMessageCell.h"

@interface YLMessageController ()

@property (nonatomic, strong) NSArray *messages;

@end

@implementation YLMessageController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.tableFooterView = [[UIView alloc] init];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.messages.count;
}

- (YLMessageCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    YLMessageCell *cell = [YLMessageCell cellWithTableView:tableView];
    cell.messageL.text = self.messages[indexPath.row];
    cell.detailL.text = @"暂无";
#warning 日期以后修改
    cell.dateL.text = @"10月23日";
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 80;
}

#pragma mark 懒加载
- (NSArray *)messages {
    
    if (!_messages) {
        _messages = [NSArray arrayWithObjects:@"已售通知", @"降价通知", @"买家订单通知", @"客服通知", nil];
    }
    return _messages;
}

@end
