//
//  YLMainController.h
//  YLGoodCard
//
//  Created by lm on 2018/11/1.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^myBlock)(NSString *title);

@interface YLMainController : UIViewController

@property (nonatomic, copy) myBlock block;

//@property (nonatomic, copy) NSMutableArray *images; // 存放转播图的数组
//@property (nonatomic, copy) NSMutableArray *notableTitles; // 存放走马灯广告

@end
