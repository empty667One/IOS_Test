//
//  MyStore.h
//  TTKG_Merchant
//
//  Created by 123 on 17/7/5.
//  Copyright © 2017年 yd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyStoreModel.h"
@interface MyStore : UIViewController

@property(nonatomic,strong) NSString  *orderno;
@property(nonatomic,strong) NSString  *creattime;
@property(nonatomic,strong) NSString  *producttitle;
@property(nonatomic,strong) NSString  *detail_remark;
@property(nonatomic,strong) NSString  *number;
@property(nonatomic,strong) NSString  *price;
@property(nonatomic,strong) NSString  *totalprice;

@end
