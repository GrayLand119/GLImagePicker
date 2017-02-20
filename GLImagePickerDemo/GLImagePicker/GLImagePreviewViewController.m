//
//  GLImagePreviewViewController.m
//  GLImagePickerDemo
//
//  Created by GrayLand on 16/6/29.
//  Copyright © 2016年 GrayLand. All rights reserved.
//

#import "GLImagePreviewViewController.h"
#import "GLImagePickerConstant.h"
#import "POP+MCAnimate.h"

@interface GLImagePreviewViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIImageView *previousImageView;
@property (nonatomic, strong) UIImageView *nextIamgeView;

@property (nonatomic, strong) UIButton    *selectBtn;

@property (nonatomic, strong) NSArray *assets;
@property (nonatomic, assign) NSInteger index;

@property (nonatomic, assign) NSInteger reuseIndex;//0...2

@property (nonatomic, assign) BOOL isSelected;
@end

@implementation GLImagePreviewViewController


- (instancetype)initWithStartIndex:(NSInteger)index assets:(NSArray *)assets
{
    if (self = [super init]) {
        _index  = index;
        _assets = [assets copy];
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
    _scrollView.showsVerticalScrollIndicator = _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.contentSize     = CGSizeMake(k_width_screen * 3, k_height_screen);
    _scrollView.backgroundColor = [UIColor whiteColor];
    _scrollView.delegate        = self;
    
    // current
    _imageView                     = [[UIImageView alloc] initWithFrame:CGRectMake(k_width_screen, 0, k_width_screen, k_height_screen)];
    _imageView.contentMode         = UIViewContentModeScaleAspectFit;
    // previous
    _previousImageView             = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, k_width_screen, k_height_screen)];
    _previousImageView.contentMode = UIViewContentModeScaleAspectFit;
    // next
    _nextIamgeView                 = [[UIImageView alloc] initWithFrame:CGRectMake(k_width_screen*2, 0, k_width_screen, k_height_screen)];
    _nextIamgeView.contentMode     = UIViewContentModeScaleAspectFit;
    
    [_scrollView addSubview:_imageView];
    [_scrollView addSubview:_previousImageView];
    [_scrollView addSubview:_nextIamgeView];
    
    
    if (_index == 0){
        
        _imageView.image         = [self imageWithIndex:_index + 1];
        _previousImageView.image = [self imageWithIndex:_index];
        _nextIamgeView.image     = [self imageWithIndex:_index + 2];
        
        _scrollView.contentOffset = CGPointMake(0, 0);
        
        _reuseIndex = 0;
        
    }else if(_index == _assets.count - 1) {
        
        _imageView.image         = [self imageWithIndex:_index - 1];
        _previousImageView.image = [self imageWithIndex:_index - 2];
        _nextIamgeView.image     = [self imageWithIndex:_index];
        
        _scrollView.contentOffset = CGPointMake(k_width_screen * 2, 0);
        
        _reuseIndex = 2;
    }else{
        
        _imageView.image         = [self imageWithIndex:_index];
        _previousImageView.image = [self imageWithIndex:_index - 1];
        _nextIamgeView.image     = [self imageWithIndex:_index + 1];
        
        _scrollView.contentOffset = CGPointMake(k_width_screen, 0);
        
        _reuseIndex = 1;
    }
    
    [self.view addSubview:_scrollView];
    
    [self setupNavigationItem];
}

- (void)setupNavigationItem
{
    CGRect rect = CGRectMake(k_width_screen - SELECT_BTN_SIZE.width - 20, 0, SELECT_BTN_SIZE.width,SELECT_BTN_SIZE.height);
    _selectBtn = [[UIButton alloc] initWithFrame:rect];
    
    _selectBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    _selectBtn.imageEdgeInsets       = UIEdgeInsetsMake(6, 9, 6, 3);
    
    [_selectBtn setImage:[UIImage imageNamed:@"GLImagePicker.bundle/ico_select_normal"] forState:UIControlStateNormal];
    [_selectBtn setImage:[UIImage imageNamed:@"GLImagePicker.bundle/ico_select_selected.png"] forState:UIControlStateSelected];
    [_selectBtn addTarget:self action:@selector(onSelect:) forControlEvents:UIControlEventTouchUpInside];

    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:_selectBtn];
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                       target:nil action:nil];
    /**
     *  width为负数时，相当于btn向右移动width数值个像素，由于按钮本身和边界间距为5pix，所以width设为-5时，间距正好调整
     *  为0；width为正数时，正好相反，相当于往左移动width数值个像素
     */
    negativeSpacer.width = -10;
    
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:negativeSpacer, rightItem, nil];


    if (self.delegate && [self.delegate respondsToSelector:@selector(imagePreviewViewController:isSelectedAtIndex:)]) {
        
        BOOL isSelected = [self.delegate imagePreviewViewController:self isSelectedAtIndex:_index];
        _selectBtn.selected = isSelected;
    }
    
}
#pragma mark -
#pragma mark private

- (UIImage *)imageWithIndex:(NSInteger)index
{
    UIImage *img = nil;
    
    if (_delegate && [_delegate respondsToSelector:@selector(imagePreviewViewController:assetAtIndex:)]) {
        
        ALAsset *asset = [_delegate imagePreviewViewController:self assetAtIndex:index];
        
        if (!asset) {
            return nil;
        }
        
        CGImageRef ref = [[asset defaultRepresentation] fullResolutionImage];
        
        img = [[UIImage alloc]initWithCGImage:ref];
        
    }
    
    return img;
}

- (void)updateSelectButton
{
    if (_delegate && [_delegate respondsToSelector:@selector(imagePreviewViewController:isSelectedAtIndex:)]) {
        self.isSelected = [_delegate imagePreviewViewController:self isSelectedAtIndex:_index];
        

    }else{
        self.isSelected = NO;
    }
}

#pragma mark -
#pragma mark Setter & Getter

- (void)setIsSelected:(BOOL)isSelected
{
    _isSelected = isSelected;
    _selectBtn.selected = isSelected;
    
    if (isSelected) {
            _selectBtn.pop_springSpeed = 12;
            _selectBtn.pop_springBounciness = 20;
            
            _selectBtn.pop_scaleXY = CGPointMake(0.8, 0.8);
            _selectBtn.pop_spring.pop_scaleXY = CGPointMake(1.0, 1.0);
    }
    
}
#pragma mark -
#pragma mark Target

- (void)onSelect:(UIButton *)sender
{
    sender.selected = !sender.isSelected;
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(imagePreviewViewController:didSelect:atIndex:)]) {
        [self.delegate imagePreviewViewController:self didSelect:sender.isSelected atIndex:_index];
    }
}

#pragma mark -
#pragma mark UIScrollViewDelegate

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    __block NSInteger scrollToIndex = floor((*targetContentOffset).x / k_width_screen + 0.5);
    
    void (^reloadBlock)(void) = ^{
        
        if (_index <= 0 || _index >= _assets.count) {
            // out of range
            return;
        }
        NSLog(@"image Index:%ld", _index);
        
        UIImage *imagePrevious = [self imageWithIndex:_index - 1];
        UIImage *imageNext     = [self imageWithIndex:_index + 1];
        UIImage *imageCurrent  = [self imageWithIndex:_index];
        
        _imageView.image         = imageCurrent;

        scrollView.contentOffset = CGPointMake(k_width_screen, 0);

        _previousImageView.image = imagePrevious;
        _nextIamgeView.image     = imageNext;
        
        _reuseIndex = 1;
    };
    
    void (^scrollAnimationWithIsNeedReload)(BOOL) = ^(BOOL isNeedReload){
        
        (*targetContentOffset).x = k_width_screen * scrollToIndex;
        
        NSLog(@"currentReuseIndex:%ld , scrollToIndex:%ld", _reuseIndex, scrollToIndex);
        
        [UIView animateWithDuration:0.25f animations:^{
            scrollView.contentOffset = CGPointMake(k_width_screen * scrollToIndex, 0);
        } completion:^(BOOL finished) {
            if (isNeedReload && finished) {
                reloadBlock();
            }
            [self updateSelectButton];
        }];
    };
    
    
    if (scrollToIndex == _reuseIndex) {
        scrollAnimationWithIsNeedReload(NO);
        return;
    }
    
    if (scrollToIndex > _reuseIndex) {
        scrollToIndex = ++_reuseIndex;
        _index++;
        scrollAnimationWithIsNeedReload(YES);
        return;
    }
    
    if (scrollToIndex < _reuseIndex) {
        scrollToIndex = --_reuseIndex;
        _index--;
        scrollAnimationWithIsNeedReload(YES);
        return;
    }
    
}
@end
