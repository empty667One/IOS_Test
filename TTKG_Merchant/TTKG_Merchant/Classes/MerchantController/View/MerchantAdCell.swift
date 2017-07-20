//
//  MerchantAdCell.swift
//  TTKG_Merchant
//
//  Created by yd on 16/8/11.
//  Copyright © 2016年 yd. All rights reserved.
//

import UIKit
import SnapKit

class MerchantAdCell: UITableViewCell {

    var adImageView = UIImageView()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.addSubview(adImageView)
        adImageView.snp_makeConstraints { (make) in
            make.left.right.top.bottom.equalTo(0)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
