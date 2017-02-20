# GLImagePickerDemo
-

一个类似微信选择照片的控件, 可以通过修改配置类自定义布局和界面风格.

## 配置相关
### GLImagePickerConfig
GLImagePickerConfig 配置基本属性

```objc

typedef NS_ENUM(NSUInteger, GLAssetFilterType) {
    GLAssetFilterTypeAllPhotos,///<图片
    GLAssetFilterTypeAllVideos,///<视频
    GLAssetFilterTypeAllAssets,///<所有
};

@interface GLImagePickerConfig : NSObject

@property (nonatomic, assign) NSUInteger minNumberOfSelection;///<最少选择几张照片
@property (nonatomic, assign) NSUInteger maxNumberofSelection;///<最多选择几张照片

@property (nonatomic, assign) GLAssetFilterType assetFilterType;///<资源的类型

@property (nonatomic, assign) CGFloat thumbnailWidth;///<缩略图宽度
@property (nonatomic, assign) CGFloat thumbnailHeight;///<缩略图高度

@property (nonatomic, assign) NSUInteger assetNumberOfColumn;///<每列的asset数量 Default:4
@property (nonatomic, assign) UIEdgeInsets marginForSelectCell;

+ (instancetype)defaultConfig;

```

### GLImageSelectViewFlowLayout
GLImageSelectViewFlowLayout 实现布局


![demo](https://github.com/GrayLand119/GLImagePickerDemo/blob/master/GLImagePicker.gif)

