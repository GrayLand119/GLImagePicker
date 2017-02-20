//
//  GLImagePickerTool.h
//  GLImagePickerDemo
//
//  Created by GrayLand on 17/2/20.
//  Copyright © 2017年 GrayLand. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GLImagePickerTool : NSObject


/**
 *  是否允许访问相机
 *
 *  @return
 */
+ (BOOL)isAllowUseCamera;

/**
 *  是否允许访问相册
 *
 *  @return
 */
+ (BOOL)isAllowUseAlbum;

@end
