//
//  YLCustomPrice.m
//  YLGoodCard
//
//  Created by lm on 2018/11/7.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import "YLCustomPrice.h"
#import "YLCondition.h"

static NSString *const cellID = @"YLCustomPriceCell";
static NSString *const footerID = @"YLCustomPriceFooter";

@interface YLCustomPrice () <UITextFieldDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UITextField *lowPrice;
@property (nonatomic, strong) UITextField *highPrice;
@property (nonatomic, strong) YLCondition *sureBtn;

@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation YLCustomPrice

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.collectionView];
        [self yl_initView];
    }
    return self;
}

- (void)yl_initView {
    CGFloat btnH = 20;
    UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.collectionView.frame) + 1, YLScreenWidth, 1)];
    line.backgroundColor = YLColor(233.f, 233.f, 233.f);
    [self addSubview:line];
    // 自定义价格
    UILabel *customPrice = [[UILabel alloc] initWithFrame:CGRectMake(YLLeftMargin, CGRectGetMaxY(line.frame) + YLLeftMargin, 112, btnH)];
    customPrice.text = @"自定义价格(万)";
    customPrice.textColor = YLColor(172.f, 172.f, 172.f);
    customPrice.font = [UIFont systemFontOfSize:14];
    [self addSubview:customPrice];
    
    UITextField *lowPrice = [[UITextField alloc] initWithFrame:CGRectMake(YLLeftMargin, CGRectGetMaxY(customPrice.frame)+YLMargin, 80, 30)];
    lowPrice.placeholder = @"最低价";
    lowPrice.textAlignment = NSTextAlignmentCenter;
    lowPrice.font = [UIFont systemFontOfSize:15];
    lowPrice.layer.borderWidth = 1.f;
    lowPrice.layer.borderColor = YLColor(233.f, 233.f, 233.f).CGColor;
    lowPrice.delegate = self;
    [self addSubview:lowPrice];
    self.lowPrice = lowPrice;
    
    UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(lowPrice.frame) + YLMargin, CGRectGetMaxY(lowPrice.frame) - 15, 9, 1)];
    line1.backgroundColor = [UIColor blackColor];
    [self addSubview:line1];
    
    UITextField *highPrice = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(line1.frame)+YLMargin, CGRectGetMaxY(customPrice.frame)+YLMargin, 80, 30)];
    highPrice.placeholder = @"最高价";
    //    highPrice.backgroundColor = [UIColor redColor];
    highPrice.textAlignment = NSTextAlignmentCenter;
    highPrice.layer.borderWidth = 1.f;
    highPrice.layer.borderColor = YLColor(233.f, 233.f, 233.f).CGColor;
    highPrice.font = [UIFont systemFontOfSize:15];
    highPrice.delegate = self;
    [self addSubview:highPrice];
    self.highPrice = highPrice;
    
    YLCondition *sureBtn = [[YLCondition alloc] initWithFrame:CGRectMake(self.frame.size.width - 80 - YLLeftMargin, CGRectGetMaxY(customPrice.frame)+10, 80, 30)];
    sureBtn.type = YLConditionTypeBlue;
    [sureBtn setTitle:@"确定" forState:UIControlStateNormal];
    sureBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [sureBtn addTarget:self action:@selector(sureClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:sureBtn];
    self.sureBtn = sureBtn;
}

- (void)sureClick {
    
    [self.highPrice resignFirstResponder];
    [self.lowPrice resignFirstResponder];
    
    // 将选中的价格条件改为不选中
    for (YLBuyConditionModel *model in self.models) {
        if (model.isSelect) {
            model.isSelect = !model.isSelect;
        }
    }
    
    if (self.surePriceBlock) {
        self.surePriceBlock(self.lowPrice.text, self.highPrice.text);
    }
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.models.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    UILabel *label = [[UILabel alloc] init];
    label.frame = cell.bounds;
    label.backgroundColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:14];
    [cell.contentView addSubview:label];
    YLBuyConditionModel *model = self.models[indexPath.row];
    if (model.isSelect) {
        label.textColor = YLColor(8.f, 169.f, 255.f);
    } else {
        label.textColor = YLColor(51.f, 51.f, 51.f);
    }
    label.text = model.title;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    // 还原
    for (YLBuyConditionModel *model in self.models) {
        if (model.isSelect) {
            model.isSelect = !model.isSelect;
        }
    }
    self.lowPrice.text = @"";
    self.highPrice.text = @"";
    
    // 修改
    YLBuyConditionModel *model = self.models[indexPath.row];
    model.isSelect = !model.isSelect;
    [self.collectionView reloadItemsAtIndexPaths:@[indexPath]];
    NSLog(@"-----%@--", model.title);
    if (self.customPriceBlock) {
        self.customPriceBlock(self.models);
    }
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        // 小cell
        CGFloat leftMargin = 15;
        CGFloat itemSpacing = 15;
        CGFloat topMargin = 15;
        CGFloat width = ([UIScreen mainScreen].bounds.size.width - 2 * leftMargin - 2 * itemSpacing) / 3;
        layout.itemSize = CGSizeMake(width, 20);
        // cell的行间距
        layout.minimumLineSpacing = itemSpacing;
        // cell的垂直间距
        layout.minimumInteritemSpacing = itemSpacing;
        // collectionView的滑动方向
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        //    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        // collectionView的边缘间距
        layout.sectionInset = UIEdgeInsetsMake(topMargin, leftMargin, 0, leftMargin);
        CGRect rect = CGRectMake(0, 0, YLScreenWidth, 120);
        _collectionView = [[UICollectionView alloc] initWithFrame:rect collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.bounces = NO;
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:cellID];
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:footerID];
    }
    return _collectionView;
}

// 如果单独出现这个方法，是不会执行的，必须设定尺寸才能执行
//- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
//    UICollectionReusableView *footer = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"footer" forIndexPath:indexPath];
//
//    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//    btn.frame = CGRectMake(50, 20, 100, 50);
//    btn.backgroundColor = [UIColor redColor];
//    [btn setTitle:@"返回" forState:UIControlStateNormal];
//    [btn addTarget:self action:@selector(btnReturn) forControlEvents:UIControlEventTouchUpInside];
//    [footer addSubview:btn];
//
//    return footer;
//}
//
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
//    CGSize itemSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, 100);
//    return itemSize;
//}

//- (void)btnReturn {
//    NSLog(@"btnReturn");
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"NOTIFICATIONREFRESH" object:nil];
//}

- (void)setModels:(NSArray *)models {
    _models = [models copy];
    [self.collectionView reloadData];
}

//- (void)setLowModel:(YLBuyConditionModel *)lowModel {
//    _lowModel = lowModel;
//    if (![NSString isBlankString:lowModel.title]) {
//        self.lowPrice.text = lowModel.title;
//    }
//}

//- (void)setHighModel:(YLBuyConditionModel *)highModel {
//    _highModel = highModel;
//    if (![NSString isBlankString:highModel.title]) {
//        self.highPrice.text = highModel.title;
//    }
//}

@end
