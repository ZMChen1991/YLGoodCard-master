//
//  YLSearchBar.m
//  YLGoodCard
//
//  Created by lm on 2018/11/3.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import "YLSearchBar.h"

@implementation YLSearchBar

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        // 设置背景
//        self.background = [UIImage resizedImage:@"searchbar_textfield_background"];
//        self.backgroundColor = [UIColor redColor];
        
        // 设置圆角
        self.layer.cornerRadius = 5;
        self.clipsToBounds = YES;
        self.layer.borderWidth = 0.5;
        self.layer.borderColor = YLColor(155.f, 155.f, 155.f).CGColor;
        self.font = [UIFont systemFontOfSize:12];
        
        // 设置内容 -- 垂直居中
        self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        
        // 设置左边显示一个放大镜
        UIImageView *leftView = [[UIImageView alloc] init];
        leftView.image = [UIImage imageNamed:@"searchbar_textfield_search_icon"];
        leftView.width = leftView.image.size.width + 10;
        leftView.height = leftView.image.size.height;
        
        // 设置leftView的内容居中
        leftView.contentMode = UIViewContentModeCenter;
        self.leftView = leftView;
        
        // 设置左边的View永远显示
        self.leftViewMode = UITextFieldViewModeAlways;
        
        // 设置右边永远显示清除按钮
        self.clearButtonMode = UITextFieldViewModeAlways;
    }
    
    return self;
}

+ (instancetype)searchBar {
    return [[self alloc] init];
}
@end
