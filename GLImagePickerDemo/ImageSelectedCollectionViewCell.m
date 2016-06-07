//
//  ImageSelectedCollectionViewCell.m
//  GLImagePicker
//
//  Created by GrayLand on 16/6/6.
//  Copyright © 2016年 GrayLand. All rights reserved.
//

#import "ImageSelectedCollectionViewCell.h"
#import "Masonry.h"

@interface ImageSelectedCollectionViewCell()

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation ImageSelectedCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setupViews];
    }
    return self;
}
- (void)setupViews
{
    _imageView = [UIImageView new];
    _imageView.contentMode   = UIViewContentModeScaleAspectFill;
    _imageView.clipsToBounds = YES;
    [self.contentView addSubview:_imageView];
    
    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(_imageView.superview);
    }];
}

//- (void)layoutSubviews
//{
//    [_imageView mas_updateConstraints:^(MASConstraintMaker *make) {
////        make.edges.mas_equalTo(_imageView.superview);
//        make.width.height.mas_equalTo(100);
//    }];
//}
#pragma mark -
#pragma mark getter & setter

- (void)setImage:(UIImage *)image
{
    NSAssert(_imageView, @"imageView can't be nil");
    
    _image = image;
    
    [_imageView setImage:image];
    
    NSLog(@"ImageSize:%@", NSStringFromCGSize(image.size));
//    [_imageView setNeedsLayout];
//    [_imageView layoutIfNeeded];
}

@end
