//
//  YLSafeguardCell.m
//  YLGoodCard
//
//  Created by lm on 2018/11/6.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import "YLSafeguardCell.h"
#import "YLCustomButton.h"


@interface YLSafeguardCell ()

@property (nonatomic, strong) UIButton *btn;// 服务保障
@property (nonatomic, strong) UILabel *provideView;
@property (nonatomic, strong) NSArray *array;

@end

@implementation YLSafeguardCell

+ (instancetype)cellWithTable:(UITableView *)tableView {
    
    static NSString *ID = @"YLSafeguardCell";
    YLSafeguardCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[YLSafeguardCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
//        self.backgroundColor = [UIColor greenColor];
        
        self.array = @[@"1年2万公里保障", @"购车后7天内发现质量问题，可全额退款", @"更专业、更全面的检测服务，质量更有保障", @"买卖双方均只收取2%d服务费，再无其他费用"];
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    
    NSArray *array = @[@"售后保障", @"30天可退", @"调表车赔付", @"服务费低"];
    NSArray *images = @[@"售后保障", @"30天可退", @"专业检测", @"服务费低"];
    float width = (self.frame.size.width - 2 * YLLeftMargin) / array.count;
    float height = 80;
    for (int i = 0; i < array.count; i++) {
        YLCustomButton *btn = [[YLCustomButton alloc] initWithFrame:CGRectMake(i * width + YLLeftMargin, 0, width, height)];
        [btn setTitle:array[i] forState:UIControlStateNormal];
//        [btn.titleLabel setFont:[UIFont systemFontOfSize:16]];
        // 图片显大，需修改
        [btn setImage:[UIImage imageNamed:images[i]] forState:UIControlStateNormal];
        btn.tag = 100 + i;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
//        [btn setBackgroundColor:YLRandomColor];
        [self addSubview:btn];
    }
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(YLLeftMargin, height, self.frame.size.width - 2 * YLLeftMargin, height)];
    label.text = self.array[0];
    label.textColor = [UIColor redColor];
    label.font = [UIFont systemFontOfSize:14];
    label.textAlignment = NSTextAlignmentCenter;
    label.backgroundColor = YLColor(233.f, 233.f, 233.f);
    [self addSubview:label];
    self.provideView = label;
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(label.frame) + YLLeftMargin, self.frame.size.width, 1)];
    line.backgroundColor = YLColor(233.f, 233.f, 233.f);
    [self addSubview:line];
}

- (void)btnClick:(YLCustomButton *)sender {
    NSLog(@"click");
    
    NSInteger tag = sender.tag - 100;
    self.provideView.text = self.array[tag];
}

- (float)height {
    return 160;
}

// cell获取的宽不对，这里重设宽
- (void)setFrame:(CGRect)frame {
    frame.size.width = YLScreenWidth;
    [super setFrame:frame];
}

@end
