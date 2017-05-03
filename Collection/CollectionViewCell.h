//
//  CollectionViewCell.h
//  Collection
//
//  Created by tongle on 2017/5/2.
//  Copyright © 2017年 tongle. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CollectionViewCell : UICollectionViewCell

@property (nonatomic,strong)UILabel * titleLabel;
@property (nonatomic,strong)UIButton * deleteBtn;
@property (nonatomic,assign) BOOL edit;

@end
