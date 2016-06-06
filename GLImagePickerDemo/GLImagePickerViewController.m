//
//  GLImagePickerViewController.m
//  GLImagePicker
//
//  Created by GrayLand on 16/6/6.
//  Copyright © 2016年 GrayLand. All rights reserved.
//

#import "GLImagePickerViewController.h"
#import "Masonry.h"
#import "ImageSelectedCollectionViewCell.h"

#define k_width_screen  [UIScreen mainScreen].bounds.size.width
#define k_height_screen [UIScreen mainScreen].bounds.size.height

#define DEFINE_KEY_STRING(str) static NSString *const str = @#str;
DEFINE_KEY_STRING(kImageSelectedCollectionViewCellReuseId)


@interface GLImagePickerViewController ()
<UICollectionViewDelegate,
UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout,
UIImagePickerControllerDelegate>

@property (nonatomic, strong) UIButton *singlePickBtn;
@property (nonatomic, strong) UIButton *multiPickBtn;

@property (nonatomic, strong) UICollectionView *selectionsView;

@property (nonatomic, strong) NSMutableArray <UIImage *> *imageSelectionArr;

@end

@implementation GLImagePickerViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _imageSelectionArr = [NSMutableArray array];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"GLImagePickerDemo";
    
    [self setupViews];
    [self makeConstrains];
}

- (void)setupViews
{
    _singlePickBtn = [UIButton new];
    [_singlePickBtn setTitle:@"选择单张图片" forState:UIControlStateNormal];
    [_singlePickBtn setTitleColor:[UIColor colorWithRed:0.0 green:0.502 blue:1.0 alpha:1.0] forState:UIControlStateNormal];
    [_singlePickBtn addTarget:self action:@selector(onSelectImgSingle:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_singlePickBtn];
    
    _multiPickBtn = [UIButton new];
    [_multiPickBtn setTitle:@"选择多张图片" forState:UIControlStateNormal];
    [_multiPickBtn setTitleColor:[UIColor colorWithRed:0.0 green:0.502 blue:1.0 alpha:1.0] forState:UIControlStateNormal];
    [_multiPickBtn addTarget:self action:@selector(onSelectImgMulti:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_multiPickBtn];
    
    UICollectionViewFlowLayout *cvfl = [[UICollectionViewFlowLayout alloc] init];
    [cvfl setScrollDirection:UICollectionViewScrollDirectionVertical];
    
    _selectionsView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:cvfl];
    [_selectionsView registerClass:[ImageSelectedCollectionViewCell class] forCellWithReuseIdentifier:kImageSelectedCollectionViewCellReuseId];
    _selectionsView.backgroundColor      = [UIColor whiteColor];
    _selectionsView.alwaysBounceVertical = YES;
    _selectionsView.delegate             = self;
    _selectionsView.dataSource           = self;
    
    [self.view addSubview:_selectionsView];
}

- (void)makeConstrains
{
    [_singlePickBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_singlePickBtn.superview).offset(74);
        make.centerX.mas_equalTo(_singlePickBtn.superview);
        make.height.mas_equalTo(44);
    }];
    
    [_multiPickBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_singlePickBtn.mas_bottom).offset(10);
        make.centerX.mas_equalTo(_multiPickBtn.superview);
        make.height.mas_equalTo(44);
    }];
    
    [_selectionsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_multiPickBtn.mas_bottom).offset(10);
        make.left.right.bottom.mas_equalTo(_selectionsView.superview);
    }];
}

#pragma mark -
#pragma mark OnEvent

- (void)onSelectImgSingle:(UIButton  * _Nullable )sender
{
    UIImagePickerController *vc = [[UIImagePickerController alloc] init];
    vc.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    vc.delegate = self;

    [self.navigationController presentViewController:vc animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    UIImage *imgPicked = info[UIImagePickerControllerOriginalImage];
    
    if (imgPicked) {
        [_imageSelectionArr addObject:imgPicked];
        [_selectionsView reloadData];
    }
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
}
- (void)onSelectImgMulti:(UIButton  * _Nullable )sender
{
    
}

#pragma mark -
#pragma mark UICollectionViewDelegate & UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _imageSelectionArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ImageSelectedCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kImageSelectedCollectionViewCellReuseId forIndexPath:indexPath];
    
    NSAssert(cell, @"ImageSelectedCollectionViewCell is nil");
    
    cell.image = _imageSelectionArr[indexPath.row];
    
    return cell;
}

#pragma mark -
#pragma mark UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(floor(k_width_screen / 3), k_width_screen / 3);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}


@end
