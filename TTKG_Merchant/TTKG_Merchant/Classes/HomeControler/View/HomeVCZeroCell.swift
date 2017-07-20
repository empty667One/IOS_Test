//
//  HomeVCZeroCell.swift
//  TTKG_Merchant
//
//  Created by macmini on 16/8/2.
//  Copyright © 2016年 yd. All rights reserved.
//

import UIKit

class HomeVCZeroCell: UICollectionViewCell {
    
    
    let btn1 = UIButton()
    let btn2 = UIButton()
    let btn3 = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        self.addSubview(btn1)
        btn1.snp_makeConstraints { (make) in
            make.left.equalTo(0).offset(2)
            make.width.equalTo((screenWith - 20) / 3)
            make.top.equalTo(0).offset(5)
            make.bottom.equalTo(0).offset(-5)
            
        }
        
        btn1.setBackgroundImage(UIImage(named: "home_tab_one" ), forState: UIControlState.Normal)
        //点击满赠按钮
        btn1.addTarget(self, action: #selector(self.btn1Click), forControlEvents: UIControlEvents.TouchUpInside)
        btn1.contentMode = .ScaleAspectFit
        
        self.addSubview(btn3)
        btn3.snp_makeConstraints { (make) in
            make.right.equalTo(0).offset(-2)
            make.width.equalTo((screenWith - 20) / 3)
            make.top.equalTo(0).offset(5)
            make.bottom.equalTo(0).offset(-5)
            
        }
//        btn3.setBackgroundImage(UIImage(named: "jinrong" ), forState: UIControlState.Normal)
        
        btn3.setBackgroundImage(UIImage(named: "home_tab_three" ), forState: UIControlState.Normal)

        //点击供应商按钮
        btn3.addTarget(self, action: #selector(self.btn3Click), forControlEvents: UIControlEvents.TouchUpInside)
        btn3.contentMode = .ScaleAspectFit
        
        
        self.addSubview(btn2)
        btn2.snp_makeConstraints { (make) in
            make.left.equalTo(btn1.snp_right).offset(10)
            make.right.equalTo(btn3.snp_left).offset(-10)
            make.top.equalTo(0).offset(5)
            make.bottom.equalTo(0).offset(-5)
            
        }
        btn2.setBackgroundImage(UIImage(named: "home_tab_two" ), forState: UIControlState.Normal)
        //点击热卖按钮
        btn2.addTarget(self, action: #selector(self.btn2Click), forControlEvents: UIControlEvents.TouchUpInside)
        btn2.contentMode = .ScaleAspectFit
    }
    
    
    //按钮的点击事件
    func btn1Click() {
        
        let notice:NSNotification =  NSNotification(name: "pushBuyForGiftVC", object: nil)
        NSNotificationCenter.defaultCenter().postNotification(notice)
    }
    
    func btn2Click() {
        
        let notice:NSNotification =  NSNotification(name: "pushHotGoodsVC", object: nil)
        NSNotificationCenter.defaultCenter().postNotification(notice)
    }
    
    func btn3Click() {
        
        let notice:NSNotification =  NSNotification(name: "pushSupplierVC", object: nil)
        NSNotificationCenter.defaultCenter().postNotification(notice)
    }

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
