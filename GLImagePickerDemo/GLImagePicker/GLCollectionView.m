//
//  Created by GrayLand on 16/6/12.
//  Copyright © 2016年 GrayLand. All rights reserved.
//

#import "GLCollectionView.h"

@interface GLCollectionView()

@end

@implementation GLCollectionView

// custom code

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewLayoutAttributes* attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    if (indexPath.row == 2) {
        attributes.size = CGSizeMake(10, 10);
    }
    return attributes;
}
@end
