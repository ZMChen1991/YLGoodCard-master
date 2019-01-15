//
//  YLBuyConditionModel.h
//  YLGoodCard
//
//  Created by lm on 2019/1/9.
//  Copyright © 2019 Chenzhiming. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YLBuyConditionModel : NSObject

@property (nonatomic, strong) NSString *param;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *detail;
@property (nonatomic, strong) NSString *key;
//@property (nonatomic, assign) NSInteger index;

@property (nonatomic, assign) BOOL isSelect;

@end

NS_ASSUME_NONNULL_END
