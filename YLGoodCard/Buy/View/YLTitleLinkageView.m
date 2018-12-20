//
//  YLTitleLinkageView.m
//  Block
//
//  Created by lm on 2018/12/18.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import "YLTitleLinkageView.h"
#import "NSString+Extension.h"

@interface YLTitleLinkageView ()

@property (nonatomic, strong) UILabel *selectLabel;
@property (nonatomic, strong) UIButton *selectBtn;
@property (nonatomic, assign) BOOL isSelectView;
@property (nonatomic, assign) NSInteger index;

@property (nonatomic, strong) NSMutableArray *labels;
@property (nonatomic, strong) NSMutableArray *btns;

@end

@implementation YLTitleLinkageView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
        UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(0, self.frame.size.height - 1, YLScreenWidth, 1)];
        line.backgroundColor = YLColor(237.0, 237.0, 237.0);
        [self addSubview:line];
        [self addNotification];
    }
    return self;
}

- (void)addNotification {
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(recoverTitleView) name:@"RECOVERTITLEVIEW" object:nil];
}

- (void)recoverTitleView {
    
    NSLog(@"接受到消息,还原字体和图片");
    self.selectLabel.textColor = [UIColor blackColor];
    [self.selectBtn setImage:[UIImage imageNamed:@"下拉"] forState:UIControlStateNormal];
}

- (void)setupUI {
    
    NSArray *titles = @[@"智能排序", @"品牌", @"价格", @"筛选"];
    NSArray *images = @[@"下拉", @"下拉", @"下拉", @"筛选"];
    [self viewWithTitles:titles images:images];
}

- (void)viewWithTitles:(NSArray<NSString *> *)titles images:(NSArray *)images{
    CGFloat width = YLScreenWidth / titles.count;
    CGFloat height = self.frame.size.height;
    for (NSInteger i = 0; i < titles.count; i++) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(width * i, 0, width, height)];
        view.tag = 100 + i;
        [view setUserInteractionEnabled:YES];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        [view addGestureRecognizer:tap];
        [self addSubview:view];
        
        UILabel *label = [[UILabel alloc] init];
        CGFloat labelW = [titles[i] getSizeWithFont:[UIFont systemFontOfSize:14]].width + 5;
        CGFloat labelH = height;
        CGFloat labelX = (width - labelW - 10) / 2;
        CGFloat labelY = 0;
        label.frame = CGRectMake(labelX, labelY, labelW, labelH);
        label.text = titles[i];
        label.font = [UIFont systemFontOfSize:14];
        [view addSubview:label];
        [self.labels addObject:label];
        
        CGFloat btnX = CGRectGetMaxX(label.frame);
        CGFloat btnY = 21;
        CGFloat btnW = 9;
        CGFloat btnH = 9;
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
        [btn setImage:[UIImage imageNamed:images[i]] forState:UIControlStateNormal];
        [view addSubview:btn];
        [self.btns addObject:btn];
    }
}

- (void)tap:(UITapGestureRecognizer *)sender {
    
    NSInteger index = sender.view.tag - 100;
    self.index = index;
    if (self.linkageBlock) {
        self.linkageBlock(index);
    }
    
//    NSLog(@"点击了第%ld个按钮", index);
    /**思路:
     1.点击按钮，修改字体颜色和旋转图片
     2.如果点击是同一个按钮，还原
     3.如果点击的是另一个按钮，还原原来的按钮，修改选中的按钮
     */
//    self.isSelectView = !self.isSelectView;
//    if (index == 0 || index == 2) { // 智能排序、价格
//        if (self.selectLabel == self.labels[index]) {// 如果是同一个按钮
//            if (self.isSelectView) {
//                NSLog(@"上拉");
//                self.selectLabel.textColor = YLColor(8.f, 169.f, 255.f);
//                [self.selectBtn setImage:[UIImage imageNamed:@"上拉"] forState:UIControlStateNormal];
//                //                CGAffineTransform transform = CGAffineTransformMakeRotation(M_PI);
//                //                self.selectBtn.transform = transform;
//            } else {
//                // 之前选中的按钮还原
//                NSLog(@"还原");
//                self.selectLabel.textColor = [UIColor blackColor];
//                [self.selectBtn setImage:[UIImage imageNamed:@"下拉"] forState:UIControlStateNormal];
//                //            self.selectBtn.transform = CGAffineTransformIdentity;
//            }
//        } else {
//            // 之前选中的按钮还原
//            self.selectLabel.textColor = [UIColor blackColor];
//            [self.selectBtn setImage:[UIImage imageNamed:@"下拉"] forState:UIControlStateNormal];
//            //        self.selectBtn.transform = CGAffineTransformIdentity;
//
//            self.selectLabel = self.labels[index];
//            self.selectBtn = self.btns[index];
//            // 重新修改按钮
//            self.selectLabel.textColor = YLColor(8.f, 169.f, 255.f);
//            [self.selectBtn setImage:[UIImage imageNamed:@"上拉"] forState:UIControlStateNormal];
//            //        CGAffineTransform transform = CGAffineTransformMakeRotation(M_PI);
//            //        self.selectBtn.transform = transform;
//        }
//    }
//    else {
//        self.selectLabel.textColor = [UIColor blackColor];
//        [self.selectBtn setImage:[UIImage imageNamed:@"下拉"] forState:UIControlStateNormal];
//    }
}

- (void)setIsSelect:(BOOL)isSelect {
    _isSelect = isSelect;
    if (isSelect) {
        if (self.index == 0 || self.index == 2) {
            self.selectLabel.textColor = [UIColor blackColor];
            [self.selectBtn setImage:[UIImage imageNamed:@"下拉"] forState:UIControlStateNormal];
            self.selectLabel = self.labels[self.index];
            self.selectBtn = self.btns[self.index];
            self.selectLabel.textColor = YLColor(8.f, 169.f, 255.f);
            [self.selectBtn setImage:[UIImage imageNamed:@"上拉"] forState:UIControlStateNormal];
        }
    } else {
        self.selectLabel.textColor = [UIColor blackColor];
        [self.selectBtn setImage:[UIImage imageNamed:@"下拉"] forState:UIControlStateNormal];
    }
}

- (NSMutableArray *)labels {
    if (!_labels) {
        _labels = [NSMutableArray array];
    }
    return _labels;
}

- (NSMutableArray *)btns {
    if (!_btns) {
        _btns = [NSMutableArray array];
    }
    return _btns;
}
@end
