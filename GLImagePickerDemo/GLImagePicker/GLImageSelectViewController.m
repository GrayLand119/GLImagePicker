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
//                              :00                 
//                            0000L
//                            0000:
//                            :L1
//
//  Created by GrayLand on 16/6/12.
//  Copyright © 2016年 GrayLand. All rights reserved.
//

#import "GLImageSelectViewController.h"
#import "GLImageSelectViewCell.h"
#import "GLImagePickerConstant.h"
#import "Masonry.h"
#import "GLImageSelectViewFlowLayout.h"
#import "GLCollectionView.h"


@interface GLImageSelectViewController ()
<GLImageSelectViewCellDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) GLCollectionView *collectionView;

@property (nonatomic, strong) ALAssetsGroup *assetGroups;
@property (nonatomic, strong) NSMutableArray <ALAsset *> *assetArr;///<数据集合
@property (nonatomic, strong) GLImagePickerConfig *config;///<配置文件

@property (nonatomic, strong) NSMutableArray <NSIndexPath *> *selectedIndexPaths;
@property (nonatomic, assign) NSInteger numOfSelected;

@end

@implementation GLImageSelectViewController

#pragma mark - def
DEFINE_KEY_STRING(kImageSelectViewCellReuseId)
DEFINE_KEY_STRING(kFooterViewCellReuseId)
//DEFINE_KEY_STRING(kFooterViewExtCellReuseId)

#pragma mark - override

- (instancetype)initWithAssetGroups:(ALAssetsGroup *)assetGroups
                             config:(GLImagePickerConfig  *)config;
{
    if (self = [super init]) {
        
        NSAssert(assetGroups, @"assetGroups can't be nil");
        _assetGroups       = assetGroups;
        _assetArr          = [NSMutableArray array];
        _selectedIndexPaths = [NSMutableArray array];
        
        [_assetGroups enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
            if (result) {
                [_assetArr addObject:result];
            }
        }];
        
        [_assetArr addObject:[[ALAsset alloc] init]];// empty for footer
        
        _config = config ? config : [GLImagePickerConfig defaultConfig];
        
        _numOfSelected = 0;
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupNavitationItem];
    [self updateNavitationTitle];
    [self setupViews];
    
    
    [self.collectionView reloadData];
    
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    NSIndexPath *path = [NSIndexPath indexPathForRow:_assetArr.count - 1 inSection:0];
    [self.collectionView scrollToItemAtIndexPath:path atScrollPosition:UICollectionViewScrollPositionBottom animated:YES];
}

#pragma mark - private
// 创建控件
- (void)setupViews
{
    GLImageSelectViewFlowLayout *flow = [[GLImageSelectViewFlowLayout alloc] initWithColumnNum:_config.assetNumberOfColumn];
    
    _collectionView = [[GLCollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:flow];
    
    [self.collectionView registerClass:[GLImageSelectViewCell class] forCellWithReuseIdentifier:kImageSelectViewCellReuseId];
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:kFooterViewCellReuseId];
//    [self.collectionView registerClass:[UICollectionViewCell class] forSupplementaryViewOfKind:@"kFooter"
//                   withReuseIdentifier:kFooterViewExtCellReuseId];
    
    self.collectionView.backgroundColor      = [UIColor whiteColor];
    self.collectionView.alwaysBounceVertical = YES;
    self.collectionView.delegate             = self;
    self.collectionView.dataSource           = self;
    
    [self.view addSubview:_collectionView];
}

- (void)setupNavitationItem
{
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(onDone:)];
    
    
    self.navigationItem.rightBarButtonItem = rightItem;
    
}
- (void)updateNavitationTitle
{
    NSString *title;
    
    _numOfSelected = _selectedIndexPaths.count;
    
    if (_numOfSelected) {
        title = [NSString stringWithFormat:@"已选择%ld张照片", _numOfSelected];
    }else{
        title = [self.assetGroups valueForProperty:ALAssetsGroupPropertyName];
    }
    self.navigationItem.rightBarButtonItem.enabled = _numOfSelected;
    
    self.navigationItem.title = title;
}

// 初始化布局
- (void)createLayouts
{
    
}

// 给控件创建事件
- (void)setupTarget
{
    
}

//- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
//{
//    if ([kind isEqualToString:@"kFooter"]) {
//        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kFooterViewExtCellReuseId forIndexPath:indexPath];
//        cell.backgroundColor = [UIColor redColor];
//        return cell;
//    }else{
//        return nil;
//    }
//}

#pragma mark - getter / setter

#pragma mark - api

#pragma mark - model event
#pragma mark 1 notification
#pragma mark 2 KVO
#pragma mark 3 OtherEvent

#pragma mark - view event
#pragma mark 1 target-action
- (void)onDone:(id)sender
{
    NSLog(@"onDone");
}
#pragma mark 2 delegate dataSource protocol
#pragma mark UICollectionViewDelegate & UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.assetArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    // the last one is footer cell
    if (indexPath.row == self.assetArr.count - 1) {
        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kFooterViewCellReuseId forIndexPath:indexPath];
        NSAssert(cell, @"FooterViewCellReuseId is nil");
        
        UILabel *title = [[UILabel alloc] initWithFrame:cell.bounds];
        title.text = [NSString stringWithFormat:@"%ld张照片", self.assetArr.count - 1];
        //TODO : 视频
        title.textColor = [UIColor blackColor];
        title.textAlignment = NSTextAlignmentCenter;
        [cell.contentView addSubview:title];
        
        return cell;
    }
    
    // ImageSelectViewCell
    GLImageSelectViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kImageSelectViewCellReuseId forIndexPath:indexPath];
    
    NSAssert(cell, @"ImageSelectViewCellReuseId is nil");
    
    cell.delegate  = self;
    cell.asset     = self.assetArr[indexPath.row];
    cell.indexPath = indexPath;
    cell.selected  = [self.selectedIndexPaths containsObject:indexPath];

    
    // 偷懒,最后一列设置左对齐
    NSInteger lastRowItemNum = (self.assetArr.count - 1) % _config.assetNumberOfColumn;
    if (indexPath.row > self.assetArr.count - 2 - lastRowItemNum) {
        NSInteger lastRowIndex = indexPath.row  % _config.assetNumberOfColumn;// 0...3
        cell.frame = CGRectMake(((_config.thumbnailWidth + _config.marginForSelectCell.right) * lastRowIndex),
                                cell.frame.origin.y,
                                cell.frame.size.width,
                                cell.frame.size.height);
        
        NSLog(@"cell center :%@", NSStringFromCGPoint(cell.center));
    }
    return cell;
}

#pragma mark -
#pragma mark UICollectionViewDelegateFlowLayout

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == self.assetArr.count - 1) {
        return CGSizeMake(k_width_screen, 44);//footer
    }else{
        return CGSizeMake(_config.thumbnailWidth, _config.thumbnailHeight);
    }
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView
                        layout:(UICollectionViewLayout *)collectionViewLayout
        insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

#pragma mark -
#pragma mark GLImageSelectViewCellDelegate
- (void)imageSelectViewCellDidTapSelectButton:(GLImageSelectViewCell *)cell
{
    NSLog(@"tap select button");
    if (cell.isSelected) {
        [self.selectedIndexPaths addObject:cell.indexPath];
    }else{
        [self.selectedIndexPaths removeObject:cell.indexPath];
    }
    
    [self updateNavitationTitle];
}

- (void)imageSelectViewCellDidTapImageButton:(GLImageSelectViewCell *)cell
{
    NSLog(@"tap image button");
//    if (cell.isSelected) {
//        [self.selectedIndexPaths addObject:cell.indexPath];
//    }else{
//        [self.selectedIndexPaths removeObject:cell.indexPath];
//    }
//    
//    [self updateNavitationTitle];
}
#pragma mark -

@end
