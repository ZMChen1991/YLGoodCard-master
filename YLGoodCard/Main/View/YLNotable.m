//
//  YLNotable.m
//  YLGoodCard
//
//  Created by lm on 2018/11/15.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import "YLNotable.h"

@interface YLNotable ()

@property (nonatomic, strong) UILabel *titleL;
@property (nonatomic, assign) NSInteger count;

@end

@implementation YLNotable

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        float width = frame.size.width;
        float height = frame.size.height;
        UIImageView *icon = [[UIImageView alloc] initWithFrame:CGRectMake(YLLeftMargin, 8, 36, height - 2 * 8)];
        icon.image = [UIImage imageNamed:@"最新成交"];
        [self addSubview:icon];
        
        UILabel *titleL = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(icon.frame) + 20, 8, width - 36 - 20 - 2 * YLLeftMargin, height- 2 * 8)];
        titleL.font = [UIFont systemFontOfSize:12];
        titleL.numberOfLines = 0;
        [self addSubview:titleL];
        self.titleL = titleL;
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(titleL.frame)+8, width, 1)];
        line.backgroundColor = YLColor(233.f, 233.f, 233.f);
        [self addSubview:line];
        
        // 使用定时器更新title
        [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(updataTitles) userInfo:nil repeats:YES];
    }
    return self;
}

- (void)updataTitles {
    
    if (!self.titles.count) {
        return;
    }
    if (self.count < self.titles.count) {
        self.titleL.text = self.titles[self.count];
    } else {
        self.count = 0;
        self.titleL.text = self.titles[self.count];
    }
    self.count++;
}

- (void)setTitles:(NSArray *)titles {
    _titles = titles;
    self.count = 0;
    
    if (!titles.count) {
        return;
    }
    self.titleL.text = titles[self.count];
}

@end
