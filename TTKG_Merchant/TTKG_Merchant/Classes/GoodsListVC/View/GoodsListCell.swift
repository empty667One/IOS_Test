//
//  GoodsCell.swift
//  TTKG_Merchant
//
//  Created by iosnull on 16/8/5.
//  Copyright © 2016年 yd. All rights reserved.
//

import Foundation

import SnapKit



//商品列表cell
class GoodsListCell: UICollectionViewCell {
    
    private var statusImg = UIImageView()
    
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
    
    //商家名称
    var shopName = UILabel()
    //商品图片
    var goodsImage =  UIImageView()
    //商品名称
    var goodsName =  UILabel()
    //现价
    var nowPriceStr:String?{
        didSet{
            guard nowPriceStr != "" else{
                currentPrice.text = ""
                return
            }
            currentPrice.text = "￥" + nowPriceStr!
        }
    }
    
    //原价
    var oldPriceStr:String?{
        didSet{
//            guard oldPriceStr != "" else{
//                originPrice.text = ""
//                return
//            }
//            originPrice.text = "￥" + oldPriceStr!
//            
//            //中划线
//            let value = "￥" + oldPriceStr!
//            let attr = NSMutableAttributedString(string: "￥" + oldPriceStr!)
//            let str = String(stringInterpolationSegment: value)
//            let length =  str.characters.count
//            
//            attr.addAttribute(NSStrikethroughStyleAttributeName, value:1 , range: NSMakeRange(0, length))
//            //赋值
//            originPrice.attributedText = attr
        }
    }
    
    //商品活动
    var shopActivityStr:String?{
        didSet{
            guard shopActivityStr != "" else{
                shopActivity.text = ""
                return
            }
            shopActivity.text = "【" + shopActivityStr! + "】"
        }
    }
    
    //销量
    var saleNumStr:String?{
        didSet{
            guard saleNumStr != "" else{
                saleNum.text = ""
                return
            }
            saleNum.text = "已售:" + saleNumStr!
        }
    }
    
    private var shopActivity = UILabel()
    
    private var saleNum =  UILabel()
    
    private var originPrice =  UILabel()
    
    private var currentPrice =  UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(goodsImage)
        goodsImage.snp_makeConstraints { (make) in
            make.left.equalTo(self.snp_left).offset(2)
            make.right.equalTo(self.snp_right).offset(-2)
            make.top.equalTo(self.snp_top).offset(2)
            make.height.equalTo(self.snp_width).offset(-4)
        }
        self.addSubview(goodsName)
        goodsName.font = UIFont.systemFontOfSize(11)
        goodsName.snp_makeConstraints { (make) in
            make.left.equalTo(self.snp_left).offset(5)
            make.right.equalTo(self.snp_right).offset(-5)
            make.top.equalTo(goodsImage.snp_bottom).offset(2)
            make.height.equalTo(13)
        }
        
        self.addSubview(shopName)
        shopName.snp_makeConstraints { (make) in
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.top.equalTo(goodsName.snp_bottom)
            make.width.equalTo(14)
        }
        shopName.font = UIFont.systemFontOfSize(10)
        shopName.textColor = UIColor(red: 253/255, green: 130/255, blue: 10/255, alpha: 1)
        
        
        self.addSubview(shopActivity)
        shopActivity.font = UIFont.systemFontOfSize(9)
        shopActivity.textColor = UIColor(red: 245/255, green: 122/255, blue: 0, alpha: 1)
        shopActivity.snp_makeConstraints { (make) in
            make.left.equalTo(self.snp_left).offset(5)
            make.right.equalTo(self.snp_right).offset(-5)
            make.top.equalTo(goodsName.snp_bottom).offset(1)
            make.height.equalTo(12)
        }
        
        self.addSubview(saleNum)
        saleNum.font = UIFont.systemFontOfSize(8)
        saleNum.textColor = UIColor(red: 128/255, green: 128/255, blue: 128/255, alpha: 1)
        saleNum.snp_makeConstraints { (make) in
            make.left.equalTo(self.snp_left).offset(5)
            make.width.equalTo(self.frame.size.width/3 - 5)
            make.top.equalTo(shopActivity.snp_bottom).offset(1)
            make.height.equalTo(12)
        }
        
        self.addSubview(originPrice)
        originPrice.font = UIFont.systemFontOfSize(8)
        originPrice.textColor = UIColor(red: 128/255, green: 128/255, blue: 128/255, alpha: 1)
        originPrice.textAlignment = NSTextAlignment.Right
        originPrice.snp_makeConstraints { (make) in
            make.left.equalTo(saleNum.snp_right).offset(5)
            make.width.equalTo(self.frame.size.width/3 - 10)
            make.top.equalTo(saleNum.snp_top)
            make.height.equalTo(12)
        }
        
        self.addSubview(currentPrice)
        currentPrice.font = UIFont.systemFontOfSize(10)
        currentPrice.textAlignment = NSTextAlignment.Left
        currentPrice.textColor = UIColor(red: 233/255, green: 0/255, blue: 0/255, alpha: 1)
        currentPrice.snp_makeConstraints { (make) in
            make.left.equalTo(originPrice.snp_right).offset(2)
            make.right.equalTo(self.snp_right)
            make.bottom.equalTo(originPrice.snp_bottom)
            make.height.equalTo(15)
        }
        
        
        self.addSubview(statusImg)
        statusImg.contentMode = .ScaleAspectFit
        statusImg.snp_makeConstraints { (make) in
            make.left.top.equalTo(4)
            make.width.height.equalTo(30)
        }
        
        
        self.backgroundColor = UIColor.whiteColor()
        
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}