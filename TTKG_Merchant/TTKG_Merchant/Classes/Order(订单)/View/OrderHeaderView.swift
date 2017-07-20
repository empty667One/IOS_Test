//
//  OrderHeaderView.swift
//  ttkg_customer
//
//  Created by iosnull on 16/7/4.
//  Copyright © 2016年 iosnull. All rights reserved.
//

import UIKit
import SnapKit

class OrderHeaderView: UIView {

    //商店名称
    var shopName:String?{
        didSet{
            shopNameStr.text = shopName
        }
    }
    //订单号
    var orderNum:String?{
        didSet{
            guard orderNum != nil else{
                return
            }
            orderNumStr.text = "订单号:" + orderNum!
        }
    }
    
    //订单状态
    var orderState:String?{
        didSet{
            orderStateStr.text = orderState
        }
    }
    
    
    
    private var shopNameStr = UILabel()
    private var orderNumStr = UILabel()
    private var orderStateStr = UILabel()
    private var img = UIImageView()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.whiteColor()
        
        self.addSubview(shopNameStr)
        self.addSubview(orderNumStr)
        self.addSubview(orderStateStr)
        self.addSubview(img)
        
        self.frame = CGRect(x: 0, y: 0, width: screenWith, height: screenWith/8)
        
        //img.image = UIImage(named: "blackHouse")
        img.contentMode = UIViewContentMode.ScaleAspectFit
        img.snp_makeConstraints { (make) in
            make.left.equalTo(10)
            make.width.equalTo(20)
            make.top.equalTo(2)
            make.height.equalTo(20)
        }
        img.image = UIImage(named: "房子")
        img.contentMode = .ScaleAspectFit
        
        shopNameStr.font = UIFont.systemFontOfSize(13)
        shopNameStr.snp_makeConstraints { (make) in
            make.centerY.equalTo(img.snp_centerY)
            make.left.equalTo(img.snp_right).offset(2)
            make.right.equalTo(0).offset(-80)
            make.height.equalTo(14)
        }
        
        orderNumStr.font = UIFont.systemFontOfSize(9)
        orderNumStr.snp_makeConstraints { (make) in
            make.top.equalTo(img.snp_bottom)
            make.left.equalTo(img.snp_left)
            make.right.equalTo(shopNameStr.snp_right)
            make.height.equalTo(10)
        }
        
        orderStateStr.font = UIFont.systemFontOfSize(13)
        
        orderStateStr.snp_makeConstraints { (make) in
            make.right.equalTo(0).offset(-2)
            make.width.equalTo(110)
            make.centerY.equalTo(self.snp_centerY)
            make.height.equalTo(16)
        }
        orderStateStr.textAlignment = .Right
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
