//
//  ShoppingCarHeaderVIew.swift
//  ttkg_customer
//
//  Created by yd on 16/7/2.
//  Copyright © 2016年 iosnull. All rights reserved.
//

import UIKit
import SnapKit


protocol ShoppingCarHeaderVIewDelegate {
    //该商家下商品全选事件
    func selectHeaderBtn(sender: Int,status : Bool)
    //进入商家按钮事件
    func enterMerchantBtnClk(section:Int)
}


class ShoppingCarHeaderView: UIView {
    var selectFlag:Bool = false {
        didSet{
            if selectFlag {
                headerBtn.setImage(UIImage(named: "勾"), forState: UIControlState.Normal)
            }else{
                headerBtn.setImage(UIImage(named: "购物车_10"), forState: UIControlState.Normal)
            }
        }
    }
    
    var delegate : ShoppingCarHeaderVIewDelegate?

    var headerBtn = UIButton()
    var headerImage = UIImageView()
    var headerName = UILabel()
    
    //进入商家
    private let enterMerchantBtn = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.whiteColor()
        self.addSubview(headerBtn)
        
        headerBtn.snp_makeConstraints { (make) in
            make.left.equalTo(0)
            make.top.equalTo(0)
            make.bottom.equalTo(0)
            make.width.equalTo(40)
        }
        
        
        headerBtn.setImage(UIImage(named: "购物车_10"), forState: UIControlState.Normal)
        headerBtn.imageEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5)
        headerBtn.addTarget(self, action: #selector(ShoppingCarHeaderView.selectBtnClick(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        
        self.addSubview(headerImage)
        headerImage.snp_makeConstraints { (make) in
            make.left.equalTo(headerBtn.snp_right)
            make.top.equalTo(5)
            make.bottom.equalTo(-5)
            make.width.equalTo(23)
        }
        headerImage.image = UIImage(named: "房子")
        headerImage.contentMode = .ScaleAspectFit
        
        self.addSubview(headerName)
        headerName.snp_makeConstraints { (make) in
            make.left.equalTo(headerImage.snp_right).offset(2)
            make.top.equalTo( 0).offset(8)
            make.right.equalTo(0)
            make.height.equalTo(30)
        }
        headerName.font = UIFont.systemFontOfSize(14)
        
        self.addSubview(enterMerchantBtn)
        enterMerchantBtn.setTitle("进入商家 >", forState: UIControlState.Normal)
        enterMerchantBtn.snp_makeConstraints { (make) in
            make.right.equalTo(0).offset(-10)
            make.centerY.equalTo(headerName.snp_centerY)
            make.width.equalTo(70)
        }
        
        enterMerchantBtn.titleLabel?.font = UIFont.systemFontOfSize(14)
        enterMerchantBtn.setTitleColor(UIColor(red: 253/255, green: 130/255, blue: 29/255, alpha: 1), forState: UIControlState.Normal)
        enterMerchantBtn.addTarget(self, action: #selector(ShoppingCarHeaderView.enterMerchantBtnClk), forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension ShoppingCarHeaderView {
    func selectBtnClick(sender:UIButton) {
        if selectFlag  {
            self.delegate?.selectHeaderBtn(sender.tag,status:false)
        }else{
            self.delegate?.selectHeaderBtn(sender.tag,status:true)
        }

    }
    
    func enterMerchantBtnClk() {
        self.delegate?.enterMerchantBtnClk(self.tag)
    }
}
