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

#import "GLImagePickerConfig.h"
#import "GLImagePickerConstant.h"

@interface GLImagePickerConfig()

@end

@implementation GLImagePickerConfig

+ (instancetype)defaultConfig
{
    GLImagePickerConfig *config = [[GLImagePickerConfig alloc] init];
    
    config.minNumberOfSelection = 1;
    config.maxNumberofSelection = 1;
    config.assetFilterType      = GLAssetFilterTypeAllAssets;
    config.assetNumberOfColumn  = 4;
    config.thumbnailWidth       = (k_width_screen - 3) / config.assetNumberOfColumn;
    config.thumbnailHeight      = config.thumbnailWidth;
    config.marginForSelectCell  = UIEdgeInsetsMake(1, 1, 1, 1);
    
    return config;
}

@end
