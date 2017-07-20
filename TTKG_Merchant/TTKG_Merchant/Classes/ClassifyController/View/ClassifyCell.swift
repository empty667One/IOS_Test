//
//  ClassifyCell.swift
//  TTKG_Merchant
//
//  Created by yd on 16/8/4.
//  Copyright © 2016年 yd. All rights reserved.
//

import UIKit
import SnapKit

class ClassifyCell: UITableViewCell {

    var nameLabel = UILabel()
    var selectLine = UIView()
    var bottomLine = UIView()
    
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor(red: 241/255, green: 241/255, blue: 241/255, alpha: 1.0)
        self.addSubview(nameLabel)
        self.addSubview(selectLine)
        self.addSubview(bottomLine)
        nameLabel.snp_makeConstraints { (make) in
            make.left.equalTo(0).offset(5)
            make.right.equalTo(0).offset(-5)
            make.top.equalTo(0).offset(5)
            make.bottom.equalTo(0).offset(-5)
        }
        nameLabel.font = UIFont.systemFontOfSize(14)
        nameLabel.textAlignment = NSTextAlignment.Center
        nameLabel.textColor = UIColor.blackColor()
        selectLine.snp_makeConstraints { (make) in
            make.top.bottom.equalTo(0)
            make.left.equalTo(0).offset(1)
            make.width.equalTo(2)
        }
        selectLine.backgroundColor = UIColor(red: 238/255, green: 26/255, blue: 40/255, alpha: 1.0)
        
        bottomLine.snp_makeConstraints { (make) in
            make.left.right.bottom.equalTo(0)
            make.height.equalTo(1)
            
        }
        
        bottomLine.backgroundColor = UIColor(red: 223/255, green: 223/255, blue: 223/255, alpha: 1.0)
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
