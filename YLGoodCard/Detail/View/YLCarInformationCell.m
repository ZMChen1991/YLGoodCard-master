//
//  YLCarInformationCell.m
//  YLGoodCard
//
//  Created by lm on 2018/11/6.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import "YLCarInformationCell.h"
#import "YLBannerCollectionView.h"

@interface YLCarInformationCell ()

//@property (nonatomic, strong) UIImageView *blemish;// 照片
@property (nonatomic, strong) UILabel *blemishL;// 详情
@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, strong) NSMutableArray *icons;
@property (nonatomic, strong) NSMutableArray *details;
@property (nonatomic, strong) YLBannerCollectionView *banner;

@end

@implementation YLCarInformationCell

+ (instancetype)cellWithTable:(UITableView *)tableView {
    
    static NSString *ID = @"YLCarInformationCell";
    YLCarInformationCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[YLCarInformationCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.titles = @[@"正侧",@"正前",@"前排",@"后排",@"中控",@"发动机舱"];
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    
    for (NSInteger i = 0; i < self.titles.count; i++) {
        UIImageView *icon = [[UIImageView alloc] init];
        icon.backgroundColor = YLColor(233.f, 233.f, 233.f);
        icon.layer.cornerRadius = 5.f;
        icon.layer.masksToBounds = YES;
        icon.contentMode = UIViewContentModeScaleAspectFill;
//        icon.backgroundColor = [UIColor redColor];
        [self addSubview:icon];
        [self.icons addObject:icon];
        
        UILabel *detail = [[UILabel alloc] init];
        detail.textColor = [UIColor grayColor];
//        detail.backgroundColor = [UIColor greenColor];
        [self addSubview:detail];
        [self.details addObject:detail];
    }
    
    YLBannerCollectionView *blemish = [[YLBannerCollectionView alloc] initWithFrame:CGRectMake(YLLeftMargin, 1385, self.frame.size.width - 2 * YLLeftMargin, 200)];
//    blemish.backgroundColor = YLColor(233.f, 233.f, 233.f);
    blemish.layer.cornerRadius = 5.f;
    blemish.layer.masksToBounds = YES;
    [self addSubview:blemish];
    self.banner = blemish;
    
    UILabel *blemishL = [[UILabel alloc] initWithFrame:CGRectMake(YLLeftMargin, CGRectGetMaxY(self.banner.frame) + 5, self.frame.size.width - 2 * YLLeftMargin, 20)];
    blemishL.textColor = [UIColor grayColor];
//    blemishL.text = @"瑕疵";
    [self addSubview:blemishL];
    self.blemishL = blemishL;
    
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    CGFloat width = self.frame.size.width - 2 * YLLeftMargin;
    CGFloat iconH = 5;
    for (NSInteger i = 0; i < self.titles.count; i++) {
        UIImageView *icon = self.icons[i];
        UILabel *detail = self.details[i];
        
        icon.frame = CGRectMake(YLLeftMargin, iconH, width, 200);
        detail.frame = CGRectMake(YLLeftMargin, CGRectGetMaxY(icon.frame) + 5, width, 20);
        detail.text = self.titles[i];
        iconH += 230;
        NSLog(@"%f", iconH);
    }
    
//    self.banner.frame = CGRectMake(YLLeftMargin, iconH, width, 200);
//    self.blemishL.frame = CGRectMake(YLLeftMargin, CGRectGetMaxY(self.banner.frame) + 5, width, 20);
    
//    self.icon.frame = CGRectMake(YLLeftMargin, 5, width, 200);
//    self.detail.frame = CGRectMake(YLLeftMargin, CGRectGetMaxY(self.icon.frame) + 5, width, 20);
}

//- (void)setImage:(NSString *)image {
//    _image = image;
////    [self.icon sd_setImageWithURL:[NSURL URLWithString:image] placeholderImage:nil];
//}
//
//- (void)setTitle:(NSString *)title {
//    _title = title;
////    self.detail.text = title;
//}

- (void)setImages:(NSArray *)images {
    _images = images;
    
//    for (NSInteger i = 0; i < images.count; i++) {
//        if (!images[i] || i < 7) {
//            return;
//        }
//        UIImageView *icon = self.icons[i];
//        [icon sd_setImageWithURL:[NSURL URLWithString:images[i]] placeholderImage:nil];
//    }
    
    
    for (NSInteger i = 0; i < self.titles.count; i++) {
        UIImageView *icon = self.icons[i];
        if (i < images.count) {
            if (!images[i] || icon == nil) {
                return;
            }
            [icon sd_setImageWithURL:[NSURL URLWithString:images[i]] placeholderImage:nil];
        }
    }
}

- (void)setBlemishs:(NSArray *)blemishs {
    _blemishs = blemishs;
    self.banner.images = blemishs;
    self.blemishL.text = [NSString stringWithFormat:@"瑕疵,共%ld张", blemishs.count];
}

// cell获取的宽不对，这里重设宽
- (void)setFrame:(CGRect)frame {
    frame.size.width = YLScreenWidth;
    [super setFrame:frame];
}

- (NSMutableArray *)details {
    if (!_details) {
        _details = [NSMutableArray array];
    }
    return _details;
}

- (NSMutableArray *)icons {
    if (!_icons) {
        _icons = [NSMutableArray array];
    }
    return _icons;
}



@end
