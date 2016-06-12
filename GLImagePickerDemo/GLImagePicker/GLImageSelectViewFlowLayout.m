//
//  Created by GrayLand on 16/6/12.
//  Copyright © 2016年 GrayLand. All rights reserved.
//

#import "GLImageSelectViewFlowLayout.h"

@interface GLImageSelectViewFlowLayout()

@property (nonatomic, assign) NSInteger columnNumber;
@end
@implementation GLImageSelectViewFlowLayout

- (instancetype)initWithColumnNum:(NSInteger)columnNumber
{
    if (self = [super init]) {
        self.columnNumber            = columnNumber;
        self.minimumLineSpacing      = 1;
        self.minimumInteritemSpacing = 0;
        [self setScrollDirection:UICollectionViewScrollDirectionVertical];
    }
    
    return self;
}
// custom code

@end
