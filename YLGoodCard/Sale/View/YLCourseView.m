//
//  YLCourseView.m
//  YLGoodCard
//
//  Created by lm on 2018/11/27.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import "YLCourseView.h"
#import "YLCondition.h"

@interface YLCourseView ()

@property (nonatomic, strong) UITextField *textField;

@end

@implementation YLCourseView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.layer.cornerRadius = 5.0f;
        self.layer.masksToBounds = YES;
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(YLLeftMargin, YLLeftMargin, self.frame.size.width-YLLeftMargin * 2, self.frame.size.height-70)];
    textField.placeholder = @"请输入里程(单位:万公里)";
    [textField setValue:[UIFont boldSystemFontOfSize:12] forKeyPath:@"_placeholderLabel.font"];
    textField.layer.borderWidth = 0.5;
    textField.layer.borderColor = [UIColor grayColor].CGColor;
    textField.clearsOnBeginEditing = YES;
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self addSubview:textField];
    self.textField = textField;
    
    
    CGFloat btnW = (YLScreenWidth - 2 * YLLeftMargin - 10) / 2;
    YLCondition *cancelBtn = [YLCondition buttonWithType:UIButtonTypeCustom];
    cancelBtn.frame = CGRectMake(YLLeftMargin, CGRectGetMaxY(textField.frame)+YLLeftMargin, btnW, 40);
    cancelBtn.type = YLConditionTypeWhite;
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(cancelClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:cancelBtn];
    
    YLCondition *sureBtn = [YLCondition buttonWithType:UIButtonTypeCustom];
    sureBtn.frame = CGRectMake(CGRectGetMaxX(cancelBtn.frame) + 10, CGRectGetMaxY(textField.frame)+YLLeftMargin, btnW, 40);
    sureBtn.type = YLConditionTypeBlue;
    [sureBtn setTitle:@"确定" forState:UIControlStateNormal];
    [sureBtn addTarget:self action:@selector(sureClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:sureBtn];
}

- (void)cancelClick {
    NSLog(@"点击取消，清空文本框");
    [self.textField resignFirstResponder];
    
    if (self.cancelBlock) {
        self.cancelBlock();
    }
    self.textField.text = @"";
}

- (void)sureClick {
    
    NSLog(@"点击确定");
    [self.textField resignFirstResponder];
    
    if (self.sureBlock) {
        self.sureBlock(self.textField.text);
    }
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
}

@end
