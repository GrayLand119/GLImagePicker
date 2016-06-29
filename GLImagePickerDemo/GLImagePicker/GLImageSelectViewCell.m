//
//  Created by GrayLand on 16/6/12.
//  Copyright © 2016年 GrayLand. All rights reserved.
//

#import "GLImageSelectViewCell.h"
#import "Masonry.h"
#import "POP+MCAnimate.h"

#define SELECT_BTN_SIZE CGSizeMake(44,44)

@interface GLImageSelectViewCell ()

@property (nonatomic, strong) UIButton *imageButton;
@property (nonatomic, strong) UIButton *selectButton;

@end

@implementation GLImageSelectViewCell

@synthesize selected = _selected;

// custom code
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setupViews];
        [self createLayout];
        [self setupTargets];
    }
    
    return self;
}

- (void)setupViews
{
    _imageButton = [UIButton new];
//    _imageButton.backgroundColor = [UIColor redColor];
    _imageButton.imageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.contentView addSubview:_imageButton];
    
    _selectButton = [UIButton new];
//    _selectButton.backgroundColor = [UIColor greenColor];
    _selectButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
    _selectButton.imageEdgeInsets = UIEdgeInsetsMake(9, 9, 3, 3);
    [_selectButton setImage:[UIImage imageNamed:@"GLImagePicker.bundle/ico_select_normal"] forState:UIControlStateNormal];
    [_selectButton setImage:[UIImage imageNamed:@"GLImagePicker.bundle/ico_select_selected.png"] forState:UIControlStateSelected];
    
    [_imageButton addSubview:_selectButton];
}

- (void)createLayout
{
    [_imageButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(_imageButton.superview);
    }];
    
    [_selectButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(_selectButton.superview).offset(0);
        make.right.mas_equalTo(_selectButton.superview).offset(0);
        make.size.mas_equalTo(SELECT_BTN_SIZE);
    }];
}

- (void)setupTargets
{
    [_imageButton addTarget:self action:@selector(onTapImageButton:) forControlEvents:UIControlEventTouchUpInside];
    [_selectButton addTarget:self action:@selector(onTapSelectButton:) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark -
#pragma mark setter & getter
- (BOOL)isSelected
{
    return _selected;
}

- (void)setSelected:(BOOL)selected
{
    _selected = selected;
    _selectButton.selected = selected;
    
    if (selected) {
        //TODO: POP Animation
        _selectButton.pop_springSpeed = 12;
        _selectButton.pop_springBounciness = 20;
        
        _selectButton.pop_scaleXY = CGPointMake(0.8, 0.8);
        _selectButton.pop_spring.pop_scaleXY = CGPointMake(1.0, 1.0);
    }
}

- (void)setAsset:(ALAsset *)asset
{
    _asset = asset;
    
    UIImage *thumbnail = [UIImage imageWithCGImage:[asset thumbnail]];
    
    [_imageButton setImage:thumbnail forState:UIControlStateNormal];
}
#pragma mark -
#pragma mark Target

- (void)onTapImageButton:(UITapGestureRecognizer *)sender
{
    if (_delegate && [_delegate respondsToSelector:@selector(imageSelectViewCellDidTapImageButton:)]) {
        [_delegate imageSelectViewCellDidTapImageButton:self];
    }
}

- (void)onTapSelectButton:(UIButton *)sender
{
    self.selected = !self.isSelected;
    
    if (_delegate && [_delegate respondsToSelector:@selector(imageSelectViewCellDidTapSelectButton:)]) {
        [_delegate imageSelectViewCellDidTapSelectButton:self];
    }
}

@end
