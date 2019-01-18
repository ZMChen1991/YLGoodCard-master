//
//  YLCollectionFooterButton.m
//  YLGoodCard
//
//  Created by lm on 2019/1/16.
//  Copyright © 2019 Chenzhiming. All rights reserved.
//

#import "YLCollectionFooterButton.h"

@implementation YLCollectionFooterButton

- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title image:(NSString *)image {
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.frame = CGRectMake(0, 2, 13, 13);
        imageView.image = [UIImage imageNamed:image];
        [self addSubview:imageView];
        
        UILabel *label = [[UILabel alloc] init];
        label.frame = CGRectMake(CGRectGetMaxX(imageView.frame) + 3, 0, 30, 18);
        label.text = title;
        label.font = [UIFont systemFontOfSize:12];
        label.textColor = YLColor(51.f, 51.f, 51.f);
        label.textAlignment = NSTextAlignmentLeft;
        [self addSubview:label];
        [self setUserInteractionEnabled:YES];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        [self addGestureRecognizer:tap];
    }
    return self;
}

- (void)tap:(UITapGestureRecognizer *)sender {
//    if (self.delegate && [self.delegate respondsToSelector:@selector(editorOrDelete)]) {
//        [self.delegate editorOrDelete];
//    }
    if (self.block) {
        self.block();
    }
    
}

@end
