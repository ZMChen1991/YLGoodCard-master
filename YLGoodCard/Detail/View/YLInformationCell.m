//
//  YLInformationCell.m
//  YLGoodCard
//
//  Created by lm on 2018/11/6.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import "YLInformationCell.h"

@interface YLInformationCell ()

@property (nonatomic, strong) UIView *labelView;
@property (nonatomic, strong) NSMutableArray *labels;

@property (nonatomic, strong) UILabel *courseL;
@property (nonatomic, strong) UILabel *licenseTimeL;
@property (nonatomic, strong) UILabel *locationL;
@property (nonatomic, strong) UILabel *meetingPlaceL;
@property (nonatomic, strong) UILabel *emissionL;
@property (nonatomic, strong) UILabel *emissionStandardL;
@property (nonatomic, strong) UILabel *gearboxL;
@property (nonatomic, strong) UILabel *transferL;
@property (nonatomic, strong) UILabel *trafficInsuranceL;
@property (nonatomic, strong) UILabel *commercialInsuranceL;
@property (nonatomic, strong) UILabel *annualInspectionL;

@end

@implementation YLInformationCell

+ (instancetype)cellWithTable:(UITableView *)tableView {
    
    static NSString *ID = @"YLInformationCell";
    YLInformationCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[YLInformationCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
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
    
    NSArray *array = @[@"表显里程", @"上牌时间", @"车牌所在地", @"看车地点", @"排放量", @"环保标准", @"变速箱", @"登记证为准", @"年检到期", @"商业险到期", @"交强险到期"];
    
    CGFloat width = (YLScreenWidth - 2 * YLLeftMargin) / 2;
    CGFloat height = 30;
    CGFloat labelW = width / 2 - 5;
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(YLLeftMargin, 10, width, height)];
    view.layer.borderWidth = 0.5;
    view.layer.borderColor = YLColor(233.f, 233.f, 233.f).CGColor;
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, labelW, height)];
    label.text = @"表显里程";
    label.font = [UIFont systemFontOfSize:12];
    label.textColor = YLColor(155.f, 155.f, 155.f);
    label.textAlignment = NSTextAlignmentLeft;
    [view addSubview:label];
    
    UILabel *courseL = [[UILabel alloc] initWithFrame:CGRectMake(labelW, 0, labelW, height)];
    courseL.font = [UIFont systemFontOfSize:12];
    courseL.textColor = YLColor(51.f, 51.f, 51.f);
    courseL.textAlignment = NSTextAlignmentRight;
    [view addSubview:courseL];
    self.courseL = courseL;
    [self addSubview:view];
    
    UIView *view6 = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(view.frame), 10, width, height)];
    view6.layer.borderWidth = 0.5;
    view6.layer.borderColor = YLColor(233.f, 233.f, 233.f).CGColor;
    
    UILabel *label6 = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, labelW, height)];
    label6.text = @"上牌时间";
    label6.font = [UIFont systemFontOfSize:12];
    label6.textColor = YLColor(155.f, 155.f, 155.f);
    label6.textAlignment = NSTextAlignmentLeft;
    [view6 addSubview:label6];
    
    UILabel *licenseTime = [[UILabel alloc] initWithFrame:CGRectMake(labelW, 0, labelW, height)];
    licenseTime.font = [UIFont systemFontOfSize:12];
    licenseTime.textColor = YLColor(51.f, 51.f, 51.f);
    licenseTime.textAlignment = NSTextAlignmentRight;
    [view6 addSubview:licenseTime];
    self.licenseTimeL = licenseTime;
    [self addSubview:view6];

    UIView *view7 = [[UIView alloc] initWithFrame:CGRectMake(YLLeftMargin, CGRectGetMaxY(view.frame), width, height)];
    view7.layer.borderWidth = 0.5;
    view7.layer.borderColor = YLColor(233.f, 233.f, 233.f).CGColor;
    
    UILabel *label7 = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, labelW, height)];
    label7.text = @"车牌所在地";
    label7.font = [UIFont systemFontOfSize:12];
    label7.textColor = YLColor(155.f, 155.f, 155.f);
    label7.textAlignment = NSTextAlignmentLeft;
    [view7 addSubview:label7];
    
    UILabel *location = [[UILabel alloc] initWithFrame:CGRectMake(labelW, 0, labelW, height)];
    location.font = [UIFont systemFontOfSize:12];
    location.textColor = YLColor(51.f, 51.f, 51.f);
    location.textAlignment = NSTextAlignmentRight;
    [view7 addSubview:location];
    self.locationL = location;
    [self addSubview:view7];
    
    UIView *view8 = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(view7.frame), CGRectGetMaxY(view.frame), width, height)];
    view8.layer.borderWidth = 0.5;
    view8.layer.borderColor = YLColor(233.f, 233.f, 233.f).CGColor;
    
    UILabel *label8 = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, labelW, height)];
    label8.text = @"看车地点";
    label8.font = [UIFont systemFontOfSize:12];
    label8.textColor = YLColor(155.f, 155.f, 155.f);
    label8.textAlignment = NSTextAlignmentLeft;
    [view8 addSubview:label8];
    
    UILabel *meetingPlace = [[UILabel alloc] initWithFrame:CGRectMake(labelW, 0, labelW, height)];
    meetingPlace.font = [UIFont systemFontOfSize:12];
    meetingPlace.textColor = YLColor(51.f, 51.f, 51.f);
    meetingPlace.textAlignment = NSTextAlignmentRight;
    [view8 addSubview:meetingPlace];
    self.meetingPlaceL = meetingPlace;
    [self addSubview:view8];
    
    UIView *view9 = [[UIView alloc] initWithFrame:CGRectMake(YLLeftMargin, CGRectGetMaxY(view8.frame), width, height)];
    view9.layer.borderWidth = 0.5;
    view9.layer.borderColor = YLColor(233.f, 233.f, 233.f).CGColor;
    
    UILabel *label9 = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, labelW, height)];
    label9.text = @"排放量";
    label9.font = [UIFont systemFontOfSize:12];
    label9.textColor = YLColor(155.f, 155.f, 155.f);
    label9.textAlignment = NSTextAlignmentLeft;
    [view9 addSubview:label9];
    
    UILabel *emission = [[UILabel alloc] initWithFrame:CGRectMake(labelW, 0, labelW, height)];
    emission.font = [UIFont systemFontOfSize:12];
    emission.textColor = YLColor(51.f, 51.f, 51.f);
    emission.textAlignment = NSTextAlignmentRight;
    [view9 addSubview:emission];
    self.emissionL = emission;
    [self addSubview:view9];
    
    UIView *view10 = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(view9.frame), CGRectGetMaxY(view8.frame), width, height)];
    view10.layer.borderWidth = 0.5;
    view10.layer.borderColor = YLColor(233.f, 233.f, 233.f).CGColor;
    
    UILabel *label10 = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, labelW, height)];
    label10.text = @"环保标准";
    label10.font = [UIFont systemFontOfSize:12];
    label10.textColor = YLColor(155.f, 155.f, 155.f);
    label10.textAlignment = NSTextAlignmentLeft;
    [view10 addSubview:label10];
    
    UILabel *emissionStandard = [[UILabel alloc] initWithFrame:CGRectMake(labelW, 0, labelW, height)];
    emissionStandard.font = [UIFont systemFontOfSize:12];
    emissionStandard.textColor = YLColor(51.f, 51.f, 51.f);
    emissionStandard.textAlignment = NSTextAlignmentRight;
    [view10 addSubview:emissionStandard];
    self.emissionStandardL = emissionStandard;
    [self addSubview:view10];
    
    UIView *view5 = [[UIView alloc] initWithFrame:CGRectMake(YLLeftMargin, CGRectGetMaxY(view10.frame), width, height)];
    view5.layer.borderWidth = 0.5;
    view5.layer.borderColor = YLColor(233.f, 233.f, 233.f).CGColor;
    
    UILabel *label5 = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, labelW, height)];
    label5.text = @"变速箱";
    label5.font = [UIFont systemFontOfSize:12];
    label5.textColor = YLColor(155.f, 155.f, 155.f);
    label5.textAlignment = NSTextAlignmentLeft;
    [view5 addSubview:label5];
    
    UILabel *gearbox = [[UILabel alloc] initWithFrame:CGRectMake(labelW, 0, labelW, height)];
    gearbox.font = [UIFont systemFontOfSize:12];
    gearbox.textColor = YLColor(51.f, 51.f, 51.f);
    gearbox.textAlignment = NSTextAlignmentRight;
    [view5 addSubview:gearbox];
    self.gearboxL = gearbox;
    [self addSubview:view5];
    
    UIView *view4 = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(view5.frame), CGRectGetMaxY(view10.frame), width, height)];
    view4.layer.borderWidth = 0.5;
    view4.layer.borderColor = YLColor(233.f, 233.f, 233.f).CGColor;
    
    UILabel *label4 = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, labelW, height)];
    label4.text = @"登记证为准";
    label4.font = [UIFont systemFontOfSize:12];
    label4.textColor = YLColor(155.f, 155.f, 155.f);
    label4.textAlignment = NSTextAlignmentLeft;
    [view4 addSubview:label4];
    
    UILabel *transfer = [[UILabel alloc] initWithFrame:CGRectMake(labelW, 0, labelW, height)];
    transfer.font = [UIFont systemFontOfSize:12];
    transfer.textColor = YLColor(51.f, 51.f, 51.f);
    transfer.textAlignment = NSTextAlignmentRight;
    [view4 addSubview:transfer];
    self.transferL = transfer;
    [self addSubview:view4];
    
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(YLLeftMargin, CGRectGetMaxY(view4.frame), width, height)];
    view1.layer.borderWidth = 0.5;
    view1.layer.borderColor = YLColor(233.f, 233.f, 233.f).CGColor;
    
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, labelW, height)];
    label1.text = @"交强险到期";
    label1.font = [UIFont systemFontOfSize:12];
    label1.textColor = YLColor(155.f, 155.f, 155.f);
    label1.textAlignment = NSTextAlignmentLeft;
    [view1 addSubview:label1];
    
    UILabel *trafficInsurance = [[UILabel alloc] initWithFrame:CGRectMake(labelW, 0, labelW, height)];
    trafficInsurance.font = [UIFont systemFontOfSize:12];
    trafficInsurance.textColor = YLColor(51.f, 51.f, 51.f);
    trafficInsurance.textAlignment = NSTextAlignmentRight;
    [view1 addSubview:trafficInsurance];
    self.trafficInsuranceL = trafficInsurance;
    [self addSubview:view1];
    
    UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(view1.frame), CGRectGetMaxY(view4.frame), width, height)];
    view2.layer.borderWidth = 0.5;
    view2.layer.borderColor = YLColor(233.f, 233.f, 233.f).CGColor;
    
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, labelW, height)];
    label2.text = @"商业险到期";
    label2.font = [UIFont systemFontOfSize:12];
    label2.textColor = YLColor(155.f, 155.f, 155.f);
    label2.textAlignment = NSTextAlignmentLeft;
    [view2 addSubview:label2];
    
    UILabel *commercialInsurance = [[UILabel alloc] initWithFrame:CGRectMake(labelW, 0, labelW, height)];
    commercialInsurance.font = [UIFont systemFontOfSize:12];
    commercialInsurance.textColor = YLColor(51.f, 51.f, 51.f);
    commercialInsurance.textAlignment = NSTextAlignmentRight;
    [view2 addSubview:commercialInsurance];
    self.commercialInsuranceL = commercialInsurance;
    [self addSubview:view2];
    
    UIView *view3 = [[UIView alloc] initWithFrame:CGRectMake(YLLeftMargin, CGRectGetMaxY(view2.frame), width, height)];
    view3.layer.borderWidth = 0.5;
    view3.layer.borderColor = YLColor(233.f, 233.f, 233.f).CGColor;
    
    UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, labelW, height)];
    label3.text = @"年检到期";
    label3.font = [UIFont systemFontOfSize:12];
    label3.textColor = YLColor(155.f, 155.f, 155.f);
    label3.textAlignment = NSTextAlignmentLeft;
    [view3 addSubview:label3];
    
    UILabel *annualInspection = [[UILabel alloc] initWithFrame:CGRectMake(labelW, 0, labelW, height)];
    annualInspection.font = [UIFont systemFontOfSize:12];
    annualInspection.textColor = YLColor(51.f, 51.f, 51.f);
    annualInspection.textAlignment = NSTextAlignmentRight;
    [view3 addSubview:annualInspection];
    self.annualInspectionL = annualInspection;
    [self addSubview:view3];
}

//- (UIView *)labelView {
//    if (!_labelView) {
//        CGRect frame = CGRectMake(YLLeftMargin, YLLeftMargin, self.frame.size.width - 2 * YLLeftMargin, 180);
//        _labelView = [[UIView alloc] initWithFrame:frame];
//    }
//    return _labelView;
//}

//- (UIView *)setupTitle:(NSString *)title subtitle:(NSString *)subtitle frame:(CGRect)frame {
//
//    UIView *view = [[UIView alloc] initWithFrame:frame];
//    view.layer.borderWidth = 0.5;
//    view.layer.borderColor = YLColor(233.f, 233.f, 233.f).CGColor;
//    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, 65, view.frame.size.height)];
//    label1.font = [UIFont systemFontOfSize:12];
//    label1.textColor = YLColor(155.f, 155.f, 155.f);
//    label1.text = title;
//    label1.textAlignment = NSTextAlignmentLeft;
//    [view addSubview:label1];
//
//    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(65, 0, view.frame.size.width - 65 - 10, view.frame.size.height)];
//    label2.font = [UIFont systemFontOfSize:12];
//    label2.textColor = YLColor(51.f, 51.f, 51.f);
//    label2.text = subtitle;
//    label2.textAlignment = NSTextAlignmentRight;
//    [view addSubview:label2];
//    [self.labels addObject:label2];
//    return view;
//}

//- (float)height {
//    return 180;
//}

// cell获取的宽不对，这里重设宽
- (void)setFrame:(CGRect)frame {
    frame.size.width = YLScreenWidth;
    [super setFrame:frame];
}

- (NSMutableArray *)labels {
    if (!_labels) {
        _labels = [NSMutableArray array];
    }
    return _labels;
}

- (void)setModel:(YLDetailInfoModel *)model {
    
    _model = model;
    self.courseL.text = model.course;
    self.licenseTimeL.text = model.licenseTime;
    self.locationL.text = model.location;
    self.meetingPlaceL.text = model.meetingPlace;
    self.emissionL.text = model.emission;
    self.emissionStandardL.text = model.emissionStandard;
    self.gearboxL.text = model.gearbox;
    self.transferL.text = model.transfer;
    self.trafficInsuranceL.text = model.trafficInsurance;
    self.commercialInsuranceL.text = model.commercialInsurance;
    self.annualInspectionL.text = model.annualInspection;
    

}

@end
