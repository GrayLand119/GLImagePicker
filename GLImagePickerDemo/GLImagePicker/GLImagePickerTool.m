//
//  GLImagePickerTool.m
//  GLImagePickerDemo
//
//  Created by GrayLand on 17/2/20.
//  Copyright © 2017年 GrayLand. All rights reserved.
//

#import "GLImagePickerTool.h"
#import <AVFoundation/AVFoundation.h>
#import <AssetsLibrary/AssetsLibrary.h>

@implementation GLImagePickerTool

/**
 *  是否允许访问相机
 *
 *  @return
 */
+ (BOOL)isAllowUseCamera {

    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (authStatus == AVAuthorizationStatusRestricted || authStatus ==AVAuthorizationStatusDenied) {
        //无权限
        return NO;
    }
    
    return YES;
}

/**
 *  是否允许访问相册
 *
 *  @return
 */
+ (BOOL)isAllowUseAlbum {
    
    ALAuthorizationStatus author = [ALAssetsLibrary authorizationStatus];
    if (author == ALAuthorizationStatusRestricted || author == ALAuthorizationStatusDenied){
        //无权限
        return NO;
    }
    return YES;
}

@end
