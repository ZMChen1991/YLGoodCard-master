//
//  YLCarInformationCell.m
//  YLGoodCard
//
//  Created by lm on 2018/11/6.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import "YLCarInformationCell.h"

@interface YLCarInformationCell ()

@property (nonatomic, strong) UIImageView *icon;// 照片
@property (nonatomic, strong) UILabel *detail;// 详情

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
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    
    UIImageView *icon = [[UIImageView alloc] init];
    icon.backgroundColor = YLColor(233.f, 233.f, 233.f);
    icon.layer.cornerRadius = 5.f;
    icon.layer.masksToBounds = YES;
    icon.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:icon];
    self.icon = icon;
    
    UILabel *detail = [[UILabel alloc] init];
    detail.textColor = [UIColor grayColor];
//    detail.text = @"正前 前脸完好";
    [self addSubview:detail];
    self.detail = detail;
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    float width = self.frame.size.width - 2 * YLLeftMargin;
    self.icon.frame = CGRectMake(YLLeftMargin, 5, width, 200);
    self.detail.frame = CGRectMake(YLLeftMargin, CGRectGetMaxY(self.icon.frame) + 5, width, 20);
}

- (void)setImage:(NSString *)image {
    _image = image;
    [self.icon sd_setImageWithURL:[NSURL URLWithString:image] placeholderImage:nil];
}

- (void)setTitle:(NSString *)title {
    _title = title;
    self.detail.text = title;
}

@end
