//
//  YLHomeHeader.m
//  YLGoodCard
//
//  Created by lm on 2018/11/15.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import "YLHomeHeader.h"
#import "YLNotable.h"
#import "SDCycleScrollView.h"
#import "YLBannerView.h"


@implementation YLHomeHeader

- (instancetype)initWithFrame:(CGRect)frame bannerTitles:(NSMutableArray *)bannerTitles notabletitles:(NSMutableArray *)notabletitles {
    
    self = [super initWithFrame:(frame)];
    if (self) {
        float width = frame.size.width;
        CGRect bannerRect = CGRectMake(0, 0, width, 220);
//        SDCycleScrollView *scrollView = [SDCycleScrollView cycleScrollViewWithFrame:bannerRect imageURLStringsGroup:bannerTitles];
//        [self addSubview:scrollView];
        YLBannerView *bannerView = [[YLBannerView alloc] init];
        bannerView.frame = bannerRect;
        bannerView.banners = bannerTitles;
        bannerView.timeInterval = 3;
        [self addSubview:bannerView];
        
        
        CGRect notableRect = CGRectMake(0, CGRectGetMaxY(bannerView.frame), width, 60);
        YLNotable *notable = [[YLNotable alloc] initWithWithFrame:notableRect titles:notabletitles];
        [self addSubview:notable];
        
        CGRect goupHeaderRect = CGRectMake(0, CGRectGetMaxY(notable.frame), width, 44);
        YLTableGroupHeader *groupHeader = [[YLTableGroupHeader alloc] initWithFrame:goupHeaderRect image:@"热门二手车" title:@"热门二手车" detailTitle:@"查看更多" arrowImage:@"更多"];
        [self addSubview:groupHeader];
        self.groupHeader = groupHeader;
        
        NSArray *btnTitles = [NSArray arrayWithObjects:@"5万以下", @"5-10万", @"10-15万", @"15万以上", @"哈弗", @"丰田",@"大众", @"本田", @"力帆", @"日产", @"雪佛兰", @"现代", nil];
        CGRect buttonRect = CGRectMake(0, CGRectGetMaxY(groupHeader.frame), width, 99);
        YLButtonView *buttonView = [[YLButtonView alloc] initWithFrame:buttonRect btnTitles:btnTitles];
        [self addSubview:buttonView];
        self.buttonView = buttonView;
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(buttonView.frame), width, 1)];
        line.backgroundColor = YLColor(233.f, 233.f, 233.f);
        [self addSubview:line];
    }
    return self;
}
@end
