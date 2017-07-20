//
//  ConfirmHeaderView.swift
//  ttkg_customer
//
//  Created by yd on 16/7/11.
//  Copyright © 2016年 iosnull. All rights reserved.
//

import UIKit
import SnapKit

class ConfirmHeaderView: UIView {
    
    var shopName = UILabel()//商家名字
    var shopImage = UIImageView()//商家图片
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.whiteColor()
        self.addSubview(shopImage)
        self.addSubview(shopName)
        shopImage.snp_makeConstraints { (make) in
            make.left.equalTo(20)
            make.top.equalTo(0).offset(7)
            make.width.equalTo(30)
            make.bottom.equalTo(0).offset(-7)
        }
        shopImage.image = UIImage(named: "房子")
        shopName.snp_makeConstraints { (make) in
            make.left.equalTo(shopImage.snp_right).offset(5)
            make.right.equalTo(0)
            make.top.equalTo(0).offset(10)
            make.bottom.equalTo(0).offset(-10)
        }
        shopName.text = "xxxx"
        shopName.font = UIFont.systemFontOfSize(14)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
