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
@property (nonatomic, strong) UILabel *messageL;
@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, strong) NSMutableArray *icons;
@property (nonatomic, strong) NSMutableArray *details;
@property (nonatomic, strong) YLBannerCollectionView *banner;
@property (nonatomic, assign) NSInteger index;

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
        detail.font = [UIFont systemFontOfSize:14];
//        detail.backgroundColor = [UIColor greenColor];
        [self addSubview:detail];
        [self.details addObject:detail];
    }
    
    YLBannerCollectionView *blemish = [[YLBannerCollectionView alloc] initWithFrame:CGRectMake(YLLeftMargin, 1385, self.frame.size.width - 2 * YLLeftMargin, 200)];
//    blemish.backgroundColor = YLColor(233.f, 233.f, 233.f);
    blemish.layer.cornerRadius = 5.f;
    blemish.layer.masksToBounds = YES;
    __weak typeof(self) weakSelf = self;
    blemish.bannerCollectViewBlock = ^(NSInteger index) {
        weakSelf.index = index - 1;
        if (weakSelf.index < weakSelf.blemishTitles.count) {
            NSString *str = weakSelf.blemishTitles[weakSelf.index];
            CGSize titleSize = [str getSizeWithFont:[UIFont systemFontOfSize:14]];
            CGFloat fontSize = titleSize.width > YLScreenWidth - 2 * YLLeftMargin - CGRectGetWidth(weakSelf.blemishL.frame) ? 12:14;
            weakSelf.messageL.font = [UIFont systemFontOfSize:fontSize];
            weakSelf.messageL.frame = CGRectMake(CGRectGetMaxX(weakSelf.blemishL.frame) + 10, CGRectGetMaxY(weakSelf.banner.frame) + 5, YLScreenWidth - 2 * YLLeftMargin - CGRectGetWidth(weakSelf.blemishL.frame), 20);
            weakSelf.messageL.text = weakSelf.blemishTitles[weakSelf.index];
        }
    };
    [self addSubview:blemish];
    self.banner = blemish;
    
    UILabel *blemishL = [[UILabel alloc] initWithFrame:CGRectMake(YLLeftMargin, CGRectGetMaxY(self.banner.frame) + 5, self.frame.size.width / 3, 20)];
//    blemishL.backgroundColor = [UIColor redColor];
    blemishL.textColor = [UIColor grayColor];
    blemishL.font = [UIFont systemFontOfSize:14];
//    blemishL.text = @"瑕疵";
    [self addSubview:blemishL];
    self.blemishL = blemishL;
    
    UILabel *messageL = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(blemishL.frame) + 10, CGRectGetMaxY(self.banner.frame) + 5, YLScreenWidth - 2 * YLLeftMargin - CGRectGetWidth(blemishL.frame), 20)];
    messageL.textColor = [UIColor grayColor];
    messageL.font = [UIFont systemFontOfSize:14];
    messageL.numberOfLines = 0;
//    messageL.backgroundColor = [UIColor redColor];
    [self addSubview:messageL];
    self.messageL = messageL;
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
//        NSLog(@"%f", iconH);
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
    NSString *blemishStr = [NSString stringWithFormat:@"瑕疵,共%ld张", blemishs.count];
    CGSize size = [blemishStr getSizeWithFont:[UIFont systemFontOfSize:14]];
    self.blemishL.frame = CGRectMake(YLLeftMargin, CGRectGetMaxY(self.banner.frame) + 5, size.width, 20);
    self.blemishL.text = blemishStr;
    self.messageL.frame = CGRectMake(CGRectGetMaxX(self.blemishL.frame) + 10, CGRectGetMaxY(self.banner.frame) + 5, YLScreenWidth - 2 * YLLeftMargin - CGRectGetWidth(self.blemishL.frame), 20);
}

- (void)setBlemishTitles:(NSArray *)blemishTitles {
    _blemishTitles = blemishTitles;
    if (!blemishTitles.count) {
        return;
    }
    NSString *str = self.blemishTitles[0];
    CGSize titleSize = [str getSizeWithFont:[UIFont systemFontOfSize:14]];
    CGFloat fontSize = titleSize.width > YLScreenWidth - 2 * YLLeftMargin - CGRectGetWidth(self.blemishL.frame) ? 12:14;
    self.messageL.font = [UIFont systemFontOfSize:fontSize];
    self.messageL.text = self.blemishTitles[0];
}

//- (void)setBlemishModels:(NSArray *)blemishModels {
//    _blemishModels = blemishModels;
//    for (NSInteger i = 0; i < blemishModels.count; i++) {
//        UIImageView *icon = self.icons[i];
//        YLBlemishModel *model = blemishModels[i];
//        if (icon == nil || model == nil) {
//            return;
//        }
//        [icon sd_setImageWithURL:[NSURL URLWithString:model.img] placeholderImage:nil];
//    }
//}

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
