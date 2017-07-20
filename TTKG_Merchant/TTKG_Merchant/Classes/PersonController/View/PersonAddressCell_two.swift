//
//  PersonAddressCell_two.swift
//  TTKG_Merchant
//
//  Created by macmini on 16/8/18.
//  Copyright © 2016年 yd. All rights reserved.
//

import UIKit

protocol PersonAddressCell_twoDelegate {
   
    func editBtnClickPushVC(keyid:Int, addressid: Int, name: String, phone: String, address: String, country: String, code: String, sparetel: String)
}


class PersonAddressCell_two: UITableViewCell {

    var delegate : PersonAddressCell_twoDelegate?
    
    let editBtn = UIButton()
    
    let status = UILabel()
    
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
        
        
        
        status.text = "待审核"
        status.font = UIFont.systemFontOfSize(14)
        self.addSubview(status)
        status.snp_makeConstraints { (make) in
            make.left.equalTo(0).offset(15)
            make.top.equalTo(0).offset(15)
        }

        
        editBtn.setImage(UIImage(named: "编辑"), forState: UIControlState.Normal)
        editBtn.setTitle("编辑", forState: UIControlState.Normal)
        editBtn.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        editBtn.titleLabel?.font = UIFont.systemFontOfSize(14)
        editBtn.contentMode = .ScaleAspectFit
        editBtn.addTarget(self, action: #selector(PersonAddressCell_two.editBtnClick), forControlEvents: UIControlEvents.TouchUpInside)
        self.addSubview(editBtn)
        editBtn.snp_makeConstraints { (make) in
            
            make.right.equalTo(0).offset(-15)
            
            make.centerY.equalTo(status.snp_centerY).offset(0)
        }

    
        
    }
    
    //编辑按钮
    func editBtnClick() {
        
        self.delegate?.editBtnClickPushVC(userInfo_Global.keyid, addressid: addressid, name: name.text!, phone: tel.text!, address: address.text!, country: country.text!, code: code, sparetel: sparetel)
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
