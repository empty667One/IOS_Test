//
//  HotGoodsCell.swift
//  TTKG_Merchant
//
//  Created by macmini on 16/8/10.
//  Copyright © 2016年 yd. All rights reserved.
//

import UIKit

protocol HotGoodsCellDelegate {
    
    func buyBtnClickPushToVC(index: Int)
    func giftMessageBtnClickToView(message:String)
}

class HotGoodsCell: UICollectionViewCell {

    
    var delegate : HotGoodsCellDelegate?
    
    
    let buyBtn = UIButton()
    let contentLabel = UILabel()
    let priceLabel = UILabel()
    let goodImg = UIImageView()
    let smallImg = UIImageView()
    let giftMessage = UILabel()
    let shopname = UILabel()
    
    let smallLaBa = UIImageView()
    let giftMessageBtn = UIButton()
    
    let saleprice = UILabel()
    
    var imgUrl = String(){
        didSet{
            goodImg.sd_setImageWithURL(NSURL(string : serverPicUrl + imgUrl))
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(buyBtn)
        
        //添加按钮
        buyBtn.setTitle("加入进货单", forState: UIControlState.Normal)
        buyBtn.titleLabel?.font = UIFont.systemFontOfSize(13)
        buyBtn.addTarget(self, action: #selector(self.buyBtnClick), forControlEvents: UIControlEvents.TouchUpInside)
        buyBtn.backgroundColor = UIColor.redColor()
        buyBtn.layer.cornerRadius = 5
        buyBtn.layer.masksToBounds = true
        
        buyBtn.addTarget(self, action: #selector(HotGoodsCell.buyBtnClick), forControlEvents: .TouchUpInside)
        
        buyBtn.snp_makeConstraints { (make) in
            make.bottom.equalTo(0).offset(-10)
            make.left.equalTo(0).offset(35)
            make.right.equalTo(0).offset(-35)
            make.height.equalTo(25)
            
        }
        
        
       
        
        //添加价格
        self.addSubview(priceLabel)
        priceLabel.font = UIFont.systemFontOfSize(13)
        priceLabel.textColor = UIColor.redColor()
        priceLabel.textAlignment = .Center
        priceLabel.snp_makeConstraints { (make) in
            make.bottom.equalTo(buyBtn.snp_top).offset(-5)
            make.right.equalTo(0).offset(-10)
            make.height.equalTo(16)
            make.width.equalTo(self.width/2)
            
        }
        
        //添加促销价
        self.addSubview(saleprice)
        saleprice.font = UIFont.systemFontOfSize(13)
        saleprice.textColor = UIColor.lightGrayColor()
        saleprice.textAlignment = .Center
        saleprice.snp_makeConstraints { (make) in
            make.bottom.equalTo(buyBtn.snp_top).offset(-5)
            make.right.equalTo(priceLabel.snp_left).offset(-10)
            make.left.equalTo(0)
            make.height.equalTo(priceLabel.snp_height)
            
        }
       
    
        //添加商店名
        self.addSubview(shopname)
        shopname.font = UIFont.systemFontOfSize(12)
        shopname.textColor = UIColor.orangeColor()
        shopname.snp_makeConstraints { (make) in
            make.bottom.equalTo(priceLabel.snp_top).offset(-5)
            make.left.equalTo(0).offset(0)
            make.right.equalTo(0).offset(0)
            make.height.equalTo(15)
            
        }
        
        //添加标题
        self.addSubview(contentLabel)
        contentLabel.text = ""
        contentLabel.font = UIFont.systemFontOfSize(12)
        contentLabel.snp_makeConstraints { (make) in
            make.bottom.equalTo(shopname.snp_top).offset(-1)
            make.left.equalTo(0).offset(10)
            make.right.equalTo(0).offset(-10)
            make.height.equalTo(15)
        }
        
        self.addSubview(smallLaBa)
        smallLaBa.snp_makeConstraints { (make) in
            make.top.equalTo(0).offset(3)
            make.left.equalTo(0).offset(0)
            make.width.equalTo(25)
            make.height.equalTo(25)
        }
        //添加满赠信息
        giftMessage.text = ""
        self.addSubview(giftMessage)
        giftMessage.textAlignment = NSTextAlignment.Center
        giftMessage.numberOfLines = 0
        giftMessage.textColor = UIColor.redColor()
        giftMessage.font = UIFont.systemFontOfSize(12)
        giftMessage.snp_makeConstraints { (make) in
            make.top.equalTo(0).offset(8)
            make.left.equalTo(smallLaBa.snp_right).offset(0)
            make.right.equalTo(0).offset(-10)
            make.height.equalTo(15)
        }

        //添加满赠按钮
        self.addSubview(giftMessageBtn)
        giftMessageBtn.addTarget(self, action: #selector(self.giftMessageBtnClick), forControlEvents: UIControlEvents.TouchUpInside)
        giftMessageBtn.snp_makeConstraints { (make) in
            make.centerX.equalTo(self.snp_centerX).offset(0)
            make.top.equalTo(0).offset(0)
            make.left.equalTo(0).offset(0)
            make.right.equalTo(0).offset(0)
            make.height.equalTo(30)
        }
        
        //添加图片
        self.addSubview(goodImg)
        goodImg.contentMode = .ScaleAspectFit
        goodImg.snp_makeConstraints { (make) in
            make.top.equalTo(0).offset(20)
            make.left.equalTo(0).offset(20)
            make.right.equalTo(0).offset(-20)
            make.bottom.equalTo(contentLabel.snp_top).offset(-1)
        }
        
        //添加小图片
        self.addSubview(smallImg)
        smallImg.contentMode = .ScaleAspectFit
        smallImg.snp_makeConstraints { (make) in
            make.height.equalTo(25)
            make.left.equalTo(0).offset(10)
            make.width.equalTo(25)
            make.top.equalTo(0).offset(25)
        }
        
        
    }
    
    
    //点击立即购买按钮
    func buyBtnClick()  {
        
        self.delegate?.buyBtnClickPushToVC(buyBtn.tag)
    }
    func giftMessageBtnClick()  {
        
        
        self.delegate?.giftMessageBtnClickToView(giftMessage.text!)
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
