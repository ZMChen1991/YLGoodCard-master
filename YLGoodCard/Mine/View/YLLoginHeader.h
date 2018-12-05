//
//  YLLoginHeader.h
//  YLGoodCard
//
//  Created by lm on 2018/11/12.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YLLoginHeader;

@protocol YLLoginHeaderDelegate <NSObject>
@optional
- (void)skipToLogin;
@end

@interface YLLoginHeader : UIView
@property (nonatomic, weak) id<YLLoginHeaderDelegate> delegate;
@end
