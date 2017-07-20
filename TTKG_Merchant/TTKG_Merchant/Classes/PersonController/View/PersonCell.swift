//
//  PersonCell.swift
//  TTKG_Merchant
//
//  Created by macmini on 16/8/12.
//  Copyright © 2016年 yd. All rights reserved.
//

import UIKit

class PersonCell: UITableViewCell {

    let label = UILabel()
    let img = UIImageView()
    
    let balance = UILabel()
    
    let lineLabel = UILabel()
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.addSubview(img)
        img.snp_makeConstraints { (make) in
            make.left.equalTo(0).offset(20)
            make.top.equalTo(0).offset(10)
            make.bottom.equalTo(0).offset(-10)
            make.width.equalTo(30)
        }
        
        
        self.addSubview(label)
        label.font = UIFont.systemFontOfSize(14)
        label.snp_makeConstraints { (make) in
            make.left.equalTo(img.snp_right).offset(20)
            make.centerY.equalTo(img.snp_centerY).offset(0)
            
        }
        
        self.addSubview(balance)
        balance.font = UIFont.systemFontOfSize(12)
        balance.textColor = UIColor.redColor()
//        balance.text = "余额￥"
        balance.snp_makeConstraints { (make) in
            make.right.equalTo(0).offset(-8)
            make.centerY.equalTo(img.snp_centerY).offset(0)
        }
        
        
        self.addSubview(lineLabel)
        lineLabel.backgroundColor = UIColor.lightGrayColor()
        lineLabel.snp_makeConstraints { (make) in
            make.left.equalTo(0).offset(0)
            make.top.equalTo(0).offset(49.5)
            make.bottom.equalTo(0).offset(0.5)
            make.width.equalTo(screenWith)
        }

        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
