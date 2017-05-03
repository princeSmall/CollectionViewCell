//
//  ViewController.m
//  Collection
//
//  Created by tongle on 2017/5/2.
//  Copyright © 2017年 tongle. All rights reserved.
//

#import "ViewController.h"
#import "CollectionViewCell.h"
#import "SCLAlertView.h"
#import "TouchCellViewController.h"


@interface ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UIAlertViewDelegate>
@property (nonatomic,strong) UICollectionView * collectionView;
@property (nonatomic,strong)NSMutableArray * oneArray;
@property (nonatomic,strong)NSMutableArray * twoArray;
@property (nonatomic,strong)UIButton * editBtn;
@property (nonatomic,strong)UILabel * titleLab;
@property (nonatomic,strong)CollectionViewCell * collectionCell;


@end
NSString * identifier = @"cell";
static NSString *const headerId = @"headerId";

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"目录";
    UIBarButtonItem * rightItem = [[UIBarButtonItem alloc]initWithTitle:@"新增加" style:UIBarButtonItemStylePlain target:self action:@selector(add)];
    self.navigationItem.rightBarButtonItem = rightItem;
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake(50, 50);
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) collectionViewLayout:layout];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerNib:[UINib nibWithNibName:@"CollectionViewCell" bundle:nil] forCellWithReuseIdentifier:identifier];
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerId];
    
    if ([[NSUserDefaults standardUserDefaults]objectForKey:@"one"] == nil) {
        self.oneArray = [NSMutableArray arrayWithObjects:@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19",nil];
    }else{
        id array = [[NSUserDefaults standardUserDefaults]objectForKey:@"one"];
        [self.oneArray addObjectsFromArray:array];
    }
    if ( [[NSUserDefaults standardUserDefaults]objectForKey:@"two"] == nil) {
        self.twoArray = [NSMutableArray arrayWithObjects:@"a",@"b",@"c",@"d",@"e",@"f",@"g",@"h",@"i",@"j", nil];
    }else{
        id array = [[NSUserDefaults standardUserDefaults]objectForKey:@"two"];
        [self.twoArray addObjectsFromArray:array];
    }
    [self.view addSubview:self.collectionView];
    // Do any additional setup after loading the view, typically from a nib.
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}
-(void)add{
    SCLAlertView * alert = [[SCLAlertView alloc]init];
    [alert setHorizontalButtons:YES];
    SCLTextView * textField = [alert addTextField:@"Enter your name"];
    [alert addButton:@"确定" actionBlock:^(void) {
        NSLog(@"Text value: %@", textField.text);
        [self.twoArray addObject:textField.text];
        [self.collectionView reloadData];
        [[NSUserDefaults standardUserDefaults]setObject:self.twoArray forKey:@"two"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
    }];
    
    [alert showEdit:self title:nil subTitle:@"请输入名称" closeButtonTitle:@"取消" duration:0.0f];
}
-(NSMutableArray *)oneArray{
    if (_oneArray == nil) {
        _oneArray = [[NSMutableArray alloc]init];
    }
    return _oneArray;
}
-(NSMutableArray *)twoArray{
    if (_twoArray == nil) {
        _twoArray = [[NSMutableArray alloc]init];
    }
    return _twoArray;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (self.collectionCell.edit == YES) {
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
    }else{
        TouchCellViewController * viewController = [[TouchCellViewController alloc]init];
        [self.navigationController pushViewController:viewController animated:YES];
        if (indexPath.section == 0) {
            viewController.titleShow = [self.oneArray objectAtIndex:indexPath.row];
        }else if (indexPath.section == 1){
            viewController.titleShow = [self.twoArray objectAtIndex:indexPath.row];
        }

    }
    
    
    
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 2;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (section == 0) {
        return self.oneArray.count;
    }else
        return self.twoArray.count;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(self.view.frame.size.width, 40);
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *headerView = [self.collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:headerId forIndexPath:indexPath];
    headerView.backgroundColor = [UIColor darkGrayColor];
    
    // 防止复用
    [headerView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    _titleLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width - 50, 40)];
    _titleLab.textAlignment = NSTextAlignmentLeft;
    _titleLab.textColor = [UIColor whiteColor];
    [headerView addSubview:self.titleLab];
    
    if (indexPath.section == 0) {
        self.titleLab.text = @"已添加目录";
        _editBtn = [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width - 50, 0, 50, 40)];
        
        if (self.collectionCell.edit == NO) {
            [_editBtn setTitle:@"编辑" forState:UIControlStateNormal];
        }else{
           [self.editBtn setTitle:@"完成" forState:UIControlStateNormal];
        }
        [_editBtn addTarget:self action:@selector(edit) forControlEvents:UIControlEventTouchUpInside];
        [headerView addSubview:self.editBtn];
    }else{
        self.titleLab.text = @"待添加目录";
    }
    
    
    return headerView;
    
}
-(void)edit{
    for (CollectionViewCell * cell in self.collectionView.visibleCells) {
        if (cell.edit == NO) {
            cell.layer.masksToBounds = NO;
            cell.layer.shadowOpacity = 0.7f;
            cell.layer.shadowColor = [UIColor darkGrayColor].CGColor;
            cell.layer.shadowOffset = CGSizeMake(1.f, 1.f);
            cell.deleteBtn.hidden = NO;
            [self.editBtn setTitle:@"完成" forState:UIControlStateNormal];
            cell.edit = YES;
        }else{
            cell.edit = NO;
            cell.deleteBtn.hidden = YES;
            cell.layer.masksToBounds = YES;
            [self.editBtn setTitle:@"编辑" forState:UIControlStateNormal];
        }
    }
    
}
-(void)deleteCellButton:(id)sender{
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
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    cell.backgroundColor = [UIColor grayColor];
    [cell.deleteBtn addTarget:self action:@selector(deleteCellButton:) forControlEvents:UIControlEventTouchUpInside];
    if (indexPath.section == 0) {
        cell.titleLabel.text = self.oneArray[indexPath.row];
    }else{
        cell.titleLabel.text = self.twoArray[indexPath.row];
    }
    self.collectionCell = cell;
    
    return  cell;
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(5, 5, 5, 5);
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
