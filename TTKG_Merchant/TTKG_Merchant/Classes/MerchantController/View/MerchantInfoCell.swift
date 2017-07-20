//
//  MerchantInfoCell.swift
//  TTKG_Merchant
//
//  Created by yd on 16/8/8.
//  Copyright © 2016年 yd. All rights reserved.
//

import UIKit
import SnapKit

class MerchantInfoCell: UITableViewCell {
    var infoLabel = UILabel()     //左侧标题
    var detailLabel = UILabel()   //详细信息
    var bottomLine = UIView()     //分割线
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.addSubview(infoLabel)
        self.addSubview(detailLabel)
        self.addSubview(bottomLine)
        
/**************************************************************/
        infoLabel.snp_makeConstraints { (make) in
            make.left.equalTo(0).offset(5)
            make.top.equalTo(0).offset(5)
            make.width.equalTo(64)
            make.height.equalTo(30)
        }
        infoLabel.textAlignment = NSTextAlignment.Center
        infoLabel.font = UIFont.systemFontOfSize(12)
        
/**************************************************************/
        detailLabel.snp_makeConstraints { (make) in
            make.left.equalTo(infoLabel.snp_right).offset(2)
            make.right.equalTo(0).offset(-2)
            make.top.equalTo(0).offset(2)
            make.bottom.equalTo(0)
        }
        detailLabel.numberOfLines = 0
        detailLabel.font = UIFont.systemFontOfSize(10)

/**************************************************************/
        bottomLine.snp_makeConstraints { (make) in
            make.left.right.bottom.equalTo(0)
            make.height.equalTo(1)
        }
        bottomLine.backgroundColor = UIColor.lightTextColor()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
