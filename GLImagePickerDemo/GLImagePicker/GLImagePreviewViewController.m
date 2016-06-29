//
//  GLImagePreviewViewController.m
//  GLImagePickerDemo
//
//  Created by GrayLand on 16/6/29.
//  Copyright © 2016年 GrayLand. All rights reserved.
//

#import "GLImagePreviewViewController.h"
#import "GLImagePickerConstant.h"

@interface GLImagePreviewViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIImageView *previousImgViewReuse;
@property (nonatomic, strong) UIImageView *nextImgViewReuse;

@property (nonatomic, assign) NSInteger index;

@end

@implementation GLImagePreviewViewController

- (instancetype)init
{
    return [self initWithStartIndex:0];
}

- (instancetype)initWithStartIndex:(NSInteger)index
{
    if (self = [super init]) {
        _index = index;
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor                 = [UIColor whiteColor];
    
    
    _scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    _scrollView.contentSize = CGSizeMake(k_width_screen * 3, k_height_screen);
    _scrollView.backgroundColor = [UIColor whiteColor];
    _scrollView.delegate = self;
    
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(k_width_screen, 0, k_width_screen, k_height_screen)];
    _imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    if (_delegate && [_delegate respondsToSelector:@selector(imagePreviewViewController:assetAtIndex:)]) {
        ALAsset *asset = [_delegate imagePreviewViewController:self assetAtIndex:_index];
        
        CGImageRef ref = [[asset defaultRepresentation] fullResolutionImage];
        
        UIImage *img = [[UIImage alloc]initWithCGImage:ref];
        
        _imageView.image = img;
    }

    [_scrollView addSubview:_imageView];
    
    _scrollView.contentOffset = CGPointMake(k_width_screen, 0);
    
    [self.view addSubview:_scrollView];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
