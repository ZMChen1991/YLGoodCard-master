//
//  YLDetailHeaderModel.h
//  YLGoodCard
//
//  Created by lm on 2018/11/20.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YLDetailHeaderModel : NSObject

@property (nonatomic, strong) NSString *displayImg;//列表显示图片
@property (nonatomic, strong) NSString *originalPrice;//新车含税价
@property (nonatomic, strong) NSString *price;//价格
@property (nonatomic, strong) NSString *status;//状态：1待提交 2待审核 3上线 4退回 0下架
@property (nonatomic, strong) NSString *title;//标题

@end

NS_ASSUME_NONNULL_END
