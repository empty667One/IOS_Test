//
//  OrderWaitToPayFooterView.swift
//  ttkg_customer
//
//  Created by iosnull on 16/7/5.
//  Copyright © 2016年 iosnull. All rights reserved.
//

import UIKit
import SnapKit

protocol OrderWaitToPayFooterViewDelegate {
    func cancelOrder(section:Int)
    func payOrder(section:Int)
    func checkLargesses(section:Int)
    func signInOrder(section:Int)
    func deleteOrder(section:Int)
}

//待付款状态
class OrderWaitToPayFooterView: UIView {

    func setValueForView(section:Int,haveLargesses:Bool,allNum:Int,shouldPay:Double) {
        self.section = section
        
        allNumStr = allNum.description
        shouldPayStr  = String(format: "%.2f", shouldPay)//shouldPay.description
        
        if haveLargesses == true {
            self.largessesBtn.hidden = false
            
        }else{
            self.largessesBtn.hidden = true
        }
    }
    
    //购买数量
    private let allNum = UILabel()
    private var allNumStr:String?{
        didSet{
            guard allNumStr != nil else{
                allNum.text = ""
                return
            }
            allNum.text = "共\(allNumStr!)件商品"
        }
    }
    
    //付款额度
    private let shouldPay = UILabel()
    private var shouldPayStr:String?{
        didSet{
            guard shouldPayStr != nil else{
                shouldPay.text = ""
                return
            }
            shouldPay.text = "￥\(shouldPayStr!)"
        }
    }
    
    //实付款标签
    private let actualName = UILabel()
    
    //分割视图
    private let seprateLine = UIView()
    private let seprateLineFirst = UIView()
    
    //该footer的位置标记
    private var section:Int!
    
    var delegate:OrderWaitToPayFooterViewDelegate?
    
    //取消该笔订单
    private let cancelOrderBtn = UIButton()
    //支付该笔订单
    private let payOrderBtn = UIButton()
    
    //该笔订单的赠品信息
    private let largessesBtn = UIButton()
    
    
    @objc private func cancelOrderBtnClk() {
        self.delegate?.cancelOrder(self.section)
    }
    
    @objc private func payOrderBtnClk(section:Int){
        self.delegate?.payOrder(self.section)
    }
    
    @objc private func largessesBtnClk()  {
        self.delegate?.checkLargesses(self.section)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.frame.size.width = screenWith
        self.frame.size.height = 320/8
        
        self.clipsToBounds = true
        
        self.addSubview(shouldPay)
        self.addSubview(actualName)
        self.addSubview(allNum)
        
        shouldPay.font = UIFont.systemFontOfSize(14)
        shouldPay.textAlignment = .Left
        shouldPay.textColor = UIColor(red: 231/255, green: 31/255, blue: 24/255, alpha: 1)
        shouldPay.snp_makeConstraints { (make) in
            make.right.equalTo(self.snp_right).offset(-10)
            make.top.equalTo(0).offset(5)
            make.width.equalTo(80)
            make.height.equalTo(20)
        }
        
        actualName.text = "实付款:"
        actualName.textAlignment = .Right
        actualName.font = UIFont.systemFontOfSize(12)
        actualName.snp_makeConstraints { (make) in
            make.right.equalTo(shouldPay.snp_left).offset(2)
            make.top.equalTo(shouldPay.snp_top)
            make.width.equalTo(45)
            make.height.equalTo(shouldPay.snp_height)
        }
        
        allNum.font = UIFont.systemFontOfSize(12)
        allNum.textAlignment = .Right
        allNum.snp_makeConstraints { (make) in
            make.right.equalTo(actualName.snp_left).offset(-10)
            make.top.equalTo(actualName.snp_top)
            make.left.equalTo(0).offset(75)
            make.height.equalTo(actualName.snp_height)
        }
        
        self.addSubview(seprateLineFirst)
        seprateLineFirst.backgroundColor = UIColor(red: 246/255, green: 246/255, blue: 246/255, alpha: 1)
        seprateLineFirst.snp_makeConstraints { (make) in
            make.left.equalTo(self.snp_left)
            make.right.equalTo(self.snp_right)
            make.height.equalTo(1)
            make.top.equalTo(allNum.snp_bottom).offset(5)
        }
        
        
        self.addSubview(cancelOrderBtn)
        cancelOrderBtn.titleLabel?.font = UIFont.systemFontOfSize(12)
        cancelOrderBtn.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        cancelOrderBtn.layer.borderWidth = 1
        cancelOrderBtn.layer.cornerRadius = 3
        cancelOrderBtn.setTitle("取消订单", forState: UIControlState.Normal)
        cancelOrderBtn.addTarget(self, action: #selector(OrderWaitToPayFooterView.cancelOrderBtnClk), forControlEvents: UIControlEvents.TouchUpInside)
        
        self.addSubview(payOrderBtn)
        payOrderBtn.titleLabel?.font = UIFont.systemFontOfSize(12)
        payOrderBtn.setTitleColor(UIColor(red: 208/255, green: 0, blue: 0, alpha: 1), forState: UIControlState.Normal)
        payOrderBtn.layer.borderWidth = 1
        payOrderBtn.layer.cornerRadius = 3
        payOrderBtn.layer.borderColor = UIColor(red: 231/255, green: 31/255, blue: 24/255, alpha: 1).CGColor
        payOrderBtn.setTitle("立即付款", forState: UIControlState.Normal)
        payOrderBtn.addTarget(self, action: #selector(OrderWaitToPayFooterView.payOrderBtnClk), forControlEvents: UIControlEvents.TouchUpInside)
        
        self.addSubview(largessesBtn)
        largessesBtn.titleLabel?.font = UIFont.systemFontOfSize(12)
        largessesBtn.setTitleColor(UIColor(red: 231/255, green: 31/255, blue: 24/255, alpha: 1), forState: UIControlState.Normal)
        largessesBtn.setTitle("查看赠品>", forState: UIControlState.Normal)
        largessesBtn.addTarget(self, action: #selector(OrderWaitToPayFooterView.largessesBtnClk), forControlEvents: UIControlEvents.TouchUpInside)
        
        
        self.addSubview(seprateLine)
        seprateLine.backgroundColor =  UIColor(red: 246/255, green: 246/255, blue: 246/255, alpha: 1)
        
        payOrderBtn.snp_makeConstraints { (make) in
            make.right.equalTo(self.snp_right).offset(-10)
            make.top.equalTo(seprateLineFirst.snp_bottom).offset(5)
            make.width.equalTo(65)
            make.height.equalTo(20)
        }
        
        cancelOrderBtn.snp_makeConstraints { (make) in
            make.right.equalTo(payOrderBtn.snp_left).offset(-10)
            make.centerY.equalTo(payOrderBtn.snp_centerY)
            make.width.equalTo(payOrderBtn.snp_width)
            make.height.equalTo(payOrderBtn.snp_height)
        }
        
        largessesBtn.snp_makeConstraints { (make) in
            make.left.equalTo(self.snp_left).offset(10)
            make.centerY.equalTo(allNum.snp_centerY)
            make.width.equalTo(60)
            make.height.equalTo(payOrderBtn.snp_height)
        }
        
        seprateLine.snp_makeConstraints { (make) in
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.bottom.equalTo(0).offset(-2)
            make.height.equalTo(6)
        }
        
        self.backgroundColor = UIColor.whiteColor()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

//待发货状态
class OrderWaitToDeliveryFooterView: UIView {
    
    func setValueForView(section:Int,haveLargesses:Bool,allNum:Int,shouldPay:Double) {
        self.section = section
        
        allNumStr = allNum.description
        shouldPayStr  = String(format: "%.2f", shouldPay)
        
        if haveLargesses == true {
            self.largessesBtn.hidden = false
            
        }else{
            self.largessesBtn.hidden = true
        }
    }
    
    //购买数量
    private let allNum = UILabel()
    private var allNumStr:String?{
        didSet{
            guard allNumStr != nil else{
                allNum.text = ""
                return
            }
            allNum.text = "共\(allNumStr!)件商品"
        }
    }
    
    //付款额度
    private let shouldPay = UILabel()
    private var shouldPayStr:String?{
        didSet{
            guard shouldPayStr != nil else{
                shouldPay.text = ""
                return
            }
            shouldPay.text = "￥\(shouldPayStr!)"
        }
    }
    
    //实付款标签
    private let actualName = UILabel()
    
    //分割视图
    private let seprateLine = UIView()
    private let seprateLineFirst = UIView()
    
    //该footer的位置标记
    private var section:Int!
    
    var delegate:OrderWaitToPayFooterViewDelegate?
    
    //该笔订单的赠品信息
    private let largessesBtn = UIButton()
    
    @objc private func largessesBtnClk()  {
        self.delegate?.checkLargesses(self.section)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.frame.size.width = screenWith
        self.frame.size.height = 320/8
        
        self.clipsToBounds = true
        
        self.addSubview(shouldPay)
        self.addSubview(actualName)
        self.addSubview(allNum)
        
        shouldPay.font = UIFont.systemFontOfSize(14)
        shouldPay.textAlignment = .Left
        shouldPay.textColor = UIColor(red: 231/255, green: 31/255, blue: 24/255, alpha: 1)
        shouldPay.snp_makeConstraints { (make) in
            make.right.equalTo(self.snp_right).offset(-10)
            make.top.equalTo(0).offset(5)
            make.width.equalTo(80)
            make.height.equalTo(20)
        }
        
        actualName.text = "实付款:"
        actualName.textAlignment = .Right
        actualName.font = UIFont.systemFontOfSize(12)
        actualName.snp_makeConstraints { (make) in
            make.right.equalTo(shouldPay.snp_left).offset(2)
            make.top.equalTo(shouldPay.snp_top)
            make.width.equalTo(45)
            make.height.equalTo(shouldPay.snp_height)
        }
        
        allNum.font = UIFont.systemFontOfSize(12)
        allNum.textAlignment = .Right
        allNum.snp_makeConstraints { (make) in
            make.right.equalTo(actualName.snp_left).offset(-10)
            make.top.equalTo(actualName.snp_top)
            make.left.equalTo(0).offset(75)
            make.height.equalTo(actualName.snp_height)
        }
        
        self.addSubview(seprateLineFirst)
        seprateLineFirst.backgroundColor = UIColor(red: 246/255, green: 246/255, blue: 246/255, alpha: 1)
        seprateLineFirst.snp_makeConstraints { (make) in
            make.left.equalTo(self.snp_left)
            make.right.equalTo(self.snp_right)
            make.height.equalTo(1)
            make.top.equalTo(allNum.snp_bottom).offset(5)
        }
        
        
        self.addSubview(largessesBtn)
        largessesBtn.titleLabel?.font = UIFont.systemFontOfSize(12)
        largessesBtn.setTitleColor(UIColor(red: 231/255, green: 31/255, blue: 24/255, alpha: 1), forState: UIControlState.Normal)
        largessesBtn.setTitle("查看赠品>", forState: UIControlState.Normal)
        largessesBtn.addTarget(self, action: #selector(OrderWaitToPayFooterView.largessesBtnClk), forControlEvents: UIControlEvents.TouchUpInside)
        
        
        self.addSubview(seprateLine)
        seprateLine.backgroundColor =  UIColor(red: 246/255, green: 246/255, blue: 246/255, alpha: 1)
        
        
        largessesBtn.snp_makeConstraints { (make) in
            make.left.equalTo(self.snp_left).offset(10)
            make.centerY.equalTo(allNum.snp_centerY)
            make.width.equalTo(60)
            make.height.equalTo(20)
        }
        
        seprateLine.snp_makeConstraints { (make) in
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.bottom.equalTo(0).offset(-2)
            make.height.equalTo(6)
        }
        
        self.backgroundColor = UIColor.whiteColor()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//待签收状态
class OrderWaitToSignInFooterView: UIView {
    
    func setValueForView(section:Int,haveLargesses:Bool,allNum:Int,shouldPay:Double) {
        self.section = section
        
        allNumStr = allNum.description
        shouldPayStr  = String(format: "%.2f", shouldPay)
        
        if haveLargesses == true {
            self.largessesBtn.hidden = false
            
        }else{
            self.largessesBtn.hidden = true
        }
    }
    
    //购买数量
    private let allNum = UILabel()
    private var allNumStr:String?{
        didSet{
            guard allNumStr != nil else{
                allNum.text = ""
                return
            }
            allNum.text = "共\(allNumStr!)件商品"
        }
    }
    
    //付款额度
    private let shouldPay = UILabel()
    private var shouldPayStr:String?{
        didSet{
            guard shouldPayStr != nil else{
                shouldPay.text = ""
                return
            }
            shouldPay.text = "￥\(shouldPayStr!)"
        }
    }
    
    //实付款标签
    private let actualName = UILabel()
    
    //分割视图
    private let seprateLine = UIView()
    private let seprateLineFirst = UIView()
    
    //该footer的位置标记
    private var section:Int!
    
    var delegate:OrderWaitToPayFooterViewDelegate?
    
    //取消该笔订单
    //private let cancelOrderBtn = UIButton()
    //支付该笔订单
    private let signInOrderBtn = UIButton()
    
    //该笔订单的赠品信息
    private let largessesBtn = UIButton()
    
    
    
    
    @objc private func signInOrderBtnClk()  {
        self.delegate?.signInOrder(self.section)
    }
    
    @objc private func largessesBtnClk(){
        self.delegate?.checkLargesses(self.section)
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.frame.size.width = screenWith
        self.frame.size.height = 320/8
        
        self.clipsToBounds = true
        
        self.addSubview(shouldPay)
        self.addSubview(actualName)
        self.addSubview(allNum)
        
        shouldPay.font = UIFont.systemFontOfSize(14)
        shouldPay.textAlignment = .Left
        shouldPay.textColor = UIColor(red: 231/255, green: 31/255, blue: 24/255, alpha: 1)
        shouldPay.snp_makeConstraints { (make) in
            make.right.equalTo(self.snp_right).offset(-10)
            make.top.equalTo(0).offset(5)
            make.width.equalTo(80)
            make.height.equalTo(20)
        }
        
        actualName.text = "实付款:"
        actualName.textAlignment = .Right
        actualName.font = UIFont.systemFontOfSize(12)
        actualName.snp_makeConstraints { (make) in
            make.right.equalTo(shouldPay.snp_left).offset(2)
            make.top.equalTo(shouldPay.snp_top)
            make.width.equalTo(45)
            make.height.equalTo(shouldPay.snp_height)
        }
        
        allNum.font = UIFont.systemFontOfSize(12)
        allNum.textAlignment = .Right
        allNum.snp_makeConstraints { (make) in
            make.right.equalTo(actualName.snp_left).offset(-10)
            make.top.equalTo(actualName.snp_top)
            make.left.equalTo(0).offset(75)
            make.height.equalTo(actualName.snp_height)
        }
        
        self.addSubview(seprateLineFirst)
        seprateLineFirst.backgroundColor = UIColor(red: 246/255, green: 246/255, blue: 246/255, alpha: 1)
        seprateLineFirst.snp_makeConstraints { (make) in
            make.left.equalTo(self.snp_left)
            make.right.equalTo(self.snp_right)
            make.height.equalTo(1)
            make.top.equalTo(allNum.snp_bottom).offset(5)
        }
        
        
        
        
        self.addSubview(signInOrderBtn)
        signInOrderBtn.titleLabel?.font = UIFont.systemFontOfSize(12)
        signInOrderBtn.setTitleColor(UIColor(red: 208/255, green: 0, blue: 0, alpha: 1), forState: UIControlState.Normal)
        signInOrderBtn.layer.borderWidth = 1
        signInOrderBtn.layer.cornerRadius = 3
        signInOrderBtn.layer.borderColor = UIColor(red: 231/255, green: 31/255, blue: 24/255, alpha: 1).CGColor
        signInOrderBtn.setTitle("签收订单", forState: UIControlState.Normal)
        signInOrderBtn.addTarget(self, action: #selector(OrderWaitToSignInFooterView.signInOrderBtnClk), forControlEvents: UIControlEvents.TouchUpInside)
        
        self.addSubview(largessesBtn)
        largessesBtn.titleLabel?.font = UIFont.systemFontOfSize(12)
        largessesBtn.setTitleColor(UIColor(red: 231/255, green: 31/255, blue: 24/255, alpha: 1), forState: UIControlState.Normal)
        largessesBtn.setTitle("查看赠品>", forState: UIControlState.Normal)
        largessesBtn.addTarget(self, action: #selector(OrderWaitToSignInFooterView.largessesBtnClk), forControlEvents: UIControlEvents.TouchUpInside)
        
        
        self.addSubview(seprateLine)
        seprateLine.backgroundColor =  UIColor(red: 246/255, green: 246/255, blue: 246/255, alpha: 1)
        
        signInOrderBtn.snp_makeConstraints { (make) in
            make.right.equalTo(self.snp_right).offset(-10)
            make.top.equalTo(seprateLineFirst.snp_bottom).offset(5)
            make.width.equalTo(65)
            make.height.equalTo(20)
        }
        
        
        
        largessesBtn.snp_makeConstraints { (make) in
            make.left.equalTo(self.snp_left).offset(10)
            make.centerY.equalTo(allNum.snp_centerY)
            make.width.equalTo(60)
            make.height.equalTo(signInOrderBtn.snp_height)
        }
        
        seprateLine.snp_makeConstraints { (make) in
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.bottom.equalTo(0).offset(-2)
            make.height.equalTo(6)
        }
        
        self.backgroundColor = UIColor.whiteColor()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
//已经完成状态
class OrderCompleteFooterView: UIView {
    
    func setValueForView(section:Int,haveLargesses:Bool,allNum:Int,shouldPay:Double) {
        self.section = section
        
        allNumStr = allNum.description
        shouldPayStr  = String(format: "%.2f", shouldPay)
        
        if haveLargesses == true {
            self.largessesBtn.hidden = false
            
        }else{
            self.largessesBtn.hidden = true
        }
    }
    
    //购买数量
    private let allNum = UILabel()
    private var allNumStr:String?{
        didSet{
            guard allNumStr != nil else{
                allNum.text = ""
                return
            }
            allNum.text = "共\(allNumStr!)件商品"
        }
    }
    
    //付款额度
    private let shouldPay = UILabel()
    private var shouldPayStr:String?{
        didSet{
            guard shouldPayStr != nil else{
                shouldPay.text = ""
                return
            }
            shouldPay.text = "￥\(shouldPayStr!)"
        }
    }
    
    //实付款标签
    private let actualName = UILabel()
    
    //分割视图
    private let seprateLine = UIView()
    private let seprateLineFirst = UIView()
    
    //该footer的位置标记
    private var section:Int!
    
    var delegate:OrderWaitToPayFooterViewDelegate?
    
    //取消该笔订单
    //private let cancelOrderBtn = UIButton()
    //支付该笔订单
    private let deleteOrderBtn = UIButton()
    
    //该笔订单的赠品信息
    private let largessesBtn = UIButton()
    
    
   
    
    @objc private func deleteOrderBtnClk()  {
        self.delegate?.deleteOrder(self.section)
    }
    
    @objc private func largessesBtnClk()  {
        self.delegate?.checkLargesses(self.section)
    }
   
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.frame.size.width = screenWith
        self.frame.size.height = 320/8
        
        self.clipsToBounds = true
        
        self.addSubview(shouldPay)
        self.addSubview(actualName)
        self.addSubview(allNum)
        
        shouldPay.font = UIFont.systemFontOfSize(14)
        shouldPay.textAlignment = .Left
        shouldPay.textColor = UIColor(red: 231/255, green: 31/255, blue: 24/255, alpha: 1)
        shouldPay.snp_makeConstraints { (make) in
            make.right.equalTo(self.snp_right).offset(-10)
            make.top.equalTo(0).offset(5)
            make.width.equalTo(80)
            make.height.equalTo(20)
        }
        
        actualName.text = "实付款:"
        actualName.textAlignment = .Right
        actualName.font = UIFont.systemFontOfSize(12)
        actualName.snp_makeConstraints { (make) in
            make.right.equalTo(shouldPay.snp_left).offset(2)
            make.top.equalTo(shouldPay.snp_top)
            make.width.equalTo(45)
            make.height.equalTo(shouldPay.snp_height)
        }
        
        allNum.font = UIFont.systemFontOfSize(12)
        allNum.textAlignment = .Right
        allNum.snp_makeConstraints { (make) in
            make.right.equalTo(actualName.snp_left).offset(-10)
            make.top.equalTo(actualName.snp_top)
            make.left.equalTo(0).offset(75)
            make.height.equalTo(actualName.snp_height)
        }
        
        self.addSubview(seprateLineFirst)
        seprateLineFirst.backgroundColor = UIColor(red: 246/255, green: 246/255, blue: 246/255, alpha: 1)
        seprateLineFirst.snp_makeConstraints { (make) in
            make.left.equalTo(self.snp_left)
            make.right.equalTo(self.snp_right)
            make.height.equalTo(1)
            make.top.equalTo(allNum.snp_bottom).offset(5)
        }
        
        
        
        
        self.addSubview(deleteOrderBtn)
        deleteOrderBtn.titleLabel?.font = UIFont.systemFontOfSize(12)
        deleteOrderBtn.setTitleColor(UIColor(red: 208/255, green: 0, blue: 0, alpha: 1), forState: UIControlState.Normal)
        deleteOrderBtn.layer.borderWidth = 1
        deleteOrderBtn.layer.cornerRadius = 3
        deleteOrderBtn.layer.borderColor = UIColor(red: 231/255, green: 31/255, blue: 24/255, alpha: 1).CGColor
        deleteOrderBtn.setTitle("删除订单", forState: UIControlState.Normal)
        deleteOrderBtn.addTarget(self, action: #selector(OrderCompleteFooterView.deleteOrderBtnClk), forControlEvents: UIControlEvents.TouchUpInside)
        
        self.addSubview(largessesBtn)
        largessesBtn.titleLabel?.font = UIFont.systemFontOfSize(12)
        largessesBtn.setTitleColor(UIColor(red: 231/255, green: 31/255, blue: 24/255, alpha: 1), forState: UIControlState.Normal)
        largessesBtn.setTitle("查看赠品>", forState: UIControlState.Normal)
        largessesBtn.addTarget(self, action: #selector(OrderCompleteFooterView.largessesBtnClk), forControlEvents: UIControlEvents.TouchUpInside)
        
        
        self.addSubview(seprateLine)
        seprateLine.backgroundColor =  UIColor(red: 246/255, green: 246/255, blue: 246/255, alpha: 1)
        
        deleteOrderBtn.snp_makeConstraints { (make) in
            make.right.equalTo(self.snp_right).offset(-10)
            make.top.equalTo(seprateLineFirst.snp_bottom).offset(5)
            make.width.equalTo(65)
            make.height.equalTo(20)
        }
        
        
        largessesBtn.snp_makeConstraints { (make) in
            make.left.equalTo(self.snp_left).offset(10)
            make.centerY.equalTo(allNum.snp_centerY)
            make.width.equalTo(60)
            make.height.equalTo(deleteOrderBtn.snp_height)
        }
        
        seprateLine.snp_makeConstraints { (make) in
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.bottom.equalTo(0).offset(-2)
            make.height.equalTo(6)
        }
        
        self.backgroundColor = UIColor.whiteColor()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

