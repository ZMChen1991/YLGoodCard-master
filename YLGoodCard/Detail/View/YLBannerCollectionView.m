//
//  YLBannerCollectionView.m
//  YLCollection
//
//  Created by lm on 2018/12/15.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import "YLBannerCollectionView.h"
#import "YLVehicleModel.h"

@interface YLBannerCollectionView () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collection;
@property (nonatomic, strong) UILabel *label;

@end

@implementation YLBannerCollectionView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = YLColor(233.f, 233.f, 233.f);
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    layout.itemSize = CGSizeMake(self.frame.size.width, self.frame.size.height);
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    self.collection = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) collectionViewLayout:layout];
//    self.collection = [[UICollectionView alloc] init];
//    self.collection.collectionViewLayout = layout;
    self.collection.backgroundColor = [UIColor whiteColor];
    self.collection.pagingEnabled = YES;
    self.collection.delegate = self;
    self.collection.dataSource = self;
    self.collection.showsHorizontalScrollIndicator = NO;
    self.collection.bounces = NO;
    [self.collection registerClass:[YlBannerCollectionCell class] forCellWithReuseIdentifier:@"YlBannerCollectionCell"];
    [self addSubview:self.collection];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width - 50, self.frame.size.height - 30, 40, 20)];
//    UILabel *label = [[UILabel alloc] init];
//    label.backgroundColor = YLColor(233.f, 233.f, 233.f);
    label.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    label.textAlignment = NSTextAlignmentCenter;
//    label.text = @"1/30";
    label.textColor = [UIColor lightGrayColor];
    label.font = [UIFont systemFontOfSize:12];
    label.layer.cornerRadius = 10.f;
    label.layer.masksToBounds = YES;
    [self addSubview:label];
    self.label = label;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSLog(@"%ld", self.images.count);
    return self.images.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    YlBannerCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"YlBannerCollectionCell" forIndexPath:indexPath];
//    YLVehicleModel *model = self.images[indexPath.row];
    cell.image = self.images[indexPath.row];
//    cell.backgroundColor = YLRandomColor;
    return cell;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSInteger index = scrollView.contentOffset.x / self.frame.size.width + 1;
    self.label.text = [NSString stringWithFormat:@"%ld/%ld", index, self.images.count];
}

- (void)setImages:(NSArray *)images {
    _images = images;
    if (images.count == 0) {
        self.label.hidden = YES;
    } else {
       self.label.text = [NSString stringWithFormat:@"1/%ld", self.images.count];
    }
    [self.collection reloadData];
}


- (void)layoutSubviews {
    
    [super layoutSubviews];
//    self.collection.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
//    self.label.frame = CGRectMake(self.frame.size.width - 60, self.frame.size.height - 30, 50, 20);
}


@end


@interface YlBannerCollectionCell ()

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation YlBannerCollectionCell

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.bounds];
//        imageView.layer.borderWidth = 0.5f;
//        imageView.layer.borderColor = [UIColor redColor].CGColor;
//        imageView.backgroundColor = [UIColor grayColor];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
//        imageView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:imageView];
        self.imageView = imageView;
    }
    return self;
}

- (void)setImage:(NSString *)image {
    _image = image;
    
    // 这里使用SDImage
//    self.imageView.image = [UIImage imageNamed:image];
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:image] placeholderImage:nil];
}

@end
