//
//  Created by GrayLand on 16/6/12.
//  Copyright © 2016年 GrayLand. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>

@class GLImageSelectViewCell;

@protocol GLImageSelectViewCellDelegate <NSObject>

@optional

/**
 *  点击选择按钮
 *
 *  @param cell
 */
- (void)imageSelectViewCellDidTapSelectButton:(GLImageSelectViewCell *)cell;

/**
 *  点击图片按钮(实现预览)
 *
 *  @param cell
 */
- (void)imageSelectViewCellDidTapImageButton:(GLImageSelectViewCell *)cell;

@end

@interface GLImageSelectViewCell : UICollectionViewCell

// custom code

@property (nonatomic, weak) id <GLImageSelectViewCellDelegate> delegate;

@property (nonatomic, copy  ) NSIndexPath *indexPath;
@property (nonatomic, strong) ALAsset     *asset;

@property (nonatomic, assign, getter=isSelected) BOOL selected;

@end
