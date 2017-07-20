//
//  MyStore.m
//  TTKG_Merchant
//
//  Created by 123 on 17/7/5.
//  Copyright © 2017年 yd. All rights reserved.
//

#import "MyStore.h"
#import "THDatePickerView.h"



#define Hight [UIScreen mainScreen].bounds.size.height
#define Width [UIScreen mainScreen].bounds.size.width
#define Start_X 10.0f           // 第一个按钮的X坐标
#define Width_Space 10.0f        // 2个按钮之间的横间距
#define Height_Space 10.0f      // 竖间距
#define Button_Height 25.0f    // 高
@interface MyStore ()<THDatePickerViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic,strong)  UITableView    *mainTableView;
@property (nonatomic,strong)  UILabel        *showLabel;
@property (weak, nonatomic)   THDatePickerView *dateView;
@property (strong, nonatomic) UIButton         *Showbtn;
@property (nonatomic,strong)UICollectionView   *mainCollectionView;
@property (nonatomic,strong)NSMutableArray     *ordernoAry;
@property (nonatomic,strong)NSMutableArray     *productAry;


@end

@implementation MyStore

- (void)viewWillAppear:(BOOL)animated
{
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:17/255.0 green:182/255.0 blue:244/255.0 alpha:1];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationItem.title = @"我的店铺";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.mainTableView];
    [self.view addSubview:self.mainCollectionView];
    
    
    //订单数组
    self.ordernoAry = [NSMutableArray array];
    [self.ordernoAry addObject:self.orderno];
    NSLog(@"=========%@",self.ordernoAry);
    
    //商品数组
    self.productAry = [NSMutableArray array];
    [self.productAry addObject:self.producttitle];

    
}

#pragma mark - UICollectionViewDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    
    NSInteger n = self.ordernoAry.count ;
    
    return n;
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSInteger n = self.productAry.count;
    
       return n;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(Width, 55.0f);
}



- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableview = nil;

    //设置分区头
   if (kind == UICollectionElementKindSectionHeader)
     {
    
       UICollectionReusableView *sectionHeaderView = [collectionView dequeueReusableSupplementaryViewOfKind: UICollectionElementKindSectionHeader
                                                                                     withReuseIdentifier:@"ProDetailsSectionHeaderView"
                                                                                            forIndexPath:indexPath];
       //移除叠加
         for (UIView *subView in sectionHeaderView.subviews)
         {
             [subView removeFromSuperview];
         }


        UIView *HeadView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Width , 55)];
        HeadView.backgroundColor = [UIColor lightGrayColor];
       [sectionHeaderView addSubview:HeadView];
    
      //订单编号
        UILabel *orderLabel = [[UILabel alloc] initWithFrame:CGRectMake(6, 5, Width/2+5, 20)];
        orderLabel.textAlignment = NSTextAlignmentLeft;
        orderLabel.font = [UIFont systemFontOfSize:12];
        orderLabel.text = [NSString stringWithFormat:@"订单编号:%@",self.ordernoAry[indexPath.section]];
        [HeadView addSubview:orderLabel];
    
    //订单时间
        UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(Width/2+10, 5, Width/2 - 10, 20)];
        timeLabel.textAlignment = NSTextAlignmentLeft;
         timeLabel.text = [NSString stringWithFormat:@"%@",self.creattime];
        timeLabel.font = [UIFont systemFontOfSize:12];
        [HeadView addSubview:timeLabel];
    
         //标题label
         UILabel *firstTitleLabel = [[UILabel alloc] init];
         firstTitleLabel.frame = CGRectMake(6,30,150,20);
         firstTitleLabel.text = @"产品";
         firstTitleLabel.textAlignment = NSTextAlignmentLeft;
         firstTitleLabel.font= [UIFont systemFontOfSize:10];
         [HeadView addSubview:firstTitleLabel];
         
         
         NSArray *titleAry = @[@"数量",@"单位",@"金额"];
         for (int i = 0 ; i < 3; i++) {
             NSInteger index = i % 3;
             
             NSInteger width = (Width - 185)/3;
             
             // 设置label
             UILabel *secondTitleLabel = [[UILabel alloc] init];
             secondTitleLabel.frame = CGRectMake(index * (width + Width_Space) + 155, 30, width, 20);
             secondTitleLabel.text = [titleAry objectAtIndex:i];
             secondTitleLabel.textAlignment = NSTextAlignmentCenter;
             secondTitleLabel.font= [UIFont systemFontOfSize:12];
             [HeadView addSubview:secondTitleLabel];

                 

         }
    
        reusableview = sectionHeaderView;

    
        
    }
    
    if (kind == UICollectionElementKindSectionFooter)
    {
        UICollectionReusableView *sectionFooterView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter
                                                                                         withReuseIdentifier:@"ProDetailsSectionFooterView"
                                                                                                forIndexPath:indexPath];
        for (UIView *subView in sectionFooterView.subviews)
        {
            [subView removeFromSuperview];
        }

        UILabel *priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, Width, 30)];
        priceLabel.text = [NSString stringWithFormat:@"合计:%@",self.totalprice];
        priceLabel.textAlignment = NSTextAlignmentRight;
        priceLabel.font = [UIFont systemFontOfSize:12];
        [sectionFooterView addSubview:priceLabel];
        
        reusableview = sectionFooterView;
        
    }
    return reusableview;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{

    return CGSizeMake(Width, 30.0f);

}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath;
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SKUCollectionViewCell"
    
                                                                           forIndexPath:indexPath];
    
        for (UIView *subView in cell.contentView.subviews)
        {
            [subView removeFromSuperview];
        }

        //标题label
        UILabel *productTitleLabel = [[UILabel alloc] init];
        productTitleLabel.frame = CGRectMake(6,0,150,20);
        productTitleLabel.text = [NSString stringWithFormat:@"%@",self.producttitle];
        productTitleLabel.textAlignment = NSTextAlignmentLeft;
        productTitleLabel.font= [UIFont systemFontOfSize:10];
       [cell addSubview:productTitleLabel];

        for (int i = 0 ; i < 3; i++) {
        NSInteger index = i % 3;
        
        NSInteger width = (Width - 185)/3;
        
        // 设置label
        UILabel *goodsLabel = [[UILabel alloc] init];
        goodsLabel.frame = CGRectMake(index * (width + Width_Space) + 155, 0, width, 20);
        goodsLabel.text = [NSString stringWithFormat:@"%@",self.producttitle];
        goodsLabel.textAlignment = NSTextAlignmentCenter;
        goodsLabel.font= [UIFont systemFontOfSize:10];
            
        
        [cell addSubview:goodsLabel];
    }

    cell.backgroundColor = [UIColor clearColor];

    return cell;
    
}

#pragma mark UICollectionViewDelegateFlowLayout 调整单元格的size
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    CGSize itemSize = CGSizeMake(Width, 20);
    
    return itemSize;
}



#pragma mark - Getter
- (UICollectionView *)mainCollectionView
{
        if (!_mainCollectionView)
        {
            //层声明实列化
            UICollectionViewFlowLayout *SKUFlowLayout = [[UICollectionViewFlowLayout alloc] init];
            SKUFlowLayout.minimumLineSpacing        = 1;//设置列的最小间距
            SKUFlowLayout.minimumInteritemSpacing   = 1;//设置最小行间距
//            SKUFlowLayout.itemSize = CGSizeMake(40, 40);
            SKUFlowLayout.scrollDirection           = UICollectionViewScrollDirectionVertical;
//            SKUFlowLayout.sectionInset              = UIEdgeInsetsMake(0, 25, 0, 25);//设置布局内边距
            
            //SKU View
            _mainCollectionView =  [[UICollectionView alloc] initWithFrame:CGRectMake(0,0, Width, Hight) collectionViewLayout:SKUFlowLayout];
            
            [_mainCollectionView registerClass:[UICollectionViewCell class]
                          forCellWithReuseIdentifier:@"SKUCollectionViewCell"];
            
            [_mainCollectionView registerClass:[UICollectionReusableView class]
                          forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                                 withReuseIdentifier:@"ProDetailsSectionHeaderView"];
            
            [_mainCollectionView registerClass:[UICollectionReusableView class]
                          forSupplementaryViewOfKind:UICollectionElementKindSectionFooter
                                 withReuseIdentifier:@"ProDetailsSectionFooterView"];
            
            _mainCollectionView.backgroundColor = [UIColor whiteColor];
            _mainCollectionView.dataSource      = self;
            _mainCollectionView.delegate        = self;
            _mainCollectionView.scrollEnabled   = YES;
            _mainCollectionView.showsVerticalScrollIndicator = YES;
            
            //当数据不多，collectionView.contentSize小于collectionView.frame.size的时候，UICollectionView是不会滚动的
            _mainCollectionView.alwaysBounceVertical = YES;
            
        }
        return _mainCollectionView;
    }


#pragma mark -----delegate
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//    return 5;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//    return 3;
//
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
//{
//    return 0.01f;
//}
//
////行高
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    float cellHeight = 80.0f;
//    
//       return cellHeight;
//}
//
//
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    return 60.0f;
//}
//
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    UIView *sectionHeadView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Width , 55)];
//    sectionHeadView.backgroundColor = [UIColor lightGrayColor];
//    
//    
//    UILabel *orderLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, Width, 20)];
//    orderLabel.text = @"订单编号:";
//    orderLabel.textAlignment = NSTextAlignmentLeft;
//    orderLabel.font = [UIFont systemFontOfSize:12];
//    [sectionHeadView addSubview:orderLabel];
//    
//
//    UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 30, Width, 20)];
//    timeLabel.text = @"订单时间:";
//    timeLabel.textAlignment = NSTextAlignmentLeft;
//    timeLabel.font = [UIFont systemFontOfSize:12];
//    [sectionHeadView addSubview:timeLabel];
//    
//    return sectionHeadView;
//
//}
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    static NSString *identifier = @"GoodsTableViewCell";
//    
//
//    GoodsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
//    
//    if (cell == nil)
//    {
//        cell = [[GoodsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
//                                      reuseIdentifier:identifier];
//    }
//    
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        
//    return cell;
//    
//  }
//
//
//- (UITableView *)mainTableView
//{
//    if (!_mainTableView)
//    {
//        
//        _mainTableView = [[UITableView alloc]
//                          initWithFrame:CGRectMake(0, 0, Width, Hight)
//                          style:UITableViewStyleGrouped];
//        _mainTableView.dataSource       = self;
//        _mainTableView.delegate         = self;
//        _mainTableView.separatorStyle   = UITableViewCellSeparatorStyleNone;
//        _mainTableView.scrollEnabled = YES;
//
//       
//    }

//    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Width, 400)];
//    headView.backgroundColor = [UIColor redColor];
//    _mainTableView.tableHeaderView = headView;
    
    
    //----------------------------时间选择器-----------------------
//    THDatePickerView *dateView = [[THDatePickerView alloc] initWithFrame:CGRectMake(0, 0, Width, 300)];
//    dateView.delegate = self;
//    dateView.title = @"请选择时间";
//    [headView addSubview:dateView];
//    
//    
//    //选择器上添加的按钮
//    UIButton *clickBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, Width, 300)];
//    [clickBtn addTarget:self action:@selector(timerBrnClick:) forControlEvents:UIControlEventTouchUpInside];
//    [dateView addSubview:clickBtn];
//    self.dateView = dateView;
//    
//    //显示
//    if (!_showLabel)
//    {
//        _showLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 310, Width, 40)];
//        _showLabel.text = @"显示时间";
//        _showLabel.font = [UIFont systemFontOfSize:12];
//        _showLabel.textAlignment = NSTextAlignmentCenter;
//        
//    }
//    
//    [headView addSubview:self.showLabel];
//
//    //展示时间
//    self.Showbtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 360, Width, 40)];
//    self.Showbtn.backgroundColor = [UIColor blackColor];
//    self.Showbtn.hidden = YES;
//    self.Showbtn.alpha = 0.3;
//    [headView addSubview:self.Showbtn];
//    //----------时间选择器------------------

//    return _mainTableView;
//}

//#pragma mark - 点击事件
//- (void)timerBrnClick:(UIButton *)btn
//{
//    self.Showbtn.hidden = NO;
//    [UIView animateWithDuration:0.3 animations:^{
//        self.dateView.frame = CGRectMake(0, self.view.frame.size.height - 300, self.view.frame.size.width, 300);
//        [self.dateView show];
//    }];
//}


#pragma mark - THDatePickerViewDelegate
/**
 保存按钮代理方法
 
 @param timer 选择的数据
 */
- (void)datePickerViewSaveBtnClickDelegate:(NSString *)timer {
    NSLog(@"保存点击");
    self.showLabel.text = timer;
    
    self.Showbtn.hidden = YES;
    [UIView animateWithDuration:0.3 animations:^{
        self.dateView.frame = CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, 300);
    }];
}

/**
 取消按钮代理方法
 */
- (void)datePickerViewCancelBtnClickDelegate {
    NSLog(@"取消点击");
    self.Showbtn.hidden = YES;
    [UIView animateWithDuration:0.3 animations:^{
        self.dateView.frame = CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, 300);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
