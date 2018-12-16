//
//  YLDetailHeaderView.m
//  YLGoodCard
//
//  Created by lm on 2018/11/6.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import "YLDetailHeaderView.h"
#import "YLCondition.h"
#import "YLBannerCollectionView.h"

// 375:360
@interface YLDetailHeaderView ()

@property (nonatomic, strong) YLBannerCollectionView *banner;// 滚动图
@property (nonatomic, strong) UIImageView *icon;// 图片--375:220:滚动图
@property (nonatomic, strong) UILabel *text;// 信息
@property (nonatomic, strong) UIView *tagView; // 标签集合视图
@property (nonatomic, strong) UILabel *secondPrice; // 二手价
@property (nonatomic, strong) UILabel *price;// 新车价价

@property (nonatomic, strong) YLCondition *bargain;

@end

@implementation YLDetailHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    
    self.banner = [[YLBannerCollectionView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 220)];
    [self addSubview:self.banner];
    
//    self.icon = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 220)];
//    self.icon.backgroundColor = YLColor(233.f, 233.f, 233.f);
    
    UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width - 10 - 15, CGRectGetMaxY(self.icon.frame) - 5 - 10, 15, 10)];
    
    self.text = [[UILabel alloc] initWithFrame:CGRectMake(YLLeftMargin, CGRectGetMaxY(self.banner.frame) + YLTopMargin, self.frame.size.width - 2 * YLLeftMargin, 44)];
    self.text.font = [UIFont systemFontOfSize:16];
    self.text.textColor = [UIColor blackColor];
//    self.text.backgroundColor = [UIColor redColor];
    self.text.numberOfLines = 0;
//    self.text.text = @"null";
    
    self.tagView = [[UIView alloc] initWithFrame:CGRectMake(YLLeftMargin, CGRectGetMaxY(self.text.frame) + 7, self.frame.size.width - 2 * YLLeftMargin, 22)];
    //    self.tagView.backgroundColor = [UIColor redColor];
    
    NSArray *tags = @[@"4S保养", @"0过户"];
    for (int i = 0; i < tags.count; i++) {
        NSString *string = tags[i];
        CGSize size = [string getSizeWithFont:[UIFont boldSystemFontOfSize:12]];
        float width = size.width;
        float height = self.tagView.frame.size.height;
        YLCondition *btn = [[YLCondition alloc] initWithFrame:CGRectMake(i * (width + YLTopMargin), 0, width, height)];
        btn.type = YLConditionTypeWhite;
        [btn setTitle:tags[i] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:12];
        [self.tagView addSubview:btn];
    }
    
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(YLLeftMargin, CGRectGetMaxY(self.tagView.frame) + 20, 50, 17)];
    label1.font = [UIFont systemFontOfSize:12];
    label1.text = @"车主报价";
    
    self.secondPrice = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(label1.frame) + 5, CGRectGetMaxY(self.tagView.frame) + 10, 120, 37)];
    self.secondPrice.font = [UIFont systemFontOfSize:26];
    [self.secondPrice setTextColor:[UIColor redColor]];
    self.secondPrice.text = @"0.0万";
    
    self.price = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.secondPrice.frame), CGRectGetMaxY(self.tagView.frame) + 20, 100, 17)];
    self.price.font = [UIFont systemFontOfSize:12];
    // 添加中划线
    NSString *str = @"新车含税价0.0万";
    NSDictionary *attri = @{NSStrikethroughStyleAttributeName:[NSNumber numberWithInteger:NSUnderlineStyleSingle]};
    NSMutableAttributedString *attriStr = [[NSMutableAttributedString alloc] initWithString:str attributes:attri];
    self.price.attributedText = attriStr;
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(CGRectGetMaxX(self.price.frame), CGRectGetMaxY(self.tagView.frame) + 22, 14, 14);
    [button setImage:[UIImage imageNamed:@"提醒"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(remind) forControlEvents:UIControlEventTouchUpInside];
//    [button setBackgroundColor:[UIColor grayColor]];
    
    self.bargain = [[YLCondition alloc] initWithFrame:CGRectMake(self.frame.size.width - YLLeftMargin - 56, CGRectGetMaxY(self.tagView.frame) + 20, 56, 24)];
    self.bargain.type = YLConditionTypeWhite;
    [self.bargain setTitle:@"砍价" forState:UIControlStateNormal];
    self.bargain.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.bargain addTarget:self action:@selector(bargainClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.bargain.frame) + YLLeftMargin, self.frame.size.width, 1)];
    line.backgroundColor = YLColor(233.f, 233.f, 233.f);
    [self addSubview:line];
    
//    [self addSubview:self.icon];
    [self addSubview:self.text];
    [self addSubview:self.tagView];
    [self addSubview:label1];
    [self addSubview:self.secondPrice];
    [self addSubview:self.price];
    [self addSubview:button];
    [self addSubview:self.bargain];
    [self addSubview:label3];
}

-  (void)bargainClick {
    
    NSLog(@"点击砍价");
    if (self.detailHeaderBargainBlock) {
        self.detailHeaderBargainBlock();
    }
}

- (void)remind {
    
    NSLog(@"提醒");
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"新车价价=厂商公布的j指导价+购置税费，改价格仅供参考" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil, nil];
    [alert show];
}

- (YLCondition *)setBtn:(NSString *)title {
    
    YLCondition *btn = [YLCondition buttonWithType:UIButtonTypeCustom];
    btn.type = YLConditionTypeBlue;
    [btn setTitle:title forState:UIControlStateNormal];
    [self.tagView addSubview:btn];
    return btn;
}

- (void)setModel:(YLDetailHeaderModel *)model {
    
    _model = model;
    
//    [self.icon sd_setImageWithURL:[NSURL URLWithString:model.displayImg] placeholderImage:nil];;
    self.text.text = model.title;
    self.price.text = [NSString stringWithFormat:@"新车价%@", [self stringToNumber:model.originalPrice]];
    self.secondPrice.text = [self stringToNumber:model.price];
}

- (void)setVehicle:(NSMutableArray *)vehicle {
    _vehicle = vehicle;
    self.banner.images = vehicle;
}

- (NSString *)stringToNumber:(NSString *)number {
    
    float count = [number floatValue] / 10000;
    return [NSString stringWithFormat:@"%.2f万",count];
}

@end
