//
//  YLReportCell.m
//  YLGoodCard
//
//  Created by lm on 2018/11/6.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import "YLReportCell.h"
#import "YLCondition.h"

@interface YLReportCell ()

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, strong) NSArray *subTitles;

@end

@implementation YLReportCell

+ (instancetype)cellWithTable:(UITableView *)tableView {
    
    static NSString *ID = @"YLReportCell";
    YLReportCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[YLReportCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
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
    
    UIImageView *icon = [[UIImageView alloc] initWithFrame:CGRectMake(YLLeftMargin, 5, 40, 40)];
//    icon.backgroundColor = [UIColor redColor];
    icon.image = [UIImage imageNamed:@"评估师"];
    [self addSubview:icon];
    
    UILabel *text = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(icon.frame) + 5, 5, 100, 40)];
    text.text = @"高级车辆评估师";
    text.font = [UIFont systemFontOfSize:14];
    [self addSubview:text];
    
    YLCondition *consult = [[YLCondition alloc] initWithFrame:CGRectMake(self.frame.size.width - 80 - YLLeftMargin, YLLeftMargin, 80, 25)];
    consult.type = YLConditionTypeBlue;
    [consult setTitle:@"咨询车况" forState:UIControlStateNormal];
    [consult addTarget:self action:@selector(conssultClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:consult];
    
    UIView *bg = [[UIView alloc] initWithFrame:CGRectMake(YLLeftMargin,CGRectGetMaxY(icon.frame) + YLTopMargin, 345, 206)];
    bg.backgroundColor = YLColor(244.f, 244.f, 244.f);
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(YLLeftMargin, YLLeftMargin, 308, 180)];
//    view.backgroundColor = [UIColor redColor];
    
#warning 这里是一个textView控件，以后修改到在改
    NSArray *array = @[@"内饰:", @"外观:", @"底盘:", @"车身骨架:", @"电子设备:", @"操作机构:", @"发动机舱:", @"其他:"];
    NSArray *array1 = @[@"干净整洁", @"全车原漆" ,@"正常", @"正常" ,@"正常", @"正常" ,@"正常", @"排放量以当地车管所为准，具体车况以现场看车为准"];
    for (int i = 0; i < array.count; i++) {
        NSString *str = array[i];
        CGSize size = [str getSizeWithFont:[UIFont systemFontOfSize:12]];
        float width = size.width;
        float height = 180 / 8;
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, i * height, width, height)];
        label.text = array[i];
        label.textColor = YLColor(155.f, 155.f, 155.f);
        label.font = [UIFont systemFontOfSize:12];
        
        UILabel *detail = [[UILabel alloc] initWithFrame:CGRectMake(width, i * height, 308 - width, height)];
        detail.text = array1[i];
        detail.textColor = YLColor(155.f, 155.f, 155.f);
        detail.font = [UIFont systemFontOfSize:12];
        detail.numberOfLines = 0;
        
        [view addSubview:label];
        [view addSubview:detail];
    }
    [bg addSubview:view];
//    NSLog(@"%@", view);
    [self addSubview:bg];
    
    UILabel *text1 = [[UILabel alloc] initWithFrame:CGRectMake(YLLeftMargin, CGRectGetMaxY(bg.frame) + 5, 345, 17)];
    text1.text = @"以上为2018.06.12车况，交易以复检结果为准";
    text1.font = [UIFont systemFontOfSize:12];
    [self addSubview:text1];
    
    UIImageView *pic = [[UIImageView alloc] initWithFrame:CGRectMake(YLLeftMargin, CGRectGetMaxY(text1.frame) + YLLeftMargin, self.frame.size.width - 2 * YLLeftMargin, 159)];
    pic.backgroundColor = [UIColor redColor];
    pic.image = [UIImage imageNamed:@"检测"];
    [self addSubview:pic];
    
    
//    self.titles = @[@"事故排查",@"轻微碰撞",@"易损耗部件",@"常用功能",@"启动检测",@"外观内饰"];
//    self.subTitles = @[@"73项", @"23项", @"12项", @"8项", @"14项", @"2项", @"9项"];
//    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(YLLeftMargin, CGRectGetMaxY(pic.frame), self.frame.size.width - 2 * YLLeftMargin, 264)];
//    tableView.separatorStyle = UITableViewCellSeparatorStyleNone; // 取消cell的分割线
//    tableView.delegate = self;
//    tableView.dataSource = self;
//    [self addSubview:tableView];
    
//    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(pic.frame), self.frame.size.width, 1)];
//    line.backgroundColor = YLColor(233.f, 233.f, 233.f);
//    [self addSubview:line];
}

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//    return 1;
//}
//
//-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//
//    return self.titles.count;
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//
//    NSString *ID = @"YLReportCell";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
//    if (!cell) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
//    }
//    cell.textLabel.text = self.titles[indexPath.row];
//    cell.detailTextLabel.text = self.subTitles[indexPath.row];
//
//    cell.textLabel.font = [UIFont systemFontOfSize:14];
//    cell.detailTextLabel.font = [UIFont systemFontOfSize:14];
//    return cell;
//}

- (void)conssultClick {
    
    NSLog(@"reportCell:咨询车况");
}

- (float)height {
    return 473 + 264;
}

// cell获取的宽不对，这里重设宽
- (void)setFrame:(CGRect)frame {
    frame.size.width = YLScreenWidth;
    [super setFrame:frame];
}
@end
