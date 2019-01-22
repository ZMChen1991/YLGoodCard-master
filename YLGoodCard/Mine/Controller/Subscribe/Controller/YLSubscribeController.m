//
//  YLSubscribeController.m
//  YLGoodCard
//
//  Created by lm on 2018/11/30.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import "YLSubscribeController.h"
#import "YLRequest.h"
#import "YLAccount.h"
#import "YLAccountTool.h"
#import "YLSubscribeCellFrame.h"
#import "YLSubscribeCell.h"
#import "YLSubscribeModel.h"
#import "YLTableViewModel.h"
#import "YLDetailController.h"
#import "YLSubcribeViewCell.h"
#import "YLCollectionFooterButton.h"
#import "YLNoneView.h"
#import "YLBuyConditionModel.h"
#import "YLSelectView.h"
#import "YLSubcribeParamView.h"
#import "YLSubscribeDetailController.h"
#import "YLSubscribeSelectParamView.h"
#import "YLBrandController.h"
#import "YLSeriesController.h"
#import "YLSubscribeMultiSelectController.h"

#define YLMySubscribePath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"MySubscribe.txt"]


static NSString *const cellID = @"YLSubscribeCell";
static NSString *const footerID = @"YLSubscribeFooter";
static NSString *const headerID = @"YLSubscribeHeader";

@interface YLSubscribeController () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *groups;
@property (nonatomic, strong) NSMutableArray *results;
@property (nonatomic, strong) YLNoneView *noneView;
@property (nonatomic, strong) NSMutableArray *multiSelectModels;
@property (nonatomic, strong) NSArray *headerTitles;
@property (nonatomic, strong) NSMutableArray *params;

@property (nonatomic, strong) NSString *lowPrice;
@property (nonatomic, strong) NSString *highPrice;


@end

@implementation YLSubscribeController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的订阅";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setNav];
    [self yl__initData];
    [self createCollectionView];
    [self getLocationData];
    [self loadData];
    
}

- (void)yl__initData {
    
    [self.multiSelectModels removeAllObjects];
    // 详细参数
    NSArray *data = @[@[@"品牌"],
                      @[@"两厢轿车", @"三厢轿车", @"跑车", @"SUV", @"MPV", @"面包车", @"皮卡"],
                      @[@"3万以下", @"3-5万",@"5-7万", @"7-9万", @"9-12万",@"12-16万", @"16-20万", @"20万以上"],
                      @[@"本地牌照", @"外地牌照"],
                      @[@"手动", @"自动"],
                      @[@"低于3年", @"3-5年", @"5-7年", @"7-9年", @"9-12年", @"12年以上"],
                      @[@"低于3万", @"3-5万", @"5-7万", @"7-9万", @"9-12万", @"12万以上"],
                      @[@"低于1.0L", @"1.0L-1.3L", @"1.3L-1.6L", @"1.6L-1.9L", @"1.9L-2.2L", @"2.2L以上"],
                      @[@"国二及以上", @"国三及以上", @"国四及以上", @"国五"],
                      @[@"黑色", @"白色", @"银灰色", @"深灰色", @"银色", @"绿色", @"红色", @"咖啡色", @"香槟色", @"蓝色", @"橙色", @"其他"],
                      @[@"2座", @"4座" ,@"5座" ,@"6座" ,@"7座以上"],
                      @[@"汽油", @"柴油", @"电动", @"油电混合", @"其他"],
                      @[@"德系", @"日系", @"美系", @"法系", @"韩系", @"国产", @"其他"],
                      @[@"全景天窗", @"车身稳定控制", @"倒车影像系统", @"真皮座椅", @"无钥匙进入",@"儿童座椅接口", @"倒车雷达", @"GPS导航"]];
    // 组别参数 @"brand" / @"price"
    NSArray *params2 = @[@"brand", @"bodyStructure", @"price", @"isLocal", @"gearbox", @"vehicleAge", @"course", @"emission", @"emissionStandard", @"color", @"seatsNum", @"fuelForm", @"country", @"other"];
    // 亮点配置参数
    NSArray *params3 = @[@"panoramicSunroof", @"stabilityControl", @"reverseVideo", @"genuineLeather", @"keylessEntrySystem", @"childSeatInterface", @"parkingRadar", @"gps"];
    for (NSInteger i = 0; i < data.count; i++) {
        NSMutableArray *details = [NSMutableArray array];
        NSArray *array = data[i];
        if (i < data.count - 1) {
            for (NSInteger j = 0; j < array.count; j++) {
                YLBuyConditionModel *model = [[YLBuyConditionModel alloc] init];
                model.title = array[j];
                model.detail = array[j];
                model.param = array[j];
                model.key = params2[i];
                [details addObject:model];
            }
        } else {
            for (NSInteger j = 0; j < array.count; j++) {
                YLBuyConditionModel *model = [[YLBuyConditionModel alloc] init];
                model.title = array[j];
                model.detail = array[j];
                model.param = @"0";
                model.key = params3[j];
                [details addObject:model];
            }
        }
        [self.multiSelectModels addObject:details];
    }
    self.headerTitles = @[@"品牌", @"车型", @"价格", @"车牌所在地", @"变速箱", @"车龄 (单位:年)", @"行驶里程 (单位:万公里)", @"排量 (单位:升)", @"排放标准", @"颜色", @"座位数", @"燃油类型", @"国别",  @"亮点配置"];
}

- (void)setNav {
    
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithTitle:@"新增" style:UIBarButtonItemStylePlain target:self action:@selector(rightClick)];
    self.navigationItem.rightBarButtonItem = right;
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
}

- (void)createCollectionView {
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(YLScreenWidth, 110);
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    layout.minimumLineSpacing = 0.f;
    layout.minimumInteritemSpacing = 0.f;
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    CGRect rect = CGRectMake(0, 0, YLScreenWidth, YLScreenHeight - 64);
    UICollectionView *collectView = [[UICollectionView alloc] initWithFrame:rect collectionViewLayout:layout];
    collectView.delegate = self;
    collectView.dataSource = self;
    collectView.backgroundColor = [UIColor whiteColor];
    [collectView registerClass:[YLSubcribeViewCell class] forCellWithReuseIdentifier:cellID];
    [collectView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:footerID];
    [collectView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerID];
    [self.view addSubview:collectView];
    self.collectView = collectView;
    
    [self.view addSubview:self.noneView];
}

- (void)loadData {
    MBProgressHUD *hub = [[MBProgressHUD alloc] initWithView:self.view];
    hub.detailsLabel.text = @"正在加载，请稍后";
    [hub showAnimated:YES];
    [self.view addSubview:hub];
    
    NSString *urlString = @"http://ucarjava.bceapp.com/subscribe?method=my";
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    YLAccount *account = [YLAccountTool account];
    if (account) {
        [param setObject:account.telephone forKey:@"telephone"];
    }
    __weak typeof(self) weakSelf = self;
    [YLRequest GET:urlString parameters:param success:^(id  _Nonnull responseObject) {
        if ([responseObject[@"code"] isEqualToNumber:[NSNumber numberWithInteger:200]]) {
            [weakSelf keyedArchiverObject:responseObject toFile:YLMySubscribePath];
            [weakSelf getLocationData];
            [NSString showMessage:@"加载完成"];
            [hub removeFromSuperview];
        } else {
            [NSString showMessage:@"加载失败，请重新刷新"];
            [hub removeFromSuperview];
        }
    } failed:nil];
}

- (void)getLocationData {
    
    [self.groups removeAllObjects];
    [self.results removeAllObjects];
    
    NSDictionary *dict = [NSKeyedUnarchiver unarchiveObjectWithFile:YLMySubscribePath];
    self.groups = [YLSubscribeModel mj_objectArrayWithKeyValuesArray:dict[@"data"]];
    for (YLSubscribeModel *model in self.groups) {
        NSMutableArray *detailModels = [NSMutableArray array];
        for (YLSubscribeDetailModel *detailModel in model.result) {
            YLSubscribeCellFrame *cellFrame = [[YLSubscribeCellFrame alloc] init];
            cellFrame.model = detailModel;
            [detailModels addObject:cellFrame];
        }
        [self.results addObject:detailModels];
    }
    
    if (self.groups.count > 0) {
        self.noneView.hidden = YES;
    } else {
        self.noneView.hidden = NO;;
    }
    [self.collectView reloadData];
}

- (void)keyedArchiverObject:(id)obj toFile:(NSString *)filePath {
    BOOL success = [NSKeyedArchiver archiveRootObject:obj toFile:filePath];
    if (success) {
        NSLog(@"买车数据保存成功");
    } else {
        NSLog(@"保存失败");
    }
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.results.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if ([self.results[section] count] > 3) {
        return 3;
    } else {
        return [self.results[section] count];
    }
}

- (YLSubcribeViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    YLSubcribeViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    YLSubscribeCellFrame *cellFrame = self.results[indexPath.section][indexPath.row];
    cell.cellFrame = cellFrame;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    YLSubscribeCellFrame *cellFrame = self.results[indexPath.section][indexPath.row];
    YLSubscribeDetailModel *detailModel = cellFrame.model;
    YLTableViewModel *model = [YLTableViewModel mj_objectWithKeyValues:detailModel];
    YLDetailController *detail = [[YLDetailController alloc] init];
    detail.model = model;
    [self.navigationController pushViewController:detail animated:YES];
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    CGFloat height = 17;
    CGFloat width = 40;
    CGFloat btnY = (40 - height) / 2;
    if ([kind isEqualToString:UICollectionElementKindSectionFooter]) {
        UICollectionReusableView *footer = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:footerID forIndexPath:indexPath];
        // 此处的header可能会产生复用，要将之前原有的子视图移除掉
            for (YLCollectionFooterButton *view in footer.subviews) {
                [view removeFromSuperview];
            }
        
        __weak typeof(self) weakSelf = self;
        CGRect rect = CGRectMake(YLScreenWidth - 2 * width - YLLeftMargin - 10, btnY, width, height);
        YLCollectionFooterButton *editor = [[YLCollectionFooterButton alloc] initWithFrame:rect title:@"编辑" image:@"编辑-1"];
        editor.block = ^{
            NSLog(@"section:%ld", indexPath.section);
            [weakSelf editorClick:indexPath];
        };
        [footer addSubview:editor];
        
        CGRect rect1 = CGRectMake(YLScreenWidth - width - YLLeftMargin, btnY, width, height);
        YLCollectionFooterButton *delete = [[YLCollectionFooterButton alloc] initWithFrame:rect1 title:@"删除" image:@"删除"];
        delete.block = ^{
            [weakSelf deleteClick:indexPath];
        };
        [footer addSubview:delete];
        UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, YLScreenWidth, 1)];
        line.backgroundColor = YLColor(233.f, 233.f, 233.f);
        [footer addSubview:line];
        
        UILabel *line1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 40, YLScreenWidth, 1)];
        line1.backgroundColor = YLColor(233.f, 233.f, 233.f);
        [footer addSubview:line1];
        return footer;
    } else {
        UICollectionReusableView *header = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:headerID forIndexPath:indexPath];
        // 此处的header可能会产生复用，要将之前原有的子视图移除掉
        for (UILabel *view in header.subviews) {
            [view removeFromSuperview];
        }
        for (YLSubcribeParamView *view in header.subviews) {
            [view removeFromSuperview];
        }
    
        // 获取当前组的数据
        YLSubscribeModel *model = self.groups[indexPath.section];
        CGFloat labelW = 50;
        CGFloat paramViewW = YLScreenWidth - labelW - 2 * YLLeftMargin - 10;
        YLSubcribeParamView *paramView = [[YLSubcribeParamView alloc] initWithFrame:CGRectMake(YLLeftMargin, 5, paramViewW, 40)];
        paramView.params = [self paramsWithSubscribeModel:model];
        [header addSubview:paramView];
       
        CGRect rect = CGRectMake(YLScreenWidth - labelW - YLLeftMargin, btnY + 5, labelW, height);
        UILabel *label = [[UILabel alloc] init];
        label.frame = rect;
        label.text = @"查看更多";
        label.tag = indexPath.section;
        label.textColor = YLColor(51.f, 51.f, 51.f);
        label.textAlignment = NSTextAlignmentRight;
        label.font = [UIFont systemFontOfSize:12];
        [label setUserInteractionEnabled:YES];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(moreClick:)];
        [label addGestureRecognizer:tap];
        [header addSubview:label];
        
        UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, YLScreenWidth, 5)];
        line.backgroundColor = YLColor(233.f, 233.f, 233.f);
        [header addSubview:line];
        UILabel *line1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 45, YLScreenWidth, 1)];
        line1.backgroundColor = YLColor(233.f, 233.f, 233.f);
        [header addSubview:line1];
        return header;
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(YLScreenWidth, 45);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    return CGSizeMake(YLScreenWidth, 40);
}

#pragma mark 根据模型筛选出条件参数
- (NSMutableArray *)paramsWithSubscribeModel:(YLSubscribeModel *)model {
    NSArray *params2 = @[@"brand", @"bodyStructure", @"price", @"isLocal", @"gearbox", @"vehicleAge", @"course", @"emission", @"emissionStandard", @"color", @"seatsNum", @"fuelForm", @"country"];
    NSArray *param3 = @[@"panoramicSunroof", @"stabilityControl", @"reverseVideo", @"genuineLeather", @"keylessEntrySystem", @"childSeatInterface", @"parkingRadar", @"gps"];
    NSArray *param4 = @[@"全景天窗", @"车身稳定控制", @"倒车影像系统", @"真皮座椅", @"无钥匙进入",@"儿童座椅接口", @"倒车雷达", @"GPS导航"];
    // 获取当前组的数据
//    YLSubscribeModel *model = self.groups[indexPath.section];
    NSMutableArray *params = [NSMutableArray array];
    // 转换成字典
    NSMutableDictionary *dict = [model mj_keyValues];
    // ----------------亮点配置外的条件抽取----------------
    // 遍历字典，将有值的抽取出来分隔成模型
//#warning 价格不需要拆分出来，直接转成文字显示出来
    for (NSInteger i = 0; i < params2.count; i++) {
        if(i == 2) { // 等于价格时
            NSString *string = [dict objectForKey:params2[i]];
            if (![string isEqualToString:@""]) { // 判断是否为空，不为空再执行
                // 根据fgf分隔字符串
                NSArray *arr = [string componentsSeparatedByString:@"fgf"];
                NSString *title = [NSString stringWithFormat:@"%ld万-%ld万", [arr[0] integerValue] / 10000, [arr[1] integerValue] / 10000];
                YLBuyConditionModel *model = [[YLBuyConditionModel alloc] init];
                model.title = title;
                model.detail = title;
                model.param = title;
                model.key = params2[i];
                model.isSelect = YES;
                [params addObject:model];

//                NSString *tempTitle = [string stringByReplacingOccurrencesOfString:@"0000" withString:@"万"];
//                NSString *title = [tempTitle stringByReplacingOccurrencesOfString:@"fgf" withString:@"-"];
//                NSLog(@"%@", title);
            }
        } else { // 不为价格
            NSString *string = [dict objectForKey:params2[i]];
            if (![string isEqualToString:@""]) {
                // 根据fgf分隔字符串
                NSArray *arr = [string componentsSeparatedByString:@"fgf"];
                for (NSString *title in arr) {
                    if ([title isEqualToString:@""]) {
                        break;
                    }
                    YLBuyConditionModel *model = [[YLBuyConditionModel alloc] init];
                    model.title = title;
                    model.detail = title;
                    model.param = title;
                    model.key = params2[i];
                    model.isSelect = YES;
                    [params addObject:model];
                }
            }
        }
    }
        
    // ----------------亮点配置----------------
    for (NSInteger i = 0; i < param3.count; i++) {
        NSString *str = [dict objectForKey:param3[i]];
        if ([str isEqualToString:@"1"]) {
            YLBuyConditionModel *model = [[YLBuyConditionModel alloc] init];
            model.title = param4[i];
            model.detail = param4[i];
            model.param = str;
            model.key = param3[i];
            model.isSelect = YES;
            [params addObject:model];
        }
    }
    return params;
}

#pragma mark 没有价格参数的条件参数数组
- (NSMutableArray *)noPriceParamsWithSubscribeModel:(YLSubscribeModel *)model {
    NSArray *params2 = @[@"brand", @"bodyStructure", @"price", @"isLocal", @"gearbox", @"vehicleAge", @"course", @"emission", @"emissionStandard", @"color", @"seatsNum", @"fuelForm", @"country"];
    NSArray *param3 = @[@"panoramicSunroof", @"stabilityControl", @"reverseVideo", @"genuineLeather", @"keylessEntrySystem", @"childSeatInterface", @"parkingRadar", @"gps"];
    NSArray *param4 = @[@"全景天窗", @"车身稳定控制", @"倒车影像系统", @"真皮座椅", @"无钥匙进入",@"儿童座椅接口", @"倒车雷达", @"GPS导航"];
    // 获取当前组的数据
    //    YLSubscribeModel *model = self.groups[indexPath.section];
    NSMutableArray *params = [NSMutableArray array];
    // 转换成字典
    NSMutableDictionary *dict = [model mj_keyValues];
    // ----------------亮点配置外的条件抽取----------------
    // 遍历字典，将有值的抽取出来分隔成模型
    //#warning 价格不需要拆分出来，直接转成文字显示出来
    for (NSInteger i = 0; i < params2.count; i++) {
        if(i == 2) { // 等于价格时
            NSString *string = [dict objectForKey:params2[i]];
            if (![string isEqualToString:@""]) { // 判断是否为空，不为空再执行
                // 根据fgf分隔字符串
                NSArray *arr = [string componentsSeparatedByString:@"fgf"];
                self.lowPrice = [NSString stringWithFormat:@"%ld", [arr[0] integerValue] / 10000];
                self.highPrice = [NSString stringWithFormat:@"%ld", [arr[1] integerValue] / 10000];
                
            }
        } else { // 不为价格
            NSString *string = [dict objectForKey:params2[i]];
            if (![string isEqualToString:@""]) {
                // 根据fgf分隔字符串
                NSArray *arr = [string componentsSeparatedByString:@"fgf"];
                for (NSString *title in arr) {
                    if ([title isEqualToString:@""]) {
                        break;
                    }
                    YLBuyConditionModel *model = [[YLBuyConditionModel alloc] init];
                    model.title = title;
                    model.detail = title;
                    model.param = title;
                    model.key = params2[i];
                    model.isSelect = YES;
                    [params addObject:model];
                }
            }
        }
    }
    
    // ----------------亮点配置----------------
    for (NSInteger i = 0; i < param3.count; i++) {
        NSString *str = [dict objectForKey:param3[i]];
        if ([str isEqualToString:@"1"]) {
            YLBuyConditionModel *model = [[YLBuyConditionModel alloc] init];
            model.title = param4[i];
            model.detail = param4[i];
            model.param = str;
            model.key = param3[i];
            model.isSelect = YES;
            [params addObject:model];
        }
    }
    return params;
}

#pragma mark 根据模型数组转成字典参数
- (NSMutableDictionary *)selectParamWithMultiSelectModels:(NSArray *)multiSelectModels {
    NSMutableArray *selectParamModels = [NSMutableArray array];
    // 筛选出选中的条件模型
    for (NSInteger i = 0; i < multiSelectModels.count; i++) {
        NSArray *arr = multiSelectModels[i];
        for (YLBuyConditionModel *model in arr) {
            if (model.isSelect) {
                [selectParamModels addObject:model];
            }
        }
    }
    // 将选中的条件模型转换成字典参数
    NSMutableDictionary *selectParam = [NSMutableDictionary dictionary];
    // 由于只支持阳江，所以不管是本地还是外地，location只填写阳江
    for (YLBuyConditionModel *model in selectParamModels) {
        if ([model.key isEqualToString:@"isLocal"]) {
            [selectParam setObject:@"阳江" forKey:@"location"];
        }
        // 如果字典中包含有这个key，那么值需要拼接
        if ([[selectParam allKeys] containsObject:model.key]) {
            // 将当前键值取出来
            NSString *obj = [selectParam objectForKey:model.key];
            // 拼接键值
            [selectParam setObject:[NSString stringWithFormat:@"%@fgf%@", obj, model.param] forKey:model.key];
        } else {
            [selectParam setObject:model.param forKey:model.key];
        }
    }
    return selectParam;
}

- (void)rightClick {
    NSLog(@"新增");
    YLSubscribeMultiSelectController *multi = [[YLSubscribeMultiSelectController alloc] init];
    __weak typeof(self) weakSelf = self;
    // ------------------------重置筛选条件----------------------------
    multi.restAllConditionBlock = ^(NSArray *multiSelectModels) {
        // 替换原来的数组数据
    };
    
    // ------------------------确定筛选条件----------------------------
    multi.sureBlock = ^(NSArray *multiSelectModels) {
        
        NSMutableDictionary *selectParam = [weakSelf selectParamWithMultiSelectModels:multiSelectModels];
        YLAccount *account = [YLAccountTool account];
        [selectParam setObject:account.telephone forKey:@"telephone"];
        NSString *urlString = @"http://ucarjava.bceapp.com/subscribe?method=add";
        [YLRequest GET:urlString parameters:selectParam success:^(id  _Nonnull responseObject) {
            if ([responseObject[@"code"] isEqualToNumber:[NSNumber numberWithInteger:200]]) {
                [weakSelf loadData];
                [NSString showMessage:@"订阅成功"];
            } else {
                [weakSelf loadData];
                NSString *string = responseObject[@"message"];
                [NSString showMessage:string];
            }
        } failed:nil];
        [weakSelf.navigationController popViewControllerAnimated:YES];
    };
    
    [self.navigationController pushViewController:multi animated:YES];
}

- (void)moreClick:(UITapGestureRecognizer *)sender {
    NSLog(@"查看更多");
    UILabel *label = (UILabel *)sender.view;
    NSInteger tag = label.tag;
    
    YLSubscribeModel *model = self.groups[tag];
    YLSubscribeDetailController *detail = [[YLSubscribeDetailController alloc] init];
    detail.model = model;
    detail.params = [self paramsWithSubscribeModel:model];
    [self.navigationController pushViewController:detail animated:YES];
}

- (void)editorClick:(NSIndexPath *)indexPath {
    NSLog(@"编辑");
//    NSLog(@"section:%ld", indexPath.section);
    [self yl__initData];

    // 获取当前组的数据
    YLSubscribeModel *model = self.groups[indexPath.section];
    NSMutableArray *params = [self noPriceParamsWithSubscribeModel:model];
    // 判断选中的模型在self.multiSelectModels的位置并替换
    for (NSInteger i = 0; i < params.count; i++) {
        YLBuyConditionModel *model = params[i];
        for (NSInteger j = 0; j < self.multiSelectModels.count; j++) {
            NSMutableArray *arr = (NSMutableArray *)self.multiSelectModels[j];
            for (NSInteger k = 0; k < arr.count; k++) {
                YLBuyConditionModel *model1 = arr[k];
                if ([model1.title isEqualToString:model.title]) {
                    [arr replaceObjectAtIndex:k withObject:model];
                    break;
                }
            }
            [self.multiSelectModels replaceObjectAtIndex:j withObject:arr];
        }
    }
    
    // 将上面修改好的数组传给控制器
//    YLSubscribeMultiSelectController *multi = [[YLSubscribeMultiSelectController alloc] init];
//    multi.lowPrice = self.lowPrice;
//    multi.highPrice = self.highPrice;
//    __weak typeof(self) weakSelf = self;
    
    YLSubscribeMultiSelectController *multi = [[YLSubscribeMultiSelectController alloc] init];
    multi.lowPrice = self.lowPrice;
    multi.highPrice = self.highPrice;
    multi.selectParamModels = self.multiSelectModels;
    multi.headerTitles = self.headerTitles;
    __weak typeof(self) weakSelf = self;

    // ------------------------重置筛选条件----------------------------
    multi.restAllConditionBlock = ^(NSArray *multiSelectModels) {
        // 替换原来的数组数据
    };
    
    // ------------------------确定筛选条件----------------------------
    multi.sureBlock = ^(NSArray *multiSelectModels) {
        
        NSMutableDictionary *selectParam = [weakSelf selectParamWithMultiSelectModels:multiSelectModels];
        YLAccount *account = [YLAccountTool account];
        [selectParam setObject:account.telephone forKey:@"telephone"];
        [selectParam setObject:model.subscribeId forKey:@"id"];
        NSString *urlString = @"http://ucarjava.bceapp.com/subscribe?method=upd";
        [YLRequest GET:urlString parameters:selectParam success:^(id  _Nonnull responseObject) {
            if ([responseObject[@"code"] isEqualToNumber:[NSNumber numberWithInteger:200]]) {
                [weakSelf loadData];
                [NSString showMessage:@"修改成功"];
            } else {
                [weakSelf loadData];
                NSString *string = responseObject[@"message"];
                [NSString showMessage:string];
            }
        } failed:nil];
        [weakSelf.navigationController popViewControllerAnimated:YES];
    };
    
    [self.navigationController pushViewController:multi animated:YES];
    
    
//    NSString *urlString = @"http://ucarjava.bceapp.com/subscribe?method=upd";
//    [self yl__initMultiSelectView:urlString subcribeId:model.subscribeId];
}

- (void)deleteClick:(NSIndexPath *)indexPath {
    NSLog(@"删除");
    MBProgressHUD *hub = [[MBProgressHUD alloc] initWithView:self.view];
    hub.detailsLabel.text = @"正在处理，请稍后";
    [hub showAnimated:YES];
    [self.view addSubview:hub];
    
    YLSubscribeModel *model = self.groups[indexPath.section];
    NSString *urlString = @"http://ucarjava.bceapp.com/subscribe?method=del";
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    YLAccount *account = [YLAccountTool account];
    if (account) {
        [param setObject:account.telephone forKey:@"telephone"];
    }
    [param setObject:model.subscribeId forKey:@"id"];
    __weak typeof(self) weakSelf = self;
    [YLRequest GET:urlString parameters:param success:^(id  _Nonnull responseObject) {
        if ([responseObject[@"code"] isEqualToNumber:[NSNumber numberWithInteger:200]]) {
            [weakSelf loadData];
            [hub removeFromSuperview];
            [NSString showMessage:@"删除成功"];
            
        } else {
            [hub removeFromSuperview];
            NSLog(@"%@", responseObject[@"message"]);
        }
    } failed:nil];
}


// ---------------------------------分隔符---------------------------------

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//    return self.groups.count;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    return [self.results[section] count];
//}
//
//- (YLSubscribeCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//
//    YLSubscribeCell *cell = [YLSubscribeCell cellWithTableView:tableView];
//    YLSubscribeCellFrame *cellFrame = self.results[indexPath.section][indexPath.row];
//    cell.cellFrame = cellFrame;
//    return cell;
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    YLSubscribeCellFrame *cellFrame = self.results[indexPath.section][indexPath.row];
//    return cellFrame.cellHeight;
//}
//
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    YLSubscribeCellFrame *cellFrame = self.results[indexPath.section][indexPath.row];
//    YLSubscribeDetailModel *detailModel = cellFrame.model;
//    YLTableViewModel *model = [YLTableViewModel mj_objectWithKeyValues:detailModel];
//    YLDetailController *detail = [[YLDetailController alloc] init];
//    detail.model = model;
//    [self.navigationController pushViewController:detail animated:YES];
//}



- (NSMutableArray<YLSubscribeModel *> *)groups {
    if (!_groups) {
        _groups = [NSMutableArray array];
    }
    return _groups;
}

- (NSMutableArray *)results {
    if (!_results) {
        _results = [NSMutableArray array];
    }
    return _results;
}

- (YLNoneView *)noneView {
    if (!_noneView) {
        _noneView = [[YLNoneView alloc] init];
        _noneView.title = @"暂无订阅记录";
        [_noneView hideBtn];
        _noneView.hidden = YES;
    }
    return _noneView;
}

- (NSMutableArray *)multiSelectModels {
    if (!_multiSelectModels) {
        _multiSelectModels = [NSMutableArray array];
    }
    return _multiSelectModels;
}

- (NSMutableArray *)params {
    if (_params) {
        _params = [NSMutableArray array];
    }
    return _params;
}

@end
