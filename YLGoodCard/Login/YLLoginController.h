//
//  YLLoginController.h
//  YLGoodCard
//
//  Created by lm on 2018/11/12.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^LoginBlock)(NSString *string);
@class YLLoginController;
@protocol YLLoginControllerDelegate <NSObject>
@optional
- (void)switchView;
@end

@interface YLLoginController : UIViewController

@property (nonatomic, weak) id<YLLoginControllerDelegate> delegate;
@property (nonatomic, copy) LoginBlock loginBlock;


@end
