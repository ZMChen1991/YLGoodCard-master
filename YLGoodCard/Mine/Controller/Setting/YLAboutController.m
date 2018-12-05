//
//  YLAboutController.m
//  YLGoodCard
//
//  Created by lm on 2018/11/13.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import "YLAboutController.h"

@interface YLAboutController ()

@end

@implementation YLAboutController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"关于优卡";
    
    UIImageView *icon = [[UIImageView alloc] initWithFrame:CGRectMake(148, 94, 80, 80)];
    icon.backgroundColor = [UIColor redColor];
    [self.view addSubview:icon];
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(icon.frame) + 5, YLScreenWidth, 22)];
    title.text = @"优卡汽车";
    title.font = [UIFont systemFontOfSize:16];
    title.textColor = YLColor(51.f, 51.f, 51.f);
    title.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:title];
    
    UILabel *versions = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(title.frame), YLScreenWidth, 20)];
    versions.textAlignment = NSTextAlignmentCenter;
    versions.text = @"v1.11";
    versions.textColor = YLColor(155.f, 155.f, 155.f);
    versions.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:versions];
    
    UITextView *text = [[UITextView alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(versions.frame), YLScreenWidth - 40, 436)];
    text.text = @"优卡汽车直卖网于2019年1月1日正式上线,秉持二手车直卖模式,没有中间商赚差价,开创线上线下高度融合的新零售保卖服务,在让二手车价格透明化的同时,将原本由中间环节层层加码产生的差价让渡给买卖双方,实现了“卖家多卖,买家多省”的双赢局面。\n\n优卡汽车直卖网涵盖二手车交易、评估检测、定价、汽车金融、保险、延保等服务。为了保证买卖双方优质的体验,瓜子二手车为广大车主提供免费上门评估，二手车帮卖，代办过户等服务;对车源进行严格限制，建立专业评估师团队，并通过“五查一保机制”体系，确保买卖双方权益。目前，优卡汽车服务覆盖全国30个省市、城市覆盖超过200个，金融服务覆盖超过150个城市。\n\n优卡汽车直卖网隶属于车好多集团,与毛豆新车网实行双品牌运作。车好多集团A轮融资超2.5亿美元，B轮融资近6亿美元,C轮融资8.18亿美元。主要投资方为红杉资本中国基金、 H CAPITAL、腾讯、经纬创投、DSTGloba、山行资本、今日资本、云锋基金、招银电信新趋势股权投资基金、方源资本、GC、工银国际Dragoneer Investment Group、首钢基金、蓝驰创投中银投资、泰合资本、1DG资本等。";
    text.font = [UIFont systemFontOfSize:14];
    text.textColor = YLColor(155.f, 155.f, 155.f);
    text.editable = NO;
    [self.view addSubview:text];
    
}


@end
