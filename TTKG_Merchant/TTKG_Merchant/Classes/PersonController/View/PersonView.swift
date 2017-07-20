//
//  PersonView.swift
//  TTKG_Merchant
//
//  Created by yd on 16/8/1.
//  Copyright © 2016年 yd. All rights reserved.
//

import UIKit

protocol PersonViewDelegate {
    
    func btnClick(num:Int)
    func orderClickToOrderVC()
    
}

class PersonView : UIView {
    
    
    var delegate : PersonViewDelegate?
    
    
    let bgImg = UIImageView()
    let mainImg = UIImageView()
    let titleLabel = UILabel()

    let orderBtn = UIButton()
    let smallImg = UIImageView()
    let label = UILabel()
    
    
    let accountname = UILabel()
    
    let seperateView = UIView()
    
    let btn1 = UIButton()
    let btn2 = UIButton()
    let btn3 = UIButton()
    let btn4 = UIButton()
    
    let btnLabel1 = UILabel()
    let btnLabel2 = UILabel()
    let btnLabel3 = UILabel()
    let btnLabel4 = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //logo
        bgImg.image = UIImage(named: "bg")
        self.addSubview(bgImg)
        bgImg.snp_makeConstraints { (make) in
            make.top.equalTo(0).offset(0)
            make.right.equalTo(0).offset(0)
            make.left.equalTo(0).offset(0)
            make.height.equalTo(100)
        }
        

        //品牌名称
        titleLabel.text = userInfo_Global.ptmc
        titleLabel.textAlignment = NSTextAlignment.Center
        titleLabel.textColor = UIColor.whiteColor()
        titleLabel.font = UIFont.systemFontOfSize(20)
        self.addSubview(titleLabel)
        titleLabel.snp_makeConstraints { (make) in
            make.top.equalTo(0).offset(8)
            make.height.equalTo(50)
            make.width.equalTo(width)
            make.bottom.equalTo(bgImg.snp_bottom).offset(-30)
            make.centerX.equalTo(bgImg.snp_centerX).offset(0)

        }
        //如果userInfo_Global.ptmc长度为0就显示平台logo
//        if  userInfo_Global.ptmc.characters.count == 0 {
//            
//            mainImg.image = UIImage(named: "4-1")
//            mainImg.contentMode = .ScaleAspectFit
//            self.addSubview(mainImg)
//            mainImg.backgroundColor = UIColor.blueColor()
//            mainImg.snp_makeConstraints { (make) in
//                make.top.equalTo(0).offset(8)
//                make.height.equalTo(80)
//                make.width.equalTo(80)
//                make.bottom.equalTo(bgImg.snp_bottom).offset(-30)
//                make.centerX.equalTo(bgImg.snp_centerX).offset(0)
//            }
//            
//
//        }
       

        
        //用户名
        accountname.text = userInfo_Global.loginid
        accountname.textAlignment = NSTextAlignment.Center
        accountname.textColor = UIColor.whiteColor()
        accountname.font = UIFont.systemFontOfSize(14)
        self.addSubview(accountname)
        accountname.snp_makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp_bottom).offset(-10)
            make.centerX.equalTo(bgImg.snp_centerX).offset(0)
            make.width.equalTo(100)
            make.height.equalTo(50)
        }
        
        orderBtn.addTarget(self, action: #selector(self.orderBtnClick), forControlEvents: .TouchUpInside)
        self.addSubview(orderBtn)
        orderBtn.snp_makeConstraints { (make) in
            make.top.equalTo(bgImg.snp_bottom).offset(0)
            make.left.equalTo(0).offset(0)
            make.right.equalTo(0).offset(0)
            make.height.equalTo(45)
        }
        
        smallImg.image = UIImage(named: "all_order_bg")
        self.addSubview(smallImg)
        smallImg.snp_makeConstraints { (make) in
            make.top.equalTo(bgImg.snp_bottom).offset(10)
            make.left.equalTo(0).offset(20)
            make.width.equalTo(25)
            make.height.equalTo(25)
        }
        
        
        label.text = "我的订单"
        label.font = UIFont.systemFontOfSize(14)
        self.addSubview(label)
        label.snp_makeConstraints { (make) in
            make.left.equalTo(smallImg.snp_right).offset(10)
            make.centerY.equalTo(smallImg.snp_centerY).offset(0)
        }
        
        seperateView.backgroundColor = UIColor.lightGrayColor()
        seperateView.alpha = 0.1
        self.addSubview(seperateView)
        seperateView.snp_makeConstraints { (make) in
            make.top.equalTo(smallImg.snp_bottom).offset(10)
            make.right.equalTo(0).offset(0)
            make.left.equalTo(0).offset(0)
            make.height.equalTo(1)
        }
        
        btn1.setImage(UIImage(named: "qb"), forState: .Normal)
        self.addSubview(btn1)
        btn1.snp_makeConstraints { (make) in
            make.top.equalTo(seperateView.snp_bottom).offset(0)
            make.width.equalTo(screenWith / 4)
            make.left.equalTo(0).offset(0)
            make.bottom.equalTo(0).offset(-8)
            
        }

        btnLabel1.text = "全部订单"
        btnLabel1.font = UIFont.systemFontOfSize(12)
        btnLabel1.textColor = UIColor.grayColor()
        self.addSubview(btnLabel1)
        btnLabel1.snp_makeConstraints { (make) in
            make.centerX.equalTo(btn1.snp_centerX).offset(0)
            make.bottom.equalTo(0).offset(-8)
           
        }

        
        btn2.setImage(UIImage(named: "dfk"), forState: .Normal)
        self.addSubview(btn2)
        btn2.snp_makeConstraints { (make) in
            make.top.equalTo(seperateView.snp_bottom).offset(0)
            make.width.equalTo(screenWith / 4)
            make.left.equalTo(btn1.snp_right).offset(0)
            make.bottom.equalTo(0).offset(-8)
        }
        
        btnLabel2.text = "待付款"
        btnLabel2.font = UIFont.systemFontOfSize(12)
        btnLabel2.textColor = UIColor.grayColor()
        self.addSubview(btnLabel2)
        btnLabel2.snp_makeConstraints { (make) in
            make.centerX.equalTo(btn2.snp_centerX).offset(0)
            make.bottom.equalTo(0).offset(-8)
            
        }
        
        
        btn3.setImage(UIImage(named: "dfh"), forState: .Normal)
        self.addSubview(btn3)
        btn3.snp_makeConstraints { (make) in
            make.top.equalTo(seperateView.snp_bottom).offset(0)
            make.width.equalTo(screenWith / 4)
            make.left.equalTo(btn2.snp_right).offset(0)
            make.bottom.equalTo(0).offset(-8)
        }
        
        btnLabel3.text = "待发货"
        btnLabel3.font = UIFont.systemFontOfSize(12)
        btnLabel3.textColor = UIColor.grayColor()
        self.addSubview(btnLabel3)
        btnLabel3.snp_makeConstraints { (make) in
            make.centerX.equalTo(btn3.snp_centerX).offset(0)
            make.bottom.equalTo(0).offset(-8)
            
        }
        
        btn4.setImage(UIImage(named: "dqs"), forState: .Normal)
        self.addSubview(btn4)
        btn4.snp_makeConstraints { (make) in
            make.top.equalTo(seperateView.snp_bottom).offset(0)
            make.width.equalTo(screenWith / 4)
            make.left.equalTo(btn3.snp_right).offset(0)
            make.bottom.equalTo(0).offset(-8)
        }
        
        btnLabel4.text = "待签收"
        btnLabel4.font = UIFont.systemFontOfSize(12)
        btnLabel4.textColor = UIColor.grayColor()
        self.addSubview(btnLabel4)
        btnLabel4.snp_makeConstraints { (make) in
            make.centerX.equalTo(btn4.snp_centerX).offset(0)
            make.bottom.equalTo(0).offset(-8)
            
        }
        
        
        btn1.addTarget(self, action: #selector(PersonView.btn1Click), forControlEvents: UIControlEvents.TouchUpInside)
        btn2.addTarget(self, action: #selector(PersonView.btn2Click), forControlEvents: UIControlEvents.TouchUpInside)
        btn3.addTarget(self, action: #selector(PersonView.btn3Click), forControlEvents: UIControlEvents.TouchUpInside)
        btn4.addTarget(self, action: #selector(PersonView.btn4Click), forControlEvents: UIControlEvents.TouchUpInside)

    }
    
    func orderBtnClick()  {
        self.delegate?.orderClickToOrderVC()
    }
    
    func btn1Click()  {
        
        self.delegate?.btnClick(0)
        
    }
    
    func btn2Click()  {
        
        
        self.delegate?.btnClick(1)
    }
    
    func btn3Click()  {
        
        self.delegate?.btnClick(2)
        
    }
    
    func btn4Click()  {
        
        self.delegate?.btnClick(3)
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}