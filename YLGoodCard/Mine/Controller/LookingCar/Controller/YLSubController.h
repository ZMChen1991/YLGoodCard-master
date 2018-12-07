//
//  YLSubController.h
//  YLGoodCard
//
//  Created by lm on 2018/11/13.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, YLCellType) {
    
    YLCellTypeNormal,
    YLCellTypeBargain,
};

@interface YLSubController : UITableViewController

@property (nonatomic, strong) NSMutableDictionary *param;
//@property (nonatomic, assign) YLCellType cellType; // cell的类型

@end

NS_ASSUME_NONNULL_END
