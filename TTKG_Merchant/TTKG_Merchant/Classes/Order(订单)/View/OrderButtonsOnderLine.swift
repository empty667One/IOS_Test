//
//  MMButtonsOnderLine.swift
//  ttkg_customer
//
//  Created by iosnull on 16/7/4.
//  Copyright © 2016年 iosnull. All rights reserved.
//

import UIKit
import SnapKit

protocol OrderButtonsOnderLineDelegate {
    func goodsOrderStatesSeparatedBy(index:Int)
}
class OrderButtonsOnderLine: UIView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    var selectNum = 0 {
        didSet{
            UIView.animateWithDuration(0.1, animations: {
                self.onderLine.center.x = self.allBtns[self.selectNum].center.x
                
            }) { (flag) in
                for btn in self.allBtns {
                    btn.setTitleColor(UIColor(red: 50/255, green: 50/255, blue: 50/255, alpha: 1), forState: UIControlState.Normal)
                }
                self.allBtns[self.selectNum].setTitleColor(UIColor(red: 217/255, green: 4/255, blue: 19/255, alpha: 1), forState: UIControlState.Normal)
                self.delegate?.goodsOrderStatesSeparatedBy(self.selectNum)
            }
        }
    }
    
    //按钮名称
    let buttonNames = ["全部","爽购","待付款","待发货","待签收","已完成"]
    var allBtns = [UIButton]()
    
    //全部
    private var allOrderBtn = UIButton()
    //爽购
    private var shuangGouBtn = UIButton()
    //待付款
    private var waitToPayBtn = UIButton()
    //待发货
    private var waitToDeliverBtn = UIButton()
    //待签收
    private var waitToAcceptBtn = UIButton()
    //已完成
    private var finishedBtn = UIButton()
    
    private let onderLine = UIImageView()
    
    var delegate:OrderButtonsOnderLineDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let w = self.frame.size.width/6

        self.addSubview(allOrderBtn)
        allOrderBtn.snp_makeConstraints { (make) in
            make.left.equalTo(0)
            make.width.equalTo(w)
            make.top.equalTo(0)
            make.bottom.equalTo(0).offset(-4)
        }
        
        self.addSubview(shuangGouBtn)
        shuangGouBtn.snp_makeConstraints { (make) in
            make.left.equalTo(allOrderBtn.snp_right)
            make.width.equalTo(w)
            make.top.equalTo(0)
            make.bottom.equalTo(0).offset(-4)
        }
        
        
        self.addSubview(waitToPayBtn)
        waitToPayBtn.snp_makeConstraints { (make) in
            make.left.equalTo(shuangGouBtn.snp_right)
            make.width.equalTo(w)
            make.top.equalTo(0)
            make.bottom.equalTo(0).offset(-4)
        }
        
        self.addSubview(waitToDeliverBtn)
        waitToDeliverBtn.snp_makeConstraints { (make) in
            make.left.equalTo(waitToPayBtn.snp_right)
            make.width.equalTo(w)
            make.top.equalTo(0)
            make.bottom.equalTo(0).offset(-4)
        }
        
        self.addSubview(waitToAcceptBtn)
        waitToAcceptBtn.snp_makeConstraints { (make) in
            make.left.equalTo(waitToDeliverBtn.snp_right)
            make.width.equalTo(w)
            make.top.equalTo(0)
            make.bottom.equalTo(0).offset(-4)
        }
        
        self.addSubview(finishedBtn)
        finishedBtn.snp_makeConstraints { (make) in
            make.left.equalTo(waitToAcceptBtn.snp_right)
            make.width.equalTo(w)
            make.top.equalTo(0)
            make.bottom.equalTo(0).offset(-4)
        }
        
        
        allBtns.append(allOrderBtn)
        allBtns.append(shuangGouBtn)
        allBtns.append(waitToPayBtn)
        allBtns.append(waitToDeliverBtn)
        allBtns.append(waitToAcceptBtn)
        allBtns.append(finishedBtn)
        setBtn(allBtns)
        
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
        for i in 0..<btns.count {
            btns[i].setTitle(buttonNames[i], forState: UIControlState.Normal)
            btns[i].titleLabel?.font = UIFont.systemFontOfSize(14)
            btns[i].setTitleColor(UIColor(red: 50/255, green: 50/255, blue: 50/255, alpha: 1), forState: UIControlState.Normal)
            btns[i].setTitleColor(UIColor(red: 231/255, green: 31/255, blue: 24/255, alpha: 1), forState: UIControlState.Highlighted)
            btns[i].addTarget(self, action: #selector(MMButtonsOnderLine.btnClk(_:)), forControlEvents: UIControlEvents.TouchUpInside)
            btns[i].tag = i
        }
    }
    
    func btnClk(sender:UIButton)  {
        let i = sender.tag
        
        selectNum = i
        
    }
    
   
    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
        
        self.onderLine.center.x = self.allBtns[self.selectNum].center.x
        for btn in self.allBtns {
            btn.setTitleColor(UIColor(red: 50/255, green: 50/255, blue: 50/255, alpha: 1), forState: UIControlState.Normal)
        }
        
        self.allBtns[self.selectNum].setTitleColor(UIColor(red: 217/255, green: 4/255, blue: 19/255, alpha: 1), forState: UIControlState.Normal)
        self.delegate?.goodsOrderStatesSeparatedBy(self.selectNum)
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
