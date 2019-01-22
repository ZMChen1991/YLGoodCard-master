//
//  YLSubscribeMultiSelectController.m
//  YLGoodCard
//
//  Created by lm on 2019/1/18.
//  Copyright © 2019 Chenzhiming. All rights reserved.
//

#import "YLSubscribeMultiSelectController.h"
#import "YLBuyConditionModel.h"
#import "YLConditionCell.h"
#import "YLCollectHeader.h"
#import "YLSubscribeBrandController.h"
#import "YLSubscribePriceView.h"

static NSString *const cellID = @"YLSelectCell";
static NSString *const footerID = @"YLSelectFooter";
static NSString *const headerID = @"YLSelectheader";

@interface YLSubscribeMultiSelectController () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *multiSelectModels;
//@property (nonatomic, strong) NSArray *headerTitles;
@property (nonatomic, strong) NSMutableArray *brands;
@property (nonatomic, strong) NSMutableArray *priceArray;
//@property (nonatomic, strong) YLBuyConditionModel *priceModel;

@end

@implementation YLSubscribeMultiSelectController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"添加订阅";
    
    [self.view addSubview:self.collectionView];
    [self yl_initView];
    if (!self.selectParamModels) {
        [self yl__initData];
    }
    
    
}

- (void)yl__initData {
    
    [self.multiSelectModels removeAllObjects];
    // 详细参数
    /**
     price:@[@"不限", @"3万以下", @"3-5万",@"5-7万", @"7-9万", @"9-12万",@"12-16万", @"16-20万", @"20万以上"]
     brand:@[@"不限",@"雪佛兰", @"大众", @"丰田", @"日产", @"本田", @"现代", @"别克", @"现代", @"马自达", @"福特", @"起亚"]
     */
    NSArray *data = @[@[@"品牌选择"],
                      @[@"两厢轿车", @"三厢轿车", @"跑车", @"SUV", @"MPV", @"面包车", @"皮卡"],
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
    NSArray *params2 = @[@"brand", @"bodyStructure", @"isLocal", @"gearbox", @"vehicleAge", @"course", @"emission", @"emissionStandard", @"color", @"seatsNum", @"fuelForm", @"country", @"other"];
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
    
    self.headerTitles = @[@"品牌", @"车型", @"车牌所在地", @"变速箱", @"车龄 (单位:年)", @"行驶里程 (单位:万公里)", @"排量 (单位:升)", @"排放标准", @"颜色", @"座位数", @"燃油类型", @"国别",  @"亮点配置"];
}

- (void)yl_initView {
    
    CGFloat btnY = CGRectGetMaxY(self.collectionView.frame);
    CGFloat btnW = self.view.bounds.size.width / 2;
    CGFloat btnH = 44;
    UIButton *restBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    restBtn.frame = CGRectMake(0, btnY, btnW, btnH);
    [restBtn setTitle:@"取消" forState:UIControlStateNormal];
    [restBtn setTitleColor:YLColor(8.f, 169.f, 255.f) forState:UIControlStateNormal];
    restBtn.backgroundColor = [UIColor whiteColor];
    restBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    restBtn.layer.borderWidth = 1.f;
    restBtn.layer.borderColor = YLColor(8.f, 169.f, 255.f).CGColor;
    [restBtn addTarget:self action:@selector(restALLCondition) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:restBtn];
    
    UIButton *sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    sureBtn.frame = CGRectMake(btnW, btnY, btnW, btnH);
    [sureBtn setTitle:@"确定" forState:UIControlStateNormal];
    [sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    sureBtn.backgroundColor = YLColor(8.f, 169.f, 255.f);
    sureBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [sureBtn addTarget:self action:@selector(sureClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sureBtn];
}

- (void)restALLCondition {
    NSLog(@"-------重置所有条件--------");
    [self yl__initData];
    
    if (self.restAllConditionBlock) {
        self.restAllConditionBlock(self.multiSelectModels);
    }
}

- (void)sureClick {
    NSLog(@"-------条件已确认--------");
    [self.multiSelectModels replaceObjectAtIndex:0 withObject:self.brands];
    [self.multiSelectModels addObject:self.priceArray];
    if (self.sureBlock) {
        self.sureBlock(self.multiSelectModels);
    }
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.multiSelectModels.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.multiSelectModels[section] count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    YLConditionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    YLBuyConditionModel *model = self.multiSelectModels[indexPath.section][indexPath.row];
    cell.model = model;
    return cell;
}

// 如果单独出现这个方法，是不会执行的，必须设定尺寸才能执行
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        UICollectionReusableView *header = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:headerID forIndexPath:indexPath];
        // 此处的header可能会产生复用，要将之前原有的子视图移除掉
        for (YLCollectHeader *view in header.subviews) {
            [view removeFromSuperview];
        }
        YLCollectHeader *head = [[YLCollectHeader alloc] initWithFrame:header.bounds];
//        head.backgroundColor = [UIColor redColor];
        head.title = self.headerTitles[indexPath.section];
        [header addSubview:head];
        return header;
    } else {
        UICollectionReusableView *footer = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:footerID forIndexPath:indexPath];
        // 此处的header可能会产生复用，要将之前原有的子视图移除掉
        for (YLSubscribePriceView *view in footer.subviews) {
            [view removeFromSuperview];
        }
        YLSubscribePriceView *priceView = [[YLSubscribePriceView alloc] initWithFrame:footer.bounds];
        priceView.lowPriceStr = self.lowPrice;
        priceView.highPriceStr = self.highPrice;
        priceView.priceBlock = ^(NSInteger lowPrice, NSInteger highPrice) {
            if (lowPrice > highPrice) {
                [NSString showMessage:@"最低价不能大于最高价"];
            } else {
                NSString *param = [NSString stringWithFormat:@"%ldfgf%ld", lowPrice * 10000, highPrice * 10000];
                NSString *price = [NSString stringWithFormat:@"%ld-%ld万",lowPrice, highPrice];
                YLBuyConditionModel *model = [[YLBuyConditionModel alloc] init];
                model.title = price;
                model.detail = price;
                model.param = param;
                model.isSelect = YES;
                model.key = @"price";
                [self.priceArray addObject:model];
            }
        };
//        priceView.backgroundColor = [UIColor yellowColor];
        [footer addSubview:priceView];
        return footer;
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    CGSize itemSize = CGSizeMake(YLScreenWidth, 30);
    return itemSize;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    
    if (section == 0) {
        CGSize itemSize = CGSizeMake(YLScreenWidth, 86);
        return itemSize;
    } else {
        return CGSizeZero;
    }
}


#pragma mark <UICollectionViewDelegate>
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    // 最后一组，模型参数为1或0
    if (indexPath.section == self.multiSelectModels.count - 1) {
        YLBuyConditionModel *model = self.multiSelectModels[indexPath.section][indexPath.row];
        model.isSelect = !model.isSelect;
        if (model.isSelect) {
            model.param = @"1";
        } else {
            model.param = @"0";
        }
        [self.collectionView reloadItemsAtIndexPaths:@[indexPath]];
    } else if (indexPath.section == 0) { // 第一组为品牌模型数组
        YLSubscribeBrandController *brand = [[YLSubscribeBrandController alloc] init];
        brand.buyBrandBlock = ^(NSString *brand, NSString *series) {
            
            NSLog(@"YLSubscribeMultiSelectController-筛选：%@-%@", brand, series);
            // 将品牌和车系转为模型
            YLBuyConditionModel *brandModel = [[YLBuyConditionModel alloc] init];
            brandModel.title = brand;
            brandModel.detail = brand;
            brandModel.param = brand;
            brandModel.key = @"brand";
            brandModel.isSelect = YES;
            
            YLBuyConditionModel *seriesModel = [[YLBuyConditionModel alloc] init];
            seriesModel.title = series;
            seriesModel.detail = series;
            seriesModel.param = series;
            seriesModel.key = @"series";
            seriesModel.isSelect = YES;
            
            [self.brands addObjectsFromArray:@[brandModel, seriesModel]];
        };
        [self.navigationController pushViewController:brand animated:YES];
    } else {
        YLBuyConditionModel *model = self.multiSelectModels[indexPath.section][indexPath.row];
        model.isSelect = !model.isSelect;
        [self.collectionView reloadItemsAtIndexPaths:@[indexPath]];
    }
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        // 小cell
        CGFloat leftMargin = 15;
        CGFloat itemSpacing = 15;
        CGFloat topMargin = 5;
        CGFloat width = ([UIScreen mainScreen].bounds.size.width - 2 * leftMargin - 2 * itemSpacing) / 3;
        layout.itemSize = CGSizeMake(width, 36);
        // cell的行间距
        layout.minimumLineSpacing = itemSpacing;
        // cell的垂直间距
        layout.minimumInteritemSpacing = itemSpacing;
        // collectionView的滑动方向
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        //    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        // collectionView的边缘间距
        layout.sectionInset = UIEdgeInsetsMake(topMargin, leftMargin, 15, leftMargin);
        CGRect rect = CGRectMake(0, 0, YLScreenWidth, YLScreenHeight - 64 - 44);
        _collectionView = [[UICollectionView alloc] initWithFrame:rect collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.bounces = NO;
        [_collectionView registerClass:[YLConditionCell class] forCellWithReuseIdentifier:cellID];
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:footerID];
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerID];
    }
    return _collectionView;
}

- (NSMutableArray *)multiSelectModels {
    if (!_multiSelectModels) {
        _multiSelectModels = [NSMutableArray array];
    }
    return _multiSelectModels;
}
- (NSMutableArray *)brands {
    if (!_brands) {
        _brands = [NSMutableArray array];
    }
    return _brands;
}
- (NSMutableArray *)priceArray {
    if (!_priceArray) {
        _priceArray = [NSMutableArray array];
    }
    return _priceArray;
}

- (void)setSelectParamModels:(NSMutableArray *)selectParamModels {
    _selectParamModels = selectParamModels;
    
    self.multiSelectModels = selectParamModels;
    [self.collectionView reloadData];
}

- (void)setLowPrice:(NSString *)lowPrice {
    _lowPrice = lowPrice;
}

- (void)setHighPrice:(NSString *)highPrice {
    _highPrice = highPrice;
}
@end
