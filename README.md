#### Collection

## // 注册cell 和 header

    [self.collectionView registerNib:[UINib nibWithNibName:@"CollectionViewCell" bundle:nil] forCellWithReuseIdentifier:identifier];

    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerId];
    
## // 编辑状态下点击是移动，并且马上保存

    if (indexPath.section == 0) {
            id  object = [self.oneArray objectAtIndex:indexPath.row];
            [self.oneArray removeObjectAtIndex:indexPath.row];
            [self.twoArray addObject:object];
            [self.collectionView reloadData];
        }else{
            id object = [self.twoArray objectAtIndex:indexPath.row];
            [self.twoArray removeObjectAtIndex:indexPath.row];
            [self.oneArray addObject:object];
            [self.collectionView reloadData];
        }
        [[NSUserDefaults standardUserDefaults]setObject:self.oneArray forKey:@"one"];
        [[NSUserDefaults standardUserDefaults]setObject:self.twoArray forKey:@"two"];
        [[NSUserDefaults standardUserDefaults]synchronize];
    
## // 非编辑状态下点击是跳转，并把对象传过去

     TouchCellViewController * viewController = [[TouchCellViewController alloc]init];
     
        [self.navigationController pushViewController:viewController animated:YES];
        
        if (indexPath.section == 0) {
            viewController.titleShow = [self.oneArray objectAtIndex:indexPath.row];
        }else if (indexPath.section == 1){
            viewController.titleShow = [self.twoArray objectAtIndex:indexPath.row];
        }

## // 删除时找到对应cell，刷新界面并保存
    CollectionViewCell * cell = (CollectionViewCell *)[[sender superview] superview];
    
    NSIndexPath * indexpath = [self.collectionView indexPathForCell:cell];
    
    if (indexpath.section ==0) {
        [self.oneArray removeObjectAtIndex:indexpath.row];
    }else{
        [self.twoArray removeObjectAtIndex:indexpath.row];
    }
    [self.collectionView reloadData];
    [[NSUserDefaults standardUserDefaults]setObject:self.oneArray forKey:@"one"];
    [[NSUserDefaults standardUserDefaults]setObject:self.twoArray forKey:@"two"];
    [[NSUserDefaults standardUserDefaults]synchronize];












