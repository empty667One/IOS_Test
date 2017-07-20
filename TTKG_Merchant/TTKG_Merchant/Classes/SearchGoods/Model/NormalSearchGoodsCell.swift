//
//  NormalSearchGoodsCell.swift
//  ttkg_customer
//
//  Created by iosnull on 16/7/12.
//  Copyright © 2016年 iosnull. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage
import SnapKit

//商品展示活动或促销图片
enum GoodsSelltatus {
    case 促销
    case 活动
    case 无
}

class NormalSearchGoodsCell: UITableViewCell {

    var goodsStatus = GoodsSelltatus.无 {
        didSet{
            switch goodsStatus {
            case .促销:
                statusImg.image = UIImage(named: "促销")
            case .活动:
                statusImg.image = UIImage(named: "活动")
            default:
                statusImg.image = nil
            }
        }
    }
    
    private var statusImg = UIImageView()
    
    var imgURL = String(){
        didSet{
            img.sd_setImageWithURL(NSURL(string: serverPicUrl + imgURL)!)
        }
    }
    
    var name = String(){
        didSet{
            goodsName.text = name
        }
    }
    
    var nowPriceStr = String(){
        didSet{
            nowPrice.text = "￥" + nowPriceStr
        }
    }
    
    var oldPriceStr = String(){
        didSet{
            //中划线
            let value = "￥" + oldPriceStr
            let attr = NSMutableAttributedString(string: "￥" + oldPriceStr)
            let str = String(stringInterpolationSegment: value)
            let length =  str.characters.count
            
            attr.addAttribute(NSStrikethroughStyleAttributeName, value:1 , range: NSMakeRange(0, length))
            //赋值
            oldPrice.attributedText = attr
        }
    }
    
    var giftStr = String(){
        didSet{
            gift.text = giftStr
        }
    }
    
    private var speprateLine = UIView()
    private var nowPrice = UILabel()
    private var oldPrice = UILabel()
    private var gift = UILabel()
    
    
    //销量
    var sellCnt = UILabel()
    //商家名称
    var shopName = UILabel()
    
    
    private var img = UIImageView()
    private let goodsName = UILabel()
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.addSubview(img)
        self.addSubview(goodsName)
        self.addSubview(nowPrice)
        self.addSubview(oldPrice)
        self.addSubview(gift)
        self.addSubview(speprateLine)
        
        img.snp_makeConstraints { (make) in
            make.top.equalTo(2)
            make.bottom.equalTo(0).offset(-2)
            make.left.equalTo(8)
            make.width.equalTo(screenWith/4 - 4)
        }
        
        
        goodsName.font = UIFont.systemFontOfSize(14)
        goodsName.numberOfLines = 0
        goodsName.snp_makeConstraints { (make) in
            make.left.equalTo(img.snp_right).offset(8)
            make.right.equalTo(2)
            make.top.equalTo(img.snp_top)
            make.height.equalTo(35)
        }
        
        
        gift.font = UIFont.systemFontOfSize(12)
        gift.textColor = UIColor.redColor()
        gift.snp_makeConstraints { (make) in
            make.left.equalTo(goodsName.snp_left)
            make.right.equalTo(goodsName.snp_right)
            make.top.equalTo(goodsName.snp_bottom)
            make.height.equalTo(16)
        }
        
        nowPrice.font = UIFont.systemFontOfSize(15)
        nowPrice.textColor = UIColor.redColor()
        nowPrice.textAlignment = .Left
        nowPrice.snp_makeConstraints { (make) in
//            make.left.equalTo(goodsName.snp_left).offset(20)
//            make.top.equalTo(gift.snp_bottom)
//            make.width.equalTo(120)
//            make.height.equalTo(30)
            make.left.equalTo(img.snp_right).offset(10)
            make.centerY.equalTo(img.centerY)
            make.width.equalTo(120)
            make.height.equalTo(15)
        }
        
        oldPrice.font = UIFont.systemFontOfSize(12)
        oldPrice.textColor = UIColor.grayColor()
        oldPrice.textAlignment = .Left
        oldPrice.snp_makeConstraints { (make) in
            make.left.equalTo(nowPrice.snp_right).offset(8)
            make.top.equalTo(nowPrice.snp_top)
            make.width.equalTo(120)
            make.bottom.equalTo(nowPrice.snp_bottom)
        }
        
        speprateLine.backgroundColor = UIColor(red: 248/255, green: 248/255, blue: 248/255, alpha: 1)
        speprateLine.snp_makeConstraints { (make) in
            make.bottom.left.right.equalTo(0)
            make.height.equalTo(2)
        }
        
        statusImg.contentMode = .ScaleAspectFit
        self.addSubview(statusImg)
        statusImg.snp_makeConstraints { (make) in
            make.left.top.equalTo(2)
            make.width.height.equalTo(25)
        }
        
        //销量
        self.addSubview(sellCnt)
        sellCnt.font = UIFont.systemFontOfSize(14)
        sellCnt.snp_makeConstraints { (make) in
            make.centerY.equalTo(img.centerY)
            make.right.equalTo(0).offset(-40)
            make.height.equalTo(15)
        }
        
        //商店名称
        self.addSubview(shopName)
        shopName.font = UIFont.systemFontOfSize(14)
        shopName.snp_makeConstraints { (make) in
            make.left.equalTo(goodsName.snp_left)
            make.right.equalTo(0)
            make.bottom.equalTo(self.snp_bottom).offset(-8)
            make.height.equalTo(15)
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}