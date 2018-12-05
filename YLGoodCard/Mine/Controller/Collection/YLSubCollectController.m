//
//  YLSubCollectController.m
//  YLGoodCard
//
//  Created by lm on 2018/11/30.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import "YLSubCollectController.h"
#import "YLMineTool.h"
#import "YLCollectionModel.h"
#import "YLCollectCellFrame.h"
#import "YLCollectCell.h"

@interface YLSubCollectController ()

@property (nonatomic, strong) NSMutableArray *collectArray;

@end

@implementation YLSubCollectController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

}

- (void)loadData {
 
    [YLMineTool collectWithParam:self.param success:^(NSArray * _Nonnull result) {
        
        for (YLCollectionModel *model in result) {
            NSLog(@"%@", model);
            YLCollectCellFrame *cellFrame = [[YLCollectCellFrame alloc] init];
            cellFrame.collectionModel = model;
            [self.collectArray addObject:cellFrame];
            [self.tableView reloadData];
        }
        
    } failure:nil];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.collectArray.count;
}

#pragma mark 循环利用cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    YLCollectCell *cell = [YLCollectCell cellWithTableView:tableView];
    YLCollectCellFrame *cellFrame = self.collectArray[indexPath.row];
    cell.collectCellFrame = cellFrame;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    YLCollectCellFrame *cellFrame = self.collectArray[indexPath.row];
    return cellFrame.cellHeight;
}

- (NSMutableArray *)collectArray {
    if (!_collectArray) {
        _collectArray = [NSMutableArray array];
    }
    return _collectArray;
}

- (void)setParam:(NSMutableDictionary *)param {
    _param = param;
    [self loadData];
}

@end
