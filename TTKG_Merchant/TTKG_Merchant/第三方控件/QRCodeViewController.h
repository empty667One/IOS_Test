//
//  QRCodeViewController.h
//  3.18QRCode
//
//  Created by bzby on 16/3/18.
//  Copyright © 2016年 bzby. All rights reserved.
//

#import <UIKit/UIKit.h>
#define IS_VAILABLE_IOS8  ([[[UIDevice currentDevice] systemVersion] intValue] >= 8)
@interface QRCodeViewController : UIViewController
typedef void (^QRCodeDidReceiveBlock)(NSString *result);
@property (nonatomic, copy, readonly) QRCodeDidReceiveBlock didReceiveBlock;
- (void)setDidReceiveBlock:(QRCodeDidReceiveBlock)didReceiveBlock;
@end
