//
//  MMButtonsOnderLine.swift
//  ttkg_customer
//
//  Created by iosnull on 16/7/4.
//  Copyright © 2016年 iosnull. All rights reserved.
//

import UIKit
import SnapKit

protocol MMButtonsOnderLineDelegate {
    func orderStatesSeparatedBy(index:Int)
}
class MMButtonsOnderLine: UIView {

    //按钮名称
    let buttonNames = ["全部商品","热销商品","优惠商品","店铺活动","商店信息"]
    var allBtns = [UIButton]()
    
    //全部商品
    private var allOrderBtn = UIButton()
    var allOderLabel = UILabel()
    //热销商品
    private var waitToPayBtn = UIButton()
    var waitToPayLabel = UILabel()
    //优惠商品
    private var waitToDeliverBtn = UIButton()
    var waitToDeliverLabel = UILabel()
    //店铺活动
    private var waitToAcceptBtn = UIButton()
    var waitToAcceptLabel = UILabel()
    //商店信息
    private var finishedBtn = UIButton()
    var finishedImage = UIImageView()
    
    private let onderLine = UIImageView()
    
    var delegate:MMButtonsOnderLineDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let w = self.frame.size.width/5

        self.addSubview(allOrderBtn)
        self.addSubview(allOderLabel)
        
        /*********************************全部商品****************************************/
        allOderLabel.snp_makeConstraints { (make) in
            make.left.equalTo(0)
            make.width.equalTo(w)
            make.top.equalTo(0)
            make.height.equalTo(20)
        }
        allOderLabel.textAlignment = NSTextAlignment.Center
        allOderLabel.font = UIFont.systemFontOfSize(12)
        
        //按钮
        allOrderBtn.snp_makeConstraints { (make) in
            make.left.equalTo(0)
            make.width.equalTo(w)
            make.top.equalTo(allOderLabel.snp_bottom)
            make.bottom.equalTo(0).offset(-4)
        }
        allOrderBtn.setTitleColor(UIColor.redColor(), forState: UIControlState.Normal)
        
        /***********************************热销商品**************************************/
        self.addSubview(waitToPayBtn)
        self.addSubview(waitToPayLabel)
        
        waitToPayLabel.snp_makeConstraints { (make) in
            make.left.equalTo(allOrderBtn.snp_right)
            make.width.equalTo(w)
            make.top.equalTo(0)
            make.height.equalTo(20)
        }
        waitToPayLabel.textAlignment = NSTextAlignment.Center
        waitToPayLabel.font = UIFont.systemFontOfSize(12)
        
        //按钮
        waitToPayBtn.snp_makeConstraints { (make) in
            make.left.equalTo(allOrderBtn.snp_right)
            make.width.equalTo(w)
            make.top.equalTo(waitToPayLabel.snp_bottom)
            make.bottom.equalTo(0).offset(-4)
        }
        
        /********************************优惠活动*****************************************/
        self.addSubview(waitToDeliverBtn)
        self.addSubview(waitToDeliverLabel)
        
        waitToDeliverLabel.textAlignment = NSTextAlignment.Center
        waitToDeliverLabel.font = UIFont.systemFontOfSize(12)
        waitToDeliverLabel.snp_makeConstraints { (make) in
            make.left.equalTo(waitToPayBtn.snp_right)
            make.width.equalTo(w)
            make.top.equalTo(0)
            make.height.equalTo(20)
        }
        
        waitToDeliverBtn.snp_makeConstraints { (make) in
            make.left.equalTo(waitToPayBtn.snp_right)
            make.width.equalTo(w)
            make.top.equalTo(waitToDeliverLabel.snp_bottom)
            make.bottom.equalTo(0).offset(-4)
        }
        
        /********************************店铺活动*****************************************/
        self.addSubview(waitToAcceptBtn)
        self.addSubview(waitToAcceptLabel)
        
        waitToAcceptLabel.textAlignment = NSTextAlignment.Center
        waitToAcceptLabel.font = UIFont.systemFontOfSize(12)

        waitToAcceptLabel.snp_makeConstraints { (make) in
            make.left.equalTo(waitToDeliverBtn.snp_right)
            make.width.equalTo(w)
            make.top.equalTo(0)
            make.height.equalTo(20)
        }
        
        waitToAcceptBtn.snp_makeConstraints { (make) in
            make.left.equalTo(waitToDeliverBtn.snp_right)
            make.width.equalTo(w)
            make.top.equalTo(waitToAcceptLabel.snp_bottom)
            make.bottom.equalTo(0).offset(-4)
        }
        
        
        /**********************************商店信息***************************************/
        self.addSubview(finishedBtn)
        self.addSubview(finishedImage)
        
        finishedImage.snp_makeConstraints { (make) in
            make.left.equalTo(waitToAcceptBtn.snp_right)
            make.width.equalTo(w)
            make.top.equalTo(0)
            make.height.equalTo(20)
        }
        finishedImage.contentMode = .ScaleAspectFit
        finishedImage.image = UIImage(named: "房子")
        
        finishedBtn.snp_makeConstraints { (make) in
            make.left.equalTo(waitToAcceptBtn.snp_right)
            make.width.equalTo(w)
            make.top.equalTo(finishedImage.snp_bottom)
            make.bottom.equalTo(0).offset(-4)
        }
        
        
        allBtns.append(allOrderBtn)
        allBtns.append(waitToPayBtn)
        allBtns.append(waitToDeliverBtn)
        allBtns.append(waitToAcceptBtn)
        allBtns.append(finishedBtn)
        setBtn(allBtns)
        
        //下划线
        self.addSubview(onderLine)
        onderLine.frame = CGRect(x: 0, y: self.frame.size.height - 3, width: w, height: 3)
        onderLine.backgroundColor = UIColor(red: 231/255, green: 31/255, blue: 24/255, alpha: 1)
        
        self.backgroundColor = UIColor.whiteColor()
    }
    
    /**
     设置按钮样式
     
     - parameter btns: btns description
     */
    func setBtn(btns:[UIButton])  {
        self.allOderLabel.textColor = UIColor.redColor()
        
        for i in 0..<btns.count {
            btns[i].setTitle(buttonNames[i], forState: UIControlState.Normal)
            btns[i].titleLabel?.font = UIFont.systemFontOfSize(12)
            btns[i].setTitleColor(UIColor(red: 50/255, green: 50/255, blue: 50/255, alpha: 1), forState: UIControlState.Normal)
            btns[i].setTitleColor(UIColor(red: 231/255, green: 31/255, blue: 24/255, alpha: 1), forState: UIControlState.Highlighted)
            btns[i].addTarget(self, action: #selector(MMButtonsOnderLine.btnClk(_:)), forControlEvents: UIControlEvents.TouchUpInside)
            btns[i].tag = i
        }
    }
    
    //点击事件
    func btnClk(sender:UIButton)  {
        let i = sender.tag
        
        
        UIView.animateWithDuration(0.1, animations: { 
            self.onderLine.center.x = self.allBtns[i].center.x
            }) { (flag) in
                for btn in self.allBtns {
                    btn.setTitleColor(UIColor(red: 50/255, green: 50/255, blue: 50/255, alpha: 1), forState: UIControlState.Normal)
                }
                sender.setTitleColor(UIColor(red: 217/255, green: 4/255, blue: 19/255, alpha: 1), forState: UIControlState.Normal)
                self.delegate?.orderStatesSeparatedBy(i)
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
