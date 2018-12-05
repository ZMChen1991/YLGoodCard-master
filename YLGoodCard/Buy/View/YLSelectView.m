//
//  YLSelectView.m
//  YLGoodCard
//
//  Created by lm on 2018/11/10.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import "YLSelectView.h"
#import "YLConditionCell.h"
#import "YLCollectHeader.h"

static NSString *cellID = @"YLSelectViewCell";
static NSString *HeaderID = @"YLCollectHeader";

@interface YLSelectView () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation YLSelectView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 5; // 最小行间距
    //    layout.minimumInteritemSpacing = 5;// 最小item间距
    layout.sectionInset = UIEdgeInsetsMake(5, 15, 5, 15); // section的内边距:上左下右
    layout.headerReferenceSize = CGSizeMake(0, 20);// 大概是表头宽是固定不变的
    //    CGSize size = (CGSizeMake((self.view.frame.size.width) - 30 - 20)/3, 50);
    //    NSLog(@"size.width:%f", size.width);
    layout.itemSize = CGSizeMake((self.frame.size.width-30-20)/3, 36);
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.collectionView];
    
    // 注册cell
    [self.collectionView registerClass:[YLConditionCell class] forCellWithReuseIdentifier:cellID];
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:HeaderID];
    
    // 设置代理
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 8;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    if (section == 0) {
        return 7;
    }
    if (section == 1) {
        return 4;
    }
    if (section == 2) {
        return 9;
    }
    if (section == 3) {
        return 2;
    }
    if (section == 4) {
        return 7;
    }
    if (section == 5) {
        return 5;
    }if (section == 6) {
        return 3;
    }
    if (section == 7) {
        return 3;
    }else {
        return 6;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    YLConditionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"%ld--%ld", (long)indexPath.section, (long)indexPath.row);
}

// headerView、footerView
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionReusableView *header = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:HeaderID forIndexPath:indexPath];
    if (!header) {
        header = [[UICollectionReusableView alloc] init];
    }
    YLCollectHeader *head = [[YLCollectHeader alloc] initWithFrame:header.bounds];
    [header addSubview:head];
    return (UICollectionReusableView *)header;
}

// headerView的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    
    CGSize itemSize = CGSizeMake(100, 20);
    return itemSize;
}
@end
