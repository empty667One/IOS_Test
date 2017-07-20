//
//  PersonAddressCell.swift
//  TTKG_Merchant
//
//  Created by macmini on 16/8/15.
//  Copyright © 2016年 yd. All rights reserved.
//

import UIKit



class PersonAddressCell: UITableViewCell {

    
    
    let name = UILabel()
    let tel = UILabel()
    let country_address = UILabel()
    let address = UILabel()
    let country = UILabel()
    var code = String()
    var sparetel = String()
    
    var addressid = Int()
   
    
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
   
        name.text = "测试"
        name.font = UIFont.systemFontOfSize(14)
        self.addSubview(name)
        name.snp_makeConstraints { (make) in
            make.left.equalTo(0).offset(15)
            make.top.equalTo(0).offset(15)
        }
        
        tel.text = "18582224582"
        tel.font = UIFont.systemFontOfSize(14)
        self.addSubview(tel)
        tel.snp_makeConstraints { (make) in
            make.right.equalTo(0).offset(-100)
            make.top.equalTo(0).offset(15)
        }
        
        country_address.text = "财智中心"
        country_address.font = UIFont.systemFontOfSize(14)
        country_address.numberOfLines = 0
        self.addSubview(country_address)
        country_address.snp_makeConstraints { (make) in
            make.left.equalTo(0).offset(15)
            make.top.equalTo(name.snp_bottom).offset(10)
            make.right.equalTo(0).offset(-20)
            make.bottom.equalTo(0).offset(-10)
        }

        

       

    }
    
        
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
