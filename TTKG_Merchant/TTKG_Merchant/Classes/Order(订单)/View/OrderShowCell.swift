//
//  OrderShowCell.swift
//  ttkg_customer
//
//  Created by iosnull on 16/7/5.
//  Copyright © 2016年 iosnull. All rights reserved.
//

import UIKit
import SnapKit

class OrderShowCell: UITableViewCell {
    
    private let name = UILabel()
    var nameStr:String?{
        didSet{
            guard nameStr != nil else{
                name.text = ""
                return
            }
            name.text = nameStr
        }
    }
    
    private let img = UIImageView()
    var imgStr:String?{
        didSet{
            guard imgStr != nil else{
                return
            }
            img.sd_setImageWithURL(NSURL(string: serverPicUrl + imgStr!)!)
        }
    }

    private let price = UILabel()
    var priceStr:String?{
        didSet{
            guard priceStr != nil else{
                price.text = ""
                return
            }
            price.text = "￥" + priceStr!
        }
    }
    
    private let sellCnt = UILabel()
    var sellCntStr:String?{
        didSet{
            guard sellCntStr != nil else{
                sellCnt.text = ""
                return
            }
            sellCnt.text = "x" + sellCntStr!
        }
    }
    
    private let seprateLine = UIView()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = UIColor(red: 246/255, green: 246/255, blue: 246/255, alpha: 1)
        
        let w = screenWith/4
        self.frame.size.width = screenWith
        self.frame.size.height = w + 2
        
        self.addSubview(sellCnt)
        sellCnt.font = UIFont.systemFontOfSize(16)
        sellCnt.textColor = UIColor(red: 250/255, green: 154/255, blue: 0, alpha: 1)
        self.addSubview(price)
        price.font = UIFont.systemFontOfSize(16)
        price.textColor = UIColor(red: 250/255, green: 154/255, blue: 0, alpha: 1)
        self.addSubview(img)
        self.addSubview(name)
        name.font = UIFont.systemFontOfSize(14)
        
        
        self.addSubview(seprateLine)
        seprateLine.backgroundColor = UIColor.whiteColor()
        seprateLine.snp_makeConstraints { (make) in
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.bottom.equalTo(self.snp_bottom)
            make.height.equalTo(2)
        }
        
        img.snp_makeConstraints { (make) in
            make.left.equalTo(self.snp_left).offset(3)
            make.top.equalTo(self.snp_top).offset(3)
            make.bottom.equalTo(self.snp_bottom).offset(-5)
            make.width.equalTo(w - 6)
        }
        
        name.snp_makeConstraints { (make) in
            make.left.equalTo(img.snp_right).offset(8)
            make.right.equalTo(0)
            make.top.equalTo(img.snp_top)
            make.height.equalTo(20)
        }
        
        price.snp_makeConstraints { (make) in
            make.left.equalTo(name.snp_left)
            make.bottom.equalTo(img.snp_bottom)
            make.width.equalTo(w)
            make.height.equalTo(30)
        }
        
        sellCnt.snp_makeConstraints { (make) in
            make.right.equalTo(self.snp_right).offset(-10)
            make.width.equalTo(w)
            make.bottom.equalTo(price.snp_bottom)
            make.height.equalTo(30)
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
