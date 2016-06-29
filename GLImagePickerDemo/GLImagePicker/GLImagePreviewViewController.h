//
//  GLImagePreviewViewController.h
//  GLImagePickerDemo
//
//  Created by GrayLand on 16/6/29.
//  Copyright © 2016年 GrayLand. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>

@class GLImagePreviewViewController;

@protocol GLImagePreviewViewControllerDelegate <NSObject>

@required
- (ALAsset *)imagePreviewViewController:(GLImagePreviewViewController *)vc assetAtIndex:(NSInteger)index;
@end


@interface GLImagePreviewViewController : UIViewController

- (instancetype)initWithStartIndex:(NSInteger)index;

@property (nonatomic, weak) id <GLImagePreviewViewControllerDelegate> delegate;

@end
