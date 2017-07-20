//
//  HomeAdAPPView.swift
//  TTKG_Merchant
//
//  Created by macmini on 16/8/23.
//  Copyright © 2016年 yd. All rights reserved.
//

import UIKit

protocol HomeAdAPPViewDelegate {
    func NoBuyBtnClick()
    func BuyBtnClick()
    
}

class HomeAdAPPView: UIView {

    var delegate:HomeAdAPPViewDelegate?
    
    var imageUrl = ""{
        didSet{
            image.sd_setImageWithURL(NSURL(string: serverPicUrl + imageUrl))
        }
    }
    
    let blackView = UIView()
    
    let image = UIImageView()
    let btn1 = UIButton()
    let btn2 = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        self.addSubview(blackView)
        blackView.backgroundColor = UIColor.blackColor()
        blackView.alpha = 0.5
        blackView.snp_makeConstraints { (make) in
            make.top.equalTo(0).offset(0)
            make.left.equalTo(0).offset(0)
            make.right.equalTo(0).offset(0)
            make.bottom.equalTo(0).offset(0)
        }
        
        image.userInteractionEnabled = true
        self.addSubview(image)
        image.backgroundColor = UIColor.brownColor()
        image.snp_makeConstraints { (make) in
            make.top.equalTo(0).offset(80)
            make.left.equalTo(0).offset(30)
            make.width.equalTo(screenWith - 60)
            make.height.equalTo(200)
        }
        
        btn1.backgroundColor = UIColor.whiteColor()
        btn1.titleLabel?.font = UIFont.systemFontOfSize(14)
        btn1.addTarget(self, action: #selector(self.btn1Click), forControlEvents: .TouchUpInside)
        btn1.setTitle("遗憾错过", forState: UIControlState.Normal)
        btn1.setTitleColor(UIColor.grayColor(), forState: UIControlState.Normal)
        self.addSubview(btn1)
        btn1.snp_makeConstraints { (make) in
            make.left.equalTo(image.snp_left).offset(0)
            make.right.equalTo(image.snp_centerX).offset(0)
            make.top.equalTo(image.snp_bottom).offset(0)
            make.height.equalTo(35)
        }

        btn2.backgroundColor = UIColor.whiteColor()
        btn2.titleLabel?.font = UIFont.systemFontOfSize(14)
        btn2.addTarget(self, action: #selector(self.btn2Click), forControlEvents: .TouchUpInside)
        btn2.setTitle("立即购买", forState: UIControlState.Normal)
        btn2.setTitleColor(UIColor.redColor(), forState: UIControlState.Normal)
        self.addSubview(btn2)
        btn2.snp_makeConstraints { (make) in
            make.left.equalTo(image.snp_centerX).offset(0)
            make.right.equalTo(image.snp_right).offset(0)
            make.top.equalTo(image.snp_bottom).offset(0)
            make.height.equalTo(35)
        }

    }
    
    func btn1Click(){
        self.delegate?.NoBuyBtnClick()
    }
    
    func btn2Click(){
        self.delegate?.BuyBtnClick()
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
