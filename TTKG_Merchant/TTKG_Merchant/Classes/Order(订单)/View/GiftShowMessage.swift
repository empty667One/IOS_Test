//
//  GiftShowMessage.swift
//  ttkg_customer
//
//  Created by iosnull on 16/7/15.
//  Copyright © 2016年 iosnull. All rights reserved.
//

import Foundation

//
//  HalfAlphaBroadcoastImageView.swift
//  ttkg_customer
//
//  Created by iosnull on 16/7/13.
//  Copyright © 2016年 iosnull. All rights reserved.
//

import UIKit
import SnapKit

class HalfAlphaGiftShowMessageImageView: UIImageView {
    
    /*
     // Only override drawRect: if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func drawRect(rect: CGRect) {
     // Drawing code
     }
     */
    
    var okBtn = UIButton()
    
    var message = String(){
        didSet{
            giftMessage.text = message
        }
    }
    
    private var title = UILabel()
    private var giftMessage = UILabel()
    private var disImg = UIImageView()
    
    private var backgroundView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        self.addSubview(backgroundView)
        backgroundView.snp_makeConstraints { (make) in
            make.left.right.top.bottom.equalTo(0)
        }
        backgroundView.backgroundColor = UIColor.grayColor()
        backgroundView.alpha = 0.8
        
        
        
        
        
        
        self.userInteractionEnabled = true
        
        self.image = UIImage(named: "halfAlphaImg")
        self.contentMode = .ScaleAspectFill
        
        giftMessage.font = UIFont.systemFontOfSize(17)
        giftMessage.textColor = UIColor.redColor()
        self.addSubview(title)
        //title.text = "赠品信息"
        title.textAlignment = .Center
        title.textColor = UIColor.redColor()
        title.snp_makeConstraints { (make) in
            make.left.right.equalTo(0)
            make.top.equalTo(100)
            make.height.equalTo(40)
        }
        
        
        self.addSubview(giftMessage)
        giftMessage.font = UIFont.systemFontOfSize(14)
        giftMessage.textColor = UIColor.whiteColor()
        giftMessage.textAlignment = .Center
        giftMessage.numberOfLines = 0
        giftMessage.snp_makeConstraints { (make) in
            make.top.equalTo(title.snp_bottom)
            make.left.equalTo(0).offset(10)
            make.right.equalTo(0).offset(-10)
            make.height.equalTo(120)
        }
        self.addSubview(disImg)
        disImg.image = UIImage(named: "disMissBtnImg")
        disImg.snp_makeConstraints { (make) in
            make.width.height.equalTo(40)
            make.bottom.equalTo(self.snp_bottom).offset(-60)
            make.centerX.equalTo(self.snp_centerX)
        }
        
        self.addSubview(okBtn)
        okBtn.snp_makeConstraints { (make) in
            make.centerX.equalTo(self.snp_centerX)
            make.width.equalTo(80)
            make.height.equalTo(35)
            make.bottom.equalTo(self.snp_bottom).offset(-40)
        }
        
        okBtn.layer.cornerRadius = 5
        okBtn.layer.borderWidth = 1
        okBtn.layer.borderColor = UIColor.whiteColor().CGColor
        okBtn.setTitle("知道了", forState: UIControlState.Normal)
        okBtn.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        okBtn.addTarget(self, action: Selector("disBtnClk"), forControlEvents: UIControlEvents.TouchUpInside)
        
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(HalfAlphaBroadcoastImageView.disBtnClk))
        gestureRecognizer.numberOfTapsRequired=1
        gestureRecognizer.numberOfTouchesRequired=1
        
        self.addGestureRecognizer(gestureRecognizer)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func disBtnClk(){
        self.removeFromSuperview()
    }
    
}
