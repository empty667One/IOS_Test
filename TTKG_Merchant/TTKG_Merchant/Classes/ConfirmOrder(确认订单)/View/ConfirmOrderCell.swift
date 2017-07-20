//
//  ConfirmOrderCell.swift
//  ttkg_customer
//
//  Created by yd on 16/7/11.
//  Copyright © 2016年 iosnull. All rights reserved.
//

import UIKit
import SnapKit

class ConfirmOrderCell: UITableViewCell {

    var goodsImage = UIImageView()//商品图片
    var goodsName = UILabel()//商品名字
    var goodsPrice = UILabel()//商品价格
    var goodsNum = UILabel()//商品数量
    private var lineView = UIView()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor(red: 245/255, green: 246/255, blue: 247/255, alpha: 1.0)
        self.addSubview(goodsImage)
        self.addSubview(goodsName)
        self.addSubview(goodsPrice)
        self.addSubview(goodsNum)
        self.addSubview(lineView)
        
        goodsImage.snp_makeConstraints { (make) in
            make.left.equalTo(0).offset(20)
            make.top.equalTo(0)
            make.height.equalTo(100)
            make.width.equalTo(100)
        }
        goodsImage.image = UIImage(named: "jiushui")
        
        goodsImage.backgroundColor = UIColor.whiteColor()
        
        goodsName.snp_makeConstraints { (make) in
            make.left.equalTo(goodsImage.snp_right).offset(20)
            make.top.equalTo(0)
            make.right.equalTo(0)
            make.height.equalTo(50)
            
        }
        goodsName.numberOfLines = 0
        goodsName.text = "变蝴蝶花覅微博发挥文化覅维护地区和读取完"
        goodsName.font = UIFont.systemFontOfSize(12)
        
        goodsPrice.snp_makeConstraints { (make) in
            make.left.equalTo(goodsImage.snp_right).offset(20)
            make.top.equalTo(goodsName.snp_bottom).offset(5)
            make.height.equalTo(20)
            make.width.equalTo(80)
        }
        goodsPrice.text = "￥2.7"
        goodsPrice.font = UIFont.systemFontOfSize(12)
        goodsPrice.textColor = UIColor.redColor()
        
        
        goodsNum.snp_makeConstraints { (make) in
            make.right.equalTo(self.snp_right).offset(10)
            make.top.equalTo(goodsName.snp_bottom).offset(5)
            make.height.equalTo(20)
            make.width.equalTo(60)
        }
        
        goodsNum.text = "X 5"
        goodsNum.font = UIFont.systemFontOfSize(12)
        goodsNum.textAlignment = NSTextAlignment.Left
        
        
        lineView.snp_makeConstraints { (make) in
            make.left.right.equalTo(0)
            make.bottom.equalTo(0)
            make.height.equalTo(1)
        }
        lineView.backgroundColor = UIColor(red: 207/255, green: 208/255, blue: 209/255, alpha: 1.0)
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
