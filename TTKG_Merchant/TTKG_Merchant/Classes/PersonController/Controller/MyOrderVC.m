//
//  MyOrderVC.m
//  TTKG_Merchant
//
//  Created by 123 on 17/7/8.
//  Copyright © 2017年 yd. All rights reserved.
//

#import "MyOrderVC.h"
#import "MyStoreModel.h"
#import "MyStore.h"
#import "TTKG_Merchant-Swift.h"
#define Hight [UIScreen mainScreen].bounds.size.height
#define Width [UIScreen mainScreen].bounds.size.width

@interface MyOrderVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *mainTableView;

@end

@implementation MyOrderVC

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
    [self.mainTableView reloadData];
    
}

#pragma mark  UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.orderAry.count;

}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Width, 30)];
    headView.backgroundColor = [UIColor blackColor];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, Width, 30)];
    titleLabel.text = @"销售订单";
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = [UIFont systemFontOfSize:15];
    [headView addSubview:titleLabel];
    
    return headView;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"GoodsTableViewCell";

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];

    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:identifier];
        
    }
    
    cell.backgroundColor = [UIColor lightGrayColor];
    
    //取出数据放进模型里边
    MyStoreModel *model = self.orderAry[indexPath.row];
    
    //订单编号
    UILabel *orderLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 7, Width/2+5, 30)];
    orderLabel.text = [NSString stringWithFormat:@"订单编号:%@",model.orderno];
    orderLabel.textAlignment = NSTextAlignmentLeft;
    orderLabel.font = [UIFont systemFontOfSize:12];
    [cell addSubview:orderLabel];
    
    //订单时间
    UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(Width/2+10, 7, Width/2 - 10, 30)];
    timeLabel.text = @"订单时间:";
    timeLabel.text = [NSString stringWithFormat:@"订单时间:%@",model.creattime];
    timeLabel.textAlignment = NSTextAlignmentLeft;
    timeLabel.font = [UIFont systemFontOfSize:12];
    [cell addSubview:timeLabel];
    
    UILabel *bottomLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 40, Width, 1)];
    bottomLabel.backgroundColor = [UIColor whiteColor];
    [cell addSubview:bottomLabel];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    return cell;

  }

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyStoreModel *model = self.orderAry[indexPath.row];

    MyOrderList *orderVC = [[MyOrderList alloc] init];
    orderVC.orderno = model.orderno;
    orderVC.creatTime = model.creattime;
    orderVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:orderVC animated:NO];
    
}

#pragma mark ---Gteetr
- (UITableView *)mainTableView
{
    if (!_mainTableView)
    {

        _mainTableView = [[UITableView alloc]
                          initWithFrame:CGRectMake(0, 0, Width, Hight)
                          style:UITableViewStylePlain];
        _mainTableView.dataSource       = self;
        _mainTableView.delegate         = self;
        _mainTableView.separatorStyle   = UITableViewCellSeparatorStyleNone;
        _mainTableView.scrollEnabled = YES;


    }
    
        return _mainTableView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}


@end
