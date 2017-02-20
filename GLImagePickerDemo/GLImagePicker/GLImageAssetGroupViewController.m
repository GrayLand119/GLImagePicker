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

#import <AssetsLibrary/AssetsLibrary.h>
#import "GLImageAssetGroupViewController.h"
#import "GLImageAssetGroupViewCell.h"
#import "GLImageSelectViewController.h"

@interface GLImageAssetGroupViewController ()

@property (nonatomic, strong) GLImagePickerConfig *config;

@property (nonatomic, strong) ALAssetsLibrary *assetsLibrary;

@property (nonatomic, strong) NSMutableArray <ALAssetsGroup *> *assetGroups;

@end

@implementation GLImageAssetGroupViewController

#pragma mark - def

#pragma mark - override

- (instancetype)initWithConfig:(GLImagePickerConfig *)config
{
    if (self = [super initWithStyle:UITableViewStylePlain]) {
        _config = config;
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setNavigationItem];
    [self setupViews];
    [self loadAssets];
}

#pragma mark - private

- (void)setupViews
{
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

/**
 *  加载资源
 */
- (void)loadAssets
{
    ALAssetsLibraryGroupsEnumerationResultsBlock usingBlock = ^(ALAssetsGroup *group, BOOL *stop){
        if (group) {
            [group setAssetsFilter:[self assetsFilterWithType:_config.assetFilterType]];
            if (group.numberOfAssets > 0) {
                [self.assetGroups addObject:group];
            }
        }else{
            [self.tableView reloadData];
        }
    };
    
    ALAssetsLibraryAccessFailureBlock failureBlock = ^(NSError *error){
        //TODO: show failure page
    };
    
    [self.assetsLibrary enumerateGroupsWithTypes:ALAssetsGroupSavedPhotos
                                      usingBlock:usingBlock
                                    failureBlock:failureBlock];
    
//    NSUInteger type =
//    ALAssetsGroupLibrary | ALAssetsGroupAlbum | ALAssetsGroupEvent |
//    ALAssetsGroupFaces | ALAssetsGroupPhotoStream;
//    
//    [self.assetsLibrary enumerateGroupsWithTypes:type
//                                      usingBlock:usingBlock
//                                    failureBlock:failureBlock];
    
}

- (ALAssetsFilter *)assetsFilterWithType:(GLAssetFilterType)type
{
    switch (type) {
        case GLAssetFilterTypeAllPhotos:
            return [ALAssetsFilter allPhotos];
        case GLAssetFilterTypeAllVideos:
            return [ALAssetsFilter allVideos];
        case GLAssetFilterTypeAllAssets:
            return [ALAssetsFilter allAssets];
    }
}

- (void)setNavigationItem
{
    UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc] initWithTitle:@"取消"
                                                                style:UIBarButtonItemStylePlain
                                                               target:self
                                                               action:@selector(onCancel:)];
    self.navigationItem.leftBarButtonItem = leftBtn;
    
    self.navigationItem.title = @"相薄";
    
}
#pragma mark - getter / setter

- (ALAssetsLibrary *)assetsLibrary
{
    if (!_assetsLibrary) {
        _assetsLibrary = [[ALAssetsLibrary alloc] init];
    }
    
    return _assetsLibrary;
}

- (NSMutableArray *)assetGroups
{
    if (!_assetGroups) {
        _assetGroups = [NSMutableArray array];
    }
    
    return _assetGroups;
}

#pragma mark - api

#pragma mark - model event
#pragma mark 1 notification
#pragma mark 2 KVO
#pragma mark 3 OtherEvent

#pragma mark - view event
#pragma mark 1 target-action
- (void)onCancel:(id)sender
{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark 2 delegate dataSource protocol
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.assetGroups.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.config.thumbnailHeight + 12;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    //TODO: push to picker view
    __weak __typeof(self) ws = self;
    GLImageSelectViewController *vc =
    [[GLImageSelectViewController alloc] initWithAssetGroups:self.assetGroups[indexPath.row]
                                                      config:self.config
                                          didSelectedHandler:^(NSArray *objs, SelectAssetType type) {
                                              
                                              //TODO: 判断类别 图片or视频
                                              if (type == SelectAssetTypeImage) {
                                                  [ws.delegate imageAssetGroupViewController:ws didPickWithImages:objs];
                                              }else if (type == SelectAssetTypeVideo) {
                                                  [ws.delegate imageAssetGroupViewController:ws didPickWithVideos:objs];
                                              }
                                              
                                          }];
    
    [self.navigationController pushViewController:vc animated:YES];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *kGLImageAssetGroupViewCell = @"kGLImageAssetGroupViewCell";
    
    GLImageAssetGroupViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kGLImageAssetGroupViewCell];
    
    if (!cell) {
        cell = [[GLImageAssetGroupViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:kGLImageAssetGroupViewCell];
    }
    
    [cell bind:self.assetGroups[indexPath.row] withThumbnailHeight:self.config.thumbnailHeight];
    
    return cell;
}

@end
