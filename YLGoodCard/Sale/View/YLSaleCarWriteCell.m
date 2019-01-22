//
//  YLSaleCarWriteCell.m
//  YLFunction
//
//  Created by lm on 2019/1/21.
//  Copyright © 2019 Chenzhiming. All rights reserved.
//

#import "YLSaleCarWriteCell.h"
#import "NSString+Extension.h"

@interface YLSaleCarWriteCell () <UITextFieldDelegate>

@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UITextField *detailLabel;

@end

@implementation YLSaleCarWriteCell

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *const cellID = @"YLSaleCarWriteCell";
    YLSaleCarWriteCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[YLSaleCarWriteCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
    return cell;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UILabel *titleLabel = [[UILabel alloc] init];
//        titleLabel.backgroundColor = [UIColor redColor];
        titleLabel.font = [UIFont systemFontOfSize:14];
        titleLabel.textColor = YLColor(51.f, 51.f, 51.f);
        [self addSubview:titleLabel];
        self.label = titleLabel;
        
        UITextField *detailLabel = [[UITextField alloc] init];
//        detailLabel.backgroundColor = [UIColor yellowColor];
        detailLabel.font = [UIFont systemFontOfSize:14];
        detailLabel.textColor = YLColor(51.f, 51.f, 51.f);
        detailLabel.textAlignment = NSTextAlignmentRight;
        detailLabel.keyboardType = UIKeyboardTypeDefault;
        detailLabel.returnKeyType = UIReturnKeyDone;
        [detailLabel addTarget:self action:@selector(textFieldChanged:) forControlEvents:UIControlEventEditingChanged];
        detailLabel.delegate = self;
        [self addSubview:detailLabel];
        self.detailLabel = detailLabel;
    }
    return self;
}

- (void)textFieldChanged:(UITextField *)textField {
    NSLog(@"textField:%@", textField.text);
    CGFloat detailW = 0;
    CGSize titleSize = [textField.text getSizeWithFont:[UIFont systemFontOfSize:14]];
    if (titleSize.width < 45) {
        detailW = 45;
    } else if (titleSize.width > 70) {
        detailW = 70;
    } else {
        detailW = 70;
    }
    NSLog(@"%.f", detailW);
    self.detailLabel.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 15 - detailW, 0, detailW, self.frame.size.height);
    if (self.writeBlock) {
        self.writeBlock(textField.text);
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.detailLabel resignFirstResponder];
    return YES;
}

- (void)setTitle:(NSString *)title {
    _title = title;
    
    CGSize titleSize = [title getSizeWithFont:[UIFont systemFontOfSize:14]];
    self.label.frame = CGRectMake(15, 0, titleSize.width, self.frame.size.height);
    self.label.text = title;
}

- (void)setDetailTitle:(NSString *)detailTitle {
    _detailTitle = detailTitle;
    
    CGSize titleSize = [detailTitle getSizeWithFont:[UIFont systemFontOfSize:14]];
    self.detailLabel.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 15 - titleSize.width, 0, titleSize.width, self.frame.size.height);
    if ([detailTitle isEqualToString:@"请输入"]) {
        self.detailLabel.placeholder = detailTitle;
    } else {
        self.detailLabel.text = detailTitle;
    }
    
}

@end
