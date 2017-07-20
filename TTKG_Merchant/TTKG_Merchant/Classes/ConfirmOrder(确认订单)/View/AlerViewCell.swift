//
//  AlerViewCell.swift
//  TTKG_Merchant
//
//  Created by yd on 16/8/17.
//  Copyright © 2016年 yd. All rights reserved.
//

import Foundation
import SnapKit
/// cell
class AlertViewCell: UITableViewCell {
    var productName = UILabel()
    
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.addSubview(productName)
        
        productName.snp_makeConstraints { (make) in
            make.left.top.equalTo(0).offset(2)
            make.bottom.right.equalTo(-2)
        }
        productName.font = UIFont.systemFontOfSize(12)
        productName.numberOfLines = 0
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}