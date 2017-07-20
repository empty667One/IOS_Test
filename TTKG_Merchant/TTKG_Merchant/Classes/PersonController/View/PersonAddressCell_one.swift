//
//  PersonAddressCell_one.swift
//  TTKG_Merchant
//
//  Created by macmini on 16/8/18.
//  Copyright © 2016年 yd. All rights reserved.
//

import UIKit

protocol PersonAddressCell_oneDelegate {
    func tickBtnStatusChanged(keyid:Int, addressid:Int)
    func deleteBtnProcess(keyid:Int, addressid:Int)
    func editBtnClickPushVC(keyid:Int, addressid: Int, name: String, phone: String, address: String, country: String, code: String, sparetel: String)
}



class PersonAddressCell_one: UITableViewCell {

    var delegate : PersonAddressCell_oneDelegate?
    
    let tickBtn = UIButton()
    let label = UILabel()
    let deleteBtn = UIButton()
    let editBtn = UIButton()
    
    
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
        
        tickBtn.addTarget(self, action: #selector(PersonAddressCell_one.tickBtnClick(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        tickBtn.contentMode = .ScaleAspectFit
        self.addSubview(tickBtn)
        tickBtn.snp_makeConstraints { (make) in
            make.left.equalTo(0).offset(15)
            make.width.equalTo(30)
            make.height.equalTo(30)
            make.top.equalTo(0).offset(10)
        }
        
        label.text = "设置为默认地址"
        label.font = UIFont.systemFontOfSize(14)
        self.addSubview(label)
        label.snp_makeConstraints { (make) in
            make.left.equalTo(tickBtn.snp_right).offset(10)
            make.centerY.equalTo(tickBtn.snp_centerY).offset(0)
        }
        
        
        
        deleteBtn.setImage(UIImage(named: "删除"), forState: UIControlState.Normal)
        deleteBtn.setTitle("删除", forState: UIControlState.Normal)
        deleteBtn.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        deleteBtn.titleLabel?.font = UIFont.systemFontOfSize(14)
        deleteBtn.contentMode = .ScaleAspectFit
        deleteBtn.addTarget(self, action: #selector(PersonAddressCell_one.deleteBtnClick), forControlEvents: UIControlEvents.TouchUpInside)
        self.addSubview(deleteBtn)
        deleteBtn.snp_makeConstraints { (make) in
            make.right.equalTo(0).offset(-15)
            make.centerY.equalTo(tickBtn.snp_centerY).offset(0)
        }
        
        
        
        
        editBtn.setImage(UIImage(named: "编辑"), forState: UIControlState.Normal)
        editBtn.setTitle("编辑", forState: UIControlState.Normal)
        editBtn.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        editBtn.titleLabel?.font = UIFont.systemFontOfSize(14)
        editBtn.contentMode = .ScaleAspectFit
        editBtn.addTarget(self, action: #selector(PersonAddressCell_one.editBtnClick), forControlEvents: UIControlEvents.TouchUpInside)
        self.addSubview(editBtn)
        editBtn.snp_makeConstraints { (make) in
            
            make.right.equalTo(deleteBtn.snp_left).offset(-10)
            
            make.centerY.equalTo(tickBtn.snp_centerY).offset(0)
        }

    }
    
    //改变默认地址
    func tickBtnClick(btn : UIButton) {
        
        self.delegate?.tickBtnStatusChanged(userInfo_Global.keyid, addressid:addressid)
        
    }
    //删除按钮
    func deleteBtnClick() {
        
        self.delegate?.deleteBtnProcess(userInfo_Global.keyid, addressid:addressid)
    }
    
    //编辑按钮
    func editBtnClick() {
        
        self.delegate?.editBtnClickPushVC(userInfo_Global.keyid, addressid: addressid, name: name.text!, phone: tel.text!, address: address.text!, country: country.text!, code: code, sparetel: sparetel)
        
        
    }

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
