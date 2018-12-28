//
//  YLBannerCollectionView.m
//  YLCollection
//
//  Created by lm on 2018/12/15.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import "YLBannerCollectionView.h"
//#import "YLVehicleModel.h"

//#define YLImageCachePath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"ImageCache.plist"]
#define YLImageCachePath(urlString) [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:[urlString lastPathComponent]]

@interface YLBannerCollectionView () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collection;
@property (nonatomic, strong) UILabel *label;
// 存放图片
@property (nonatomic, strong) NSMutableDictionary *imageCaches;
// 存放所有下载操作的队列
@property (nonatomic, strong) NSOperationQueue *queue;
// 存放所有的下载操作 (url是key，operation对象是value)
@property (nonatomic, strong) NSMutableDictionary *operations;

@end

@implementation YLBannerCollectionView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
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
    self.collection.backgroundColor = [UIColor whiteColor];
    self.collection.pagingEnabled = YES;
    self.collection.delegate = self;
    self.collection.dataSource = self;
    self.collection.showsHorizontalScrollIndicator = NO;
    self.collection.bounces = NO;
    [self.collection registerClass:[YlBannerCollectionCell class] forCellWithReuseIdentifier:@"YlBannerCollectionCell"];
    [self addSubview:self.collection];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width - 50, self.frame.size.height - 30, 40, 20)];
    label.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    label.textAlignment = NSTextAlignmentCenter;
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
//    NSLog(@"self.images.count:%ld", self.images.count);
    return self.images.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    YlBannerCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"YlBannerCollectionCell" forIndexPath:indexPath];
//    YLVehicleModel *model = self.images[indexPath.row];
//    cell.image = self.images[indexPath.row];
//    cell.backgroundColor = YLRandomColor;
    UIImage *image = self.imageCaches[self.images[indexPath.row]];
    if (image) {
        // 存在，说明图片已经下载成功，并缓存成功
        cell.image = image;
    } else {
        NSString *imageString = self.images[indexPath.row];
        NSData *data = [NSData dataWithContentsOfFile:YLImageCachePath(imageString)];
        if (data) {
            // data不为空，说明沙盒存在这个文件
            cell.image = [UIImage imageWithData:data];
        } else {
            // 反之沙盒中不存在这个文件
            // 下载前显示占位图片
            cell.image = [UIImage imageNamed:@"占位图"];
            // 下载图片
            [self downLoad:self.images[indexPath.row] indexPath:indexPath];
        }
    }
    return cell;
}

- (void)downLoad:(NSString *)imageUrl indexPath:(NSIndexPath *)indexPath {
    
    // 取出当前图片的URL对应的下载操作(operation对象)
    NSBlockOperation *operation = self.operations[imageUrl];
    if (operation) return;
    
    // 创建操作，下载图片
    __weak typeof(self) weakSelf = self;
    operation = [NSBlockOperation blockOperationWithBlock:^{
        NSURL *url = [NSURL URLWithString:imageUrl];
        NSData *data = [NSData dataWithContentsOfURL:url];
        UIImage *image = [UIImage imageWithData:data];
        
        // 回到主线程
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            if (image) {
                //                weakSelf.imageCaches[imageUrl] = image;
                [weakSelf.imageCaches setObject:image forKey:imageUrl];
                // 将图片存入沙盒中
                // 1.先将图片转化为NSData
                NSData *data = UIImagePNGRepresentation(image);
                
                // 2.再生成缓存路径
                BOOL success = [data writeToFile:YLImageCachePath(imageUrl) atomically:YES];
                if (success) {
                    NSLog(@"缓存图片成功");
                } else {
                    NSLog(@"缓存图片失败");
                }
            }
            // 从字典中移除下载操作，（防止operation越来越大,保证下载失败后能重新下载）
            [weakSelf.operations removeObjectForKey:imageUrl];
            // 刷新表格
            [weakSelf.collection reloadItemsAtIndexPaths:@[indexPath]];
            //            [weakSelf.collection reloadData];
        }];
    }];
    
    // 添加操作到队列中
    [self.queue addOperation:operation];
    // 添加到字典中（这句话是为了解决重复下载）
    self.operations[imageUrl] = operation;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    // 暂停下载
    [self.queue setSuspended:YES];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    // 恢复下载
    [self.queue setSuspended:NO];
    
    NSInteger index = scrollView.contentOffset.x / self.frame.size.width + 1;
    self.label.text = [NSString stringWithFormat:@"%ld/%ld", index, self.images.count];
}

- (void)setImages:(NSArray *)images {
    _images = images;
//    NSLog(@"images.count:%ld", images.count);
    if (images.count == 0) {
        self.label.hidden = YES;
    } else {
        self.label.hidden = NO;
       self.label.text = [NSString stringWithFormat:@"1/%ld", self.images.count];
    }
    [self.collection reloadData];
}

- (NSMutableDictionary *)imageCaches {
    if (!_imageCaches) {
        _imageCaches = [NSMutableDictionary dictionary];
    }
    return _imageCaches;
}

- (NSOperationQueue *)queue {
    
    if (!_queue) {
        self.queue = [[NSOperationQueue alloc] init];
    }
    return _queue;
}

- (NSMutableDictionary *)operations {
    
    if (!_operations) {
        self.operations = [[NSMutableDictionary alloc] init];
    }
    return _operations;
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
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

//- (void)setImage:(NSString *)image {
//    _image = image;
//
//    // 这里使用SDImage
////    self.imageView.image = [UIImage imageNamed:image];
//    [self.imageView sd_setImageWithURL:[NSURL URLWithString:image] placeholderImage:nil];
//}

- (void)setImage:(UIImage *)image {
    _image = image;
    self.imageView.image = image;
}

@end
