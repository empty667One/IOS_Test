//
//  ShoppingCarCell.swift
//  ttkg_customer
//
//  Created by yd on 16/6/30.
//  Copyright © 2016年 iosnull. All rights reserved.
//

import UIKit
import SnapKit


protocol ShoppingCarCellDelegate {
    func selectCellBtn(section:NSIndexPath,status:Bool)
    
    //加减购物车数量
    func addOrReduceShopCarGoodsNum(index:NSIndexPath,num:Int)
    
    
}


class ShoppingCarCell: UITableViewCell {
    
    var proid = 0 //产品id
    
    var priceid = 0 // 产品价格id
    
    
    var selectFlag = true {
        didSet{
            if !selectFlag  {
                selectBtn.setImage(UIImage(named: "购物车_10"), forState: UIControlState.Normal)
            }else{
                selectBtn.setImage(UIImage(named: "勾"), forState: UIControlState.Normal)
            }
        }
    }
    
    
    var delegate :ShoppingCarCellDelegate?
    
    var index = NSIndexPath()// 设置选中的哪一行
    var selectBtn = UIButton()//选中按钮
    var shopImage = UIImageView()//商品图片
    var shopName = UILabel()//商品名称
    var goodsPrice = UILabel()//商品价格
    var shopActivity = UILabel()//商品活动
    private var deleteBtn = UIButton()
    
    private var lineView = UIView()
    
    var selectNumBtn = SelectNumBtn(width: 0, height: 0, center: CGPoint(x: 0,y: 0), num: 100){
        didSet{
            self.subviews.map( {(subview: AnyObject) -> AnyObject in
                if subview.isKindOfClass(SelectNumBtn) {
                    subview.removeFromSuperview()
                }
                return subview
            })
            
            self.addSubview(selectNumBtn)
            selectNumBtn.delegate = self
            
            selectNumBtn.snp_makeConstraints { (make) in
                make.right.equalTo(0).offset(-10)
                make.top.equalTo(shopName.snp_bottom).offset(1)
                make.width.equalTo(100)
                make.height.equalTo(30)
            }

        }
    }
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor(red: 245/255, green: 246/255, blue: 247/255, alpha: 1.0)
        self.addSubview(lineView)
        self.addSubview(selectBtn)
        self.addSubview(shopImage)
        self.addSubview(shopName)
        
        
        lineView.snp_makeConstraints { (make) in
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.bottom.equalTo(self.snp_bottom).offset(-1)
            make.height.equalTo(2)
        }
        lineView.backgroundColor = UIColor.whiteColor()

        selectBtn.snp_makeConstraints { (make) in
            make.left.equalTo(0)
            make.top.equalTo(0)
            make.width.equalTo(40)
            make.bottom.equalTo(lineView.snp_top).offset(-2)
        }
        selectBtn.backgroundColor = UIColor(red: 245/255, green: 246/255, blue: 247/255, alpha: 1.0)
        selectBtn.setImage(UIImage(named: "购物车_10"), forState: UIControlState.Normal)
        selectBtn.imageEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5)
        selectBtn.addTarget(self, action: #selector(ShoppingCarCell.selectBtnClick(_:)), forControlEvents: UIControlEvents.TouchUpInside)

        shopImage.snp_makeConstraints { (make) in
            make.left.equalTo(selectBtn.snp_right)
            make.top.equalTo(0)
            make.height.equalTo(100)
            make.width.equalTo(100)
            make.bottom.equalTo(lineView.snp_top).offset(-1)
        }
        
        

        shopName.snp_makeConstraints { (make) in
            make.left.equalTo(shopImage.snp_right)
            make.right.equalTo(0)
            make.top.equalTo(0)
            make.height.equalTo(40)
        }
        
        shopName.font = UIFont.systemFontOfSize(12)
        shopName.numberOfLines = 2
        
        self.addSubview(goodsPrice)
        goodsPrice.snp_makeConstraints { (make) in
            make.left.equalTo(shopImage.snp_right)
            make.top.equalTo(shopName.snp_bottom)
            make.width.equalTo(120)
            make.height.equalTo(30)
        }
        goodsPrice.font = UIFont.systemFontOfSize(13)
        
        goodsPrice.textColor = UIColor.redColor()
        goodsPrice.textAlignment = .Left
        
        
        
        
        self.addSubview(shopActivity)
        shopActivity.snp_makeConstraints { (make) in
            make.left.equalTo(shopImage.snp_right)
            make.top.equalTo(goodsPrice.snp_bottom)
            make.right.equalTo(0)
            make.height.equalTo(30)
        }
        shopActivity.textColor = UIColor.redColor()
        shopActivity.font = UIFont.systemFontOfSize(10)
        
        
        
        
        
        
        
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}





extension ShoppingCarCell {
    func selectBtnClick(sender:UIButton)  {
        
        if selectFlag  {
            self.delegate?.selectCellBtn(index, status: false)
        }else{
            self.delegate?.selectCellBtn(index, status: true)
        }
    }
    
}




extension ShoppingCarCell : SelectNumBtnDelegate {
    func selectNums(num: Int) {
        
        self.delegate?.addOrReduceShopCarGoodsNum(index, num: num)
        
    }
    
}


