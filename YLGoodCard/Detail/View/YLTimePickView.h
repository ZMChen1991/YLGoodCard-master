//
//  YLTimePickView.h
//  YLGoodCard
//
//  Created by lm on 2018/11/9.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^TimePickBlock)(NSString *timeString);

@interface YLTimePickView : UIView

@property (nonatomic, copy) TimePickBlock timePickBlock;

@end
