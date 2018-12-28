//
//  YLBannerCollectionView.h
//  YLCollection
//
//  Created by lm on 2018/12/15.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YLBannerCollectionView : UIView

@property (nonatomic, strong) NSArray *images;

@end


@interface YlBannerCollectionCell : UICollectionViewCell

//@property (nonatomic, strong) NSString *image;
@property (nonatomic, strong) UIImage *image;

@end

NS_ASSUME_NONNULL_END
