//
//  ViewController.m
//  XLKTuPianCardDemo
//
//  Created by Mac on 16/7/25.
//  Copyright © 2016年 Lukas. All rights reserved.
//

#import "ViewController.h"
#import "XLKTuPianCardLayout.h"

@interface ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

/**
 * collectionView;
 */
@property(nonatomic,strong)UICollectionView * cardView;

/**
 * 存放img名字的数组;
 */
@property(nonatomic,strong)NSMutableArray * imgArr;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self getData];
    [self createCardView];
}

- (void)getData
{
    _imgArr = [[NSMutableArray alloc]init];
    
    for (int i = 0 ;i < 8; i++)
    {
        NSString * str = [NSString stringWithFormat:@"%d.jpg",i+1];
        [_imgArr addObject:str];
    }
}
//创建collectionview
- (void)createCardView
{
    XLKTuPianCardLayout * flowLayout = [[XLKTuPianCardLayout alloc]init];
    _cardView = ({
        UICollectionView * collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) collectionViewLayout:flowLayout];
//        collectionView.backgroundColor = [UIColor orangeColor];
        collectionView.delegate   = self;
        collectionView.dataSource = self;
        
        //提前注册
        [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
        
        collectionView;
    });
    [self.view addSubview:_cardView];
}

#pragma mark -- collectionView DataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _imgArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    
    //先清空subviews 防止重影 有更好的方法一定要告诉我
    for (UIView * view in cell.contentView.subviews)
    {
        [view removeFromSuperview];
    }
    
    UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, cell.contentView.frame.size.width, cell.contentView.frame.size.height)];
    imageView.layer.shadowColor = [UIColor whiteColor].CGColor;
    imageView.layer.shadowOffset = CGSizeMake(0.5, 0.5);
    imageView.layer.shadowRadius = 5;
    imageView.layer.shadowOpacity = 0.8;
    imageView.image = [UIImage imageNamed:_imgArr[indexPath.row]];
    
    //一定要添加到cell.contentView上
    [cell.contentView addSubview:imageView];
    
    return cell;
}

    //点击事件
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"%ld",indexPath.row);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
