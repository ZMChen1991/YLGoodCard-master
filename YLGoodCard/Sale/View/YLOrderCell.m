//
//  YLOrderCell.m
//  YLGoodCard
//
//  Created by lm on 2018/11/3.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import "YLOrderCell.h"

@interface YLOrderCell ()

@property (nonatomic, strong) UILabel *label;

@end

@implementation YLOrderCell



- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
    }
    return self;
}

- (void)setupOriginal {
    
    UILabel *label = [[UILabel alloc] init];
    [self addSubview:label];
    self.label = label;
    
    UITextField *textField = [[UITextField alloc] init];
    [self addSubview:textField];
    self.textField = textField;
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    float labelX = YLMargin;
    float labelY = YLMargin;
    float labelW = 150;
    float labelH = 30;
    self.label.frame = CGRectMake(labelX, labelY, labelW, labelH);
}


@end
