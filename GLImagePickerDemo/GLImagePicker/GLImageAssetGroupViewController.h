//   L00000:                           L00                              L0L
//  L0000000:                          L00                              00L
// L00010000L                          L00                              00L
//:00L   11:  10LL0L :00000 :000   000 100       L00001  10:L000    000L00L
//L00:        10000::000000L 000: :00L 100      L000000: 10000000  L000000L
//L00: :00000 :00L: 100L  00 100L L00: L00      0001 10L 1001L000 :000 :00L
//L00  100000 :00       1L00  000 L00  L00         :100L 10L  000 100L  00L
//L00: 100000 :0L    1000000  L00100L  L00       000000L 10L  000 100L  L0L
//1000    000 :0L   L000: 00  100000:  L00      000L 10L 10L  000 100L  L0L
// 1000000000 :0L   000: 100:  00000   100000001000  00L 10L  000 :000 :00L
//  00000000: 10L   L0000000   L0001   L0000000:0000000L 10L  000  0000000L
//   L0000L   10L    000:L00:  :000:   10000000::0000:00 10L  000: :000LL0L
//                              :00                 :
//                            0000L
//                            0000:
//                            :L1
//
//  Created by GrayLand on 16/6/7.
//  Copyright © 2016年 GrayLand. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GLImagePickerConfig.h"


@class GLImageAssetGroupViewController;

@protocol GLImageAssetGroupViewControllerDelegate <NSObject>

@optional

/**
 *  选择图片代理
 *
 *  @param imagePicker  图片选择器
 *  @param images       选择的图片
 */
- (void)imageAssetGroupViewController:(GLImageAssetGroupViewController *)viewController didPickWithImages:(NSArray <UIImage *> *)images;

/**
 *  选择视频代理
 *
 *  @param imagePicker 图片选择器
 *  @param video       选择的视频
 */
- (void)imageAssetGroupViewController:(GLImageAssetGroupViewController *)viewController didPickWithVideos:(NSArray *)videos;

@end


/*===============================================================
            Interface
 ===============================================================*/

@interface GLImageAssetGroupViewController: UITableViewController

- (instancetype)initWithConfig:(GLImagePickerConfig *)config;

@property (nonatomic, weak) id <GLImageAssetGroupViewControllerDelegate> delegate;

@end
