//
//  AlertViewHeader.swift
//  TTKG_Merchant
//
//  Created by yd on 16/8/17.
//  Copyright © 2016年 yd. All rights reserved.
//

import Foundation
import SnapKit
/// header
class AlertViewHeader: UIView {
    var shopName = UILabel()
//    var  detailLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(shopName)
//        self.addSubview(detailLabel)
        self.backgroundColor = UIColor.orangeColor()
        shopName.snp_makeConstraints { (make) in
            make.left.equalTo(0).offset(2)
            make.right.equalTo(0)
            make.top.equalTo(0).offset(2)
            make.bottom.equalTo(0)
        }
//        detailLabel.snp_makeConstraints { (make) in
//            make.left.equalTo(0).offset(40)
//            make.right.equalTo(0)
//            make.top.equalTo(shopName.snp_bottom).offset(1)
//            make.bottom.equalTo(0).offset(-2)
//        }
        
        shopName.font = UIFont.systemFontOfSize(13)
        shopName.numberOfLines = 0
//        detailLabel.font = UIFont.systemFontOfSize(13)
//        detailLabel.numberOfLines = 0
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}