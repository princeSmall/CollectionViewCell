//
//  CollectionViewCell.m
//  Collection
//
//  Created by tongle on 2017/5/2.
//  Copyright © 2017年 tongle. All rights reserved.
//

#import "CollectionViewCell.h"

@implementation CollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.titleLabel = [[UILabel alloc]initWithFrame:self.contentView.frame];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.textColor = [UIColor blackColor];
    self.titleLabel.font = [UIFont fontWithName:@"Arial" size:14];
    [self.contentView addSubview:self.titleLabel];
    
    self.deleteBtn = [[UIButton alloc]initWithFrame:CGRectMake(self.contentView.frame.size.width-10, 0, 10, 10)];
    [self.deleteBtn setImage:[UIImage imageNamed:@"fail"] forState:UIControlStateNormal];
    [self.contentView addSubview:self.deleteBtn];
    
    self.edit = NO;
    self.deleteBtn.hidden = YES;
}

@end
