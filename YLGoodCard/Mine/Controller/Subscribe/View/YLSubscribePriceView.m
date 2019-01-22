//
//  YLSubscribePriceView.m
//  YLGoodCard
//
//  Created by lm on 2019/1/19.
//  Copyright © 2019 Chenzhiming. All rights reserved.
//

#import "YLSubscribePriceView.h"

@interface YLSubscribePriceView () <UITextFieldDelegate>

@property (nonatomic, strong) UITextField *lowPrice;
@property (nonatomic, strong) UITextField *highPrice;

@end

@implementation YLSubscribePriceView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    
    UILabel *headerTitle = [[UILabel alloc] initWithFrame:CGRectMake(YLLeftMargin, 0, self.bounds.size.width, 30)];
    headerTitle.text = @"价格";
    headerTitle.font = [UIFont systemFontOfSize:14];
    headerTitle.textColor = YLColor(51.f, 51.f, 51.f);
    [self addSubview:headerTitle];
    
    
    CGFloat textFieldW = 60;
    CGFloat textFieldH = 36;
    UITextField *highPrice = [[UITextField alloc] initWithFrame:CGRectMake(YLScreenWidth - YLLeftMargin - textFieldW, CGRectGetMaxY(headerTitle.frame) + 5, textFieldW, textFieldH)];
    highPrice.placeholder = @"最高价";
    highPrice.textAlignment = NSTextAlignmentCenter;
    highPrice.layer.borderWidth = 1.f;
    highPrice.layer.borderColor = YLColor(233.f, 233.f, 233.f).CGColor;
    highPrice.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    highPrice.font = [UIFont systemFontOfSize:12];
    highPrice.returnKeyType = UIReturnKeyDone;
    highPrice.delegate = self;
    [self addSubview:highPrice];
    self.highPrice = highPrice;
    
    CGFloat lineY = textFieldH / 2 + 5 + 30;
    CGFloat lineW = 5;
    CGFloat lineX = YLScreenWidth - YLLeftMargin - textFieldW - lineW - YLLeftMargin;
    UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(lineX, lineY, 5, 1)];
//    line.backgroundColor = YLColor(233.f, 233.f, 233.f);
    line.backgroundColor = [UIColor redColor];
    [self addSubview:line];
    
    CGFloat lowPriceX = CGRectGetMinX(line.frame) - YLLeftMargin - textFieldW;
    UITextField *lowPrice = [[UITextField alloc] initWithFrame:CGRectMake(lowPriceX, CGRectGetMaxY(headerTitle.frame) + 5, textFieldW, textFieldH)];
    lowPrice.placeholder = @"最低价";
    lowPrice.textAlignment = NSTextAlignmentCenter;
    lowPrice.layer.borderWidth = 1.f;
    lowPrice.layer.borderColor = YLColor(233.f, 233.f, 233.f).CGColor;
    lowPrice.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    lowPrice.font = [UIFont systemFontOfSize:12];
    lowPrice.returnKeyType = UIReturnKeyDone;
    lowPrice.delegate = self;
    [self addSubview:lowPrice];
    self.lowPrice = lowPrice;
    
    CGFloat labelW = YLScreenWidth - CGRectGetMinX(lowPrice.frame) - YLLeftMargin;
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(YLLeftMargin, CGRectGetMaxY(headerTitle.frame) + 5, labelW, textFieldH)];
    title.text = @"价格(单位:万)";
    title.textAlignment = NSTextAlignmentLeft;
    title.textColor = YLColor(51.f, 51.f, 51.f);
    title.font = [UIFont systemFontOfSize:14];
    [self addSubview:title];
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
}

//- (void)textFieldDidEndEditing:(UITextField *)textField {
////    if (![self.lowPrice.text isEqualToString:@""] && ![self.highPrice.text isEqualToString:@""]) {
////        if (self.priceBlock) {
////            self.priceBlock([self.lowPrice.text integerValue], [self.highPrice.text integerValue]);
////        }
////    }
//
//    NSLog(@"%@--%@",self.lowPrice.text, self.highPrice.text);
//    if (self.priceBlock) {
//        self.priceBlock([self.lowPrice.text integerValue], [self.highPrice.text integerValue]);
//    }
//    [self.lowPrice resignFirstResponder];
//    [self.highPrice resignFirstResponder];
//}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    NSLog(@"%@--%@",self.lowPrice.text, self.highPrice.text);
    if (self.priceBlock) {
        self.priceBlock([self.lowPrice.text integerValue], [self.highPrice.text integerValue]);
    }
    [self.lowPrice resignFirstResponder];
    [self.highPrice resignFirstResponder];
    
    return YES;
}


- (void)setLowPriceStr:(NSString *)lowPriceStr {
    _lowPriceStr = lowPriceStr;
    self.lowPrice.text = lowPriceStr;
}

- (void)setHighPriceStr:(NSString *)highPriceStr {
    _highPriceStr = highPriceStr;
    self.highPrice.text = highPriceStr;
}
@end
