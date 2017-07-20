//
//  ShowGiftAndPayView.swift
//  TTKG_Merchant
//
//  Created by iosnull on 16/8/19.
//  Copyright © 2016年 yd. All rights reserved.
//

import UIKit
import SnapKit

protocol ShowGiftAndPayViewDelegate {
    func payOrder(order:String,price:Double,time:String,goodsName:String,payMethod:String)
    func cancelRightNowPayOrder()
}

class ShowGiftAndPayView: UIView {
    
    var delegate:ShowGiftAndPayViewDelegate?
    
    var flagTemp = false
    
    //订单号
    private var orderNum = String()
    //时间
    private var time = String()
    //商品名称
    private var goodsTitle = String()
    //支付方式
    private var payMethod = String()
    
    
    
    private var mask = UIView()
    private var contentView = UIView()
    
    //左右间距
    let spareWidth = CGFloat(20)
    
    //获取字符串宽高
    func getTextRectSize(text:NSString,font:UIFont,size:CGSize) -> CGRect {
        let attributes = [NSFontAttributeName: font]
        let option = NSStringDrawingOptions.UsesLineFragmentOrigin
        let rect:CGRect = text.boundingRectWithSize(size, options: option, attributes: attributes, context: nil)
        
        return rect;
    }
    
    //赠品
    var zhengPin = UILabel()
    //分割线01
    var line01 = UIView()
    //赠品信息容器
    var zhengPinContentView = UIView()
    //分割线02
    var line02 = UIView()
    
    //商品总价lable
    var allPriceName  = UILabel()
    var allPrice  = UILabel()
    
    //优惠
    var disCountName = UILabel()
    var disCount     = UILabel()
    
    //订单总价
    var orderAllPriceName = UILabel()
    var orderAllPrice = UILabel()
    
    //分割线03
    var line03 = UIView()
    
    //实际付款
    var actualShouldPayName = UILabel()
    var actualShouldPay = UILabel()
    
    //分割线04
    var line04 = UIView()

    //取消支付
    var cancelBtn = UIButton()
    //支付订单
    var payOrderBtn = UIButton()
    
    
    var gift:[String] = [String]()
    var discountPrice = Double()
    var price = Double()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(mask)
        mask.snp_makeConstraints { (make) in
            make.left.right.top.bottom.equalTo(0)
        }
        mask.backgroundColor = UIColor.grayColor()
        mask.alpha = 0.8
        
        
        self.addSubview(contentView)
        contentView.layer.cornerRadius = 10
        contentView.backgroundColor = UIColor.whiteColor()

    }
    
    convenience init(gift:[String],discountPrice:Double,price:Double,payMethod:String,flag:Bool,orderNum:String,time:String,goodsTitle:String) {
        
        let frame = CGRect(x: 0, y: 0, width: screenWith, height: screenHeigh)
        self.init(frame: frame)
        
        self.gift = gift
        self.discountPrice = discountPrice
        self.price = price
        self.flagTemp = flag
        
        //订单号
        self.orderNum = orderNum
        //时间
        self.time = time
        //商品名称
        self.goodsTitle = goodsTitle
        //支付方式
        self.payMethod = payMethod
        
        var heigh = CGFloat(0)
        for item in self.gift {
            let rect = getTextRectSize(item, font: UIFont.systemFontOfSize(12), size: CGSize(width: screenWith - spareWidth*2, height: 100))
            
            heigh += rect.height
        }
        
        
        if self.gift.count == 0 {//只有4行
            
            let halfWidth = (self.frame.size.width - spareWidth*2)/2
            
            contentView.snp_remakeConstraints { (make) in
                make.centerX.equalTo(self.snp_centerX)
                make.centerY.equalTo(self.snp_centerY)
                make.width.equalTo(self.frame.size.width - spareWidth*2)
                make.height.equalTo(120)
            }
            
            //商品总价
            contentView.addSubview(allPriceName)
            
            allPriceName.font = UIFont.systemFontOfSize(13)
            allPriceName.snp_makeConstraints(closure: { (make) in
                make.left.equalTo(contentView.snp_left).offset(20)
                make.top.equalTo(contentView.snp_top).offset(20)
                make.width.equalTo(halfWidth)
                make.height.equalTo(18)
            })
            allPriceName.text = "商品总价"
            
            
            contentView.addSubview(allPrice)
            allPrice.snp_makeConstraints(closure: { (make) in
                make.top.equalTo(20)
                make.right.equalTo(contentView.snp_right).offset(-40)
                make.width.equalTo(halfWidth)
                make.height.equalTo(18)
            })
            allPrice.font = UIFont.systemFontOfSize(15)
            allPrice.text = "￥ " + String(format: "%.2f", price)
            allPrice.textAlignment = .Right
            allPrice.textColor = UIColor.grayColor()
            
            //优惠
            contentView.addSubview(disCountName)
            disCountName.font = UIFont.systemFontOfSize(13)
            disCountName.snp_makeConstraints(closure: { (make) in
                make.left.equalTo(allPriceName.snp_left)
                make.width.equalTo(allPriceName.snp_width)
                make.height.equalTo(allPriceName.snp_height)
                make.top.equalTo(allPriceName.snp_bottom)
            })
            disCountName.text = "优惠"
            
            contentView.addSubview(disCount)
            disCount.snp_makeConstraints(closure: { (make) in
                make.top.equalTo(disCountName.snp_top)
                make.right.equalTo(contentView.snp_right).offset(-40)
                make.width.equalTo(halfWidth)
                make.height.equalTo(18)
            })
            disCount.text = "- ￥ " + String(format: "%.2f", discountPrice)
            disCount.font = UIFont.systemFontOfSize(13)
            disCount.textAlignment = .Right
            disCount.textColor = UIColor.grayColor()
            
            //分割线
            contentView.addSubview(line03)
            line03.snp_makeConstraints(closure: { (make) in
                make.left.right.equalTo(0)
                make.height.equalTo(1)
                make.top.equalTo(disCountName.snp_bottom)
            })
            line03.backgroundColor = UIColor(red: 231/255, green: 231/255, blue: 231/255, alpha: 1)
            //实付款
            contentView.addSubview(actualShouldPayName)
            actualShouldPayName.font = UIFont.systemFontOfSize(13)
            actualShouldPayName.snp_makeConstraints(closure: { (make) in
                
                make.top.equalTo(line03.snp_bottom)
                make.left.equalTo(allPriceName.snp_left)
                make.width.equalTo(allPriceName.snp_width)
                make.height.equalTo(allPriceName.snp_height)
            })
            actualShouldPayName.text = "实付款(" + payMethod + ")"
            
            contentView.addSubview(actualShouldPay)
            actualShouldPay.snp_makeConstraints(closure: { (make) in
                make.top.equalTo(actualShouldPayName.snp_top)
                make.right.equalTo(contentView.snp_right).offset(-40)
                make.width.equalTo(halfWidth)
                make.height.equalTo(18)
            })
            
            actualShouldPay.text = "￥ " + String(format: "%.2f",price - discountPrice)
            actualShouldPay.font = UIFont.systemFontOfSize(15)
            actualShouldPay.textAlignment = .Right
            actualShouldPay.textColor = UIColor.redColor()
            
            //分割线
            contentView.addSubview(line04)
            line04.snp_makeConstraints(closure: { (make) in
                make.left.right.equalTo(0)
                make.height.equalTo(1)
                make.top.equalTo(actualShouldPayName.snp_bottom)
            })
            line04.backgroundColor = UIColor(red: 231/255, green: 231/255, blue: 231/255, alpha: 1)
            
            
            
            let line = UIView()
            contentView.addSubview(line)
            line.snp_makeConstraints(closure: { (make) in
                make.top.equalTo(line04.snp_bottom)
                make.centerX.equalTo(line04.snp_centerX)
                make.bottom.equalTo(contentView.snp_bottom)
                make.width.equalTo(1)
                //make.left.equalTo(contentView.frame.size.width/2).offset(-0.5)
                
            })
            line.backgroundColor = UIColor(red: 231/255, green: 231/255, blue: 231/255, alpha: 1)
            
            if flagTemp {
            
            //取消支付
            contentView.addSubview(cancelBtn)
            cancelBtn.snp_makeConstraints(closure: { (make) in
                make.top.equalTo(line.snp_top)
                make.left.equalTo(contentView.snp_left)
                make.right.equalTo(line.snp_left)
                make.bottom.equalTo(line.snp_bottom)
            })
            cancelBtn.setTitle("取消支付", forState: UIControlState.Normal)
            cancelBtn.setTitleColor(UIColor.grayColor(), forState: UIControlState.Normal)
            cancelBtn.addTarget(self, action: Selector("cancelBtnClk"), forControlEvents: UIControlEvents.TouchUpInside)
            
            //确认支付
            contentView.addSubview(payOrderBtn)
            payOrderBtn.snp_makeConstraints(closure: { (make) in
                make.top.equalTo(line.snp_top)
                make.right.bottom.equalTo(contentView.snp_right)
                make.left.equalTo(line.snp_right)
                make.bottom.equalTo(line.snp_bottom)
            })
            payOrderBtn.setTitle("确认支付", forState: UIControlState.Normal)
            payOrderBtn.setTitleColor(UIColor.redColor(), forState: UIControlState.Normal)
            payOrderBtn.addTarget(self, action: #selector(ShowGiftAndPayView.payOrderBtnClk), forControlEvents: UIControlEvents.TouchUpInside)
            }else{
                let okBtn = UIButton()
                contentView.addSubview(okBtn)
                okBtn.snp_makeConstraints(closure: { (make) in
                    make.left.right.bottom.equalTo(0)
                    make.top.equalTo(line.snp_top)
                })
                okBtn.setTitle("确定", forState: UIControlState.Normal)
                okBtn.addTarget(self, action: #selector(ShowGiftAndPayView.cancelBtnClk), forControlEvents: UIControlEvents.TouchUpInside)
                okBtn.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
                line.hidden = true
            }
            
        }else{//添加赠品信息高度 + 赠品标签高度
            let width = (self.frame.size.width - spareWidth*2)
            let halfWidth = (self.frame.size.width - spareWidth*2)/2
            
            //所有lable的高度
            var allGiftLableHeight = [CGFloat]()
            
            //计算每所有标签所占用的高度
            for item in gift {
                let rect = getTextRectSize(item, font: UIFont.systemFontOfSize(12), size: CGSize(width: width, height: 120))
                
                allGiftLableHeight.append(rect.height)
                
                heigh += rect.height
            }
            
            var startTop01 = CGFloat()
            //计算label起始位置
            for num in 0..<allGiftLableHeight.count {
                startTop01 += allGiftLableHeight[num]
            }
            
            //设定容器位置约束
            contentView.snp_makeConstraints { (make) in
                make.centerX.equalTo(self.snp_centerX)
                make.centerY.equalTo(self.snp_centerY)
                make.width.equalTo(self.frame.size.width - spareWidth*2)
                make.height.equalTo(startTop01 + 130)
            }
            
            
            let giftTitle = UILabel()
            contentView.addSubview(giftTitle)
            giftTitle.snp_makeConstraints(closure: { (make) in
                make.left.right.top.equalTo(0)
                make.height.equalTo(30)
            })
            giftTitle.textAlignment = .Center
            giftTitle.textColor = UIColor.redColor()
            giftTitle.text = "赠品"
            giftTitle.font = UIFont.systemFontOfSize(14)
        
            //添加背景视图
            let backgroundView = UIView()
            contentView.addSubview(backgroundView)
            backgroundView.snp_makeConstraints(closure: { (make) in
                make.top.equalTo(30)
                make.right.equalTo(0)
                make.left.equalTo(0)
                make.height.equalTo(startTop01)
            })
            backgroundView.backgroundColor = UIColor(red: 252/255, green: 252/255, blue: 252/255, alpha: 1)
            backgroundView.layer.borderColor = UIColor(red: 231/255, green: 231/255, blue: 231/255, alpha: 1).CGColor
            backgroundView.layer.borderWidth = CGFloat(1)
            
            
            //添加标签
            for index in 0..<gift.count {
                var lable = UILabel()
                lable.numberOfLines = 0
                lable.font = UIFont.systemFontOfSize(11.5)
                lable.text = gift[index]
                lable.textAlignment = .Left
                lable.textColor = UIColor.grayColor()
                
                var startTop = CGFloat()
                
                //计算label起始位置
                for num in 0..<index {
                    startTop += allGiftLableHeight[num]
                }
                
                //添加label并设置约束
                contentView.addSubview(lable)
                lable.snp_makeConstraints(closure: { (make) in
                    make.left.equalTo(contentView.snp_left).offset(20)
                    make.right.equalTo(contentView.snp_right).offset(-20)
                    make.top.equalTo(30 + startTop)
                    make.height.equalTo(allGiftLableHeight[index])
                })
                
            }
            
            
            //商品总价
            contentView.addSubview(allPriceName)
            
            allPriceName.font = UIFont.systemFontOfSize(12)
            allPriceName.snp_makeConstraints(closure: { (make) in
                make.left.equalTo(contentView.snp_left).offset(20)
                make.top.equalTo(startTop01 + 32)
                make.width.equalTo(halfWidth)
                make.height.equalTo(18)
            })
            allPriceName.text = "商品总价"
            
            
            
            
            
            contentView.addSubview(allPrice)
            allPrice.snp_makeConstraints(closure: { (make) in
                make.top.equalTo(allPriceName.snp_top)
                make.right.equalTo(contentView.snp_right).offset(-40)
                make.width.equalTo(halfWidth)
                make.height.equalTo(18)
            })
            allPrice.font = UIFont.systemFontOfSize(13)
            allPrice.text = "￥ " + String(format: "%.2f", price)
            allPrice.textAlignment = .Right
            allPrice.textColor = UIColor.grayColor()
            
            //优惠
            contentView.addSubview(disCountName)
            disCountName.font = UIFont.systemFontOfSize(12)
            disCountName.snp_makeConstraints(closure: { (make) in
                make.left.equalTo(allPriceName.snp_left)
                make.width.equalTo(allPriceName.snp_width)
                make.height.equalTo(allPriceName.snp_height)
                make.top.equalTo(allPriceName.snp_bottom)
            })
            disCountName.text = "优惠"
            
            contentView.addSubview(disCount)
            disCount.snp_makeConstraints(closure: { (make) in
                make.top.equalTo(disCountName.snp_top)
                make.right.equalTo(contentView.snp_right).offset(-40)
                make.width.equalTo(halfWidth)
                make.height.equalTo(18)
            })
            disCount.text = "- ￥ " + String(format: "%.2f", discountPrice)
            disCount.font = UIFont.systemFontOfSize(11)
            disCount.textAlignment = .Right
            disCount.textColor = UIColor.grayColor()
            
            //分割线
            contentView.addSubview(line03)
            line03.snp_makeConstraints(closure: { (make) in
                make.left.right.equalTo(0)
                make.height.equalTo(1)
                make.top.equalTo(disCountName.snp_bottom)
            })
            line03.backgroundColor = UIColor(red: 231/255, green: 231/255, blue: 231/255, alpha: 1)
            //实付款
            contentView.addSubview(actualShouldPayName)
            actualShouldPayName.font = UIFont.systemFontOfSize(12)
            actualShouldPayName.snp_makeConstraints(closure: { (make) in
                
                make.top.equalTo(line03.snp_bottom)
                make.left.equalTo(allPriceName.snp_left)
                make.width.equalTo(allPriceName.snp_width)
                make.height.equalTo(allPriceName.snp_height)
            })
            actualShouldPayName.text = "实付款(" + payMethod + ")"
            
            contentView.addSubview(actualShouldPay)
            actualShouldPay.snp_makeConstraints(closure: { (make) in
                make.top.equalTo(actualShouldPayName.snp_top)
                make.right.equalTo(contentView.snp_right).offset(-40)
                make.width.equalTo(halfWidth)
                make.height.equalTo(18)
            })
            
            actualShouldPay.text = "￥ " + String(format: "%.2f",price - discountPrice)
            actualShouldPay.font = UIFont.systemFontOfSize(13)
            actualShouldPay.textAlignment = .Right
            actualShouldPay.textColor = UIColor.redColor()
            
            //分割线
            contentView.addSubview(line04)
            line04.snp_makeConstraints(closure: { (make) in
                make.left.right.equalTo(0)
                make.height.equalTo(1)
                make.top.equalTo(actualShouldPayName.snp_bottom)
            })
            line04.backgroundColor = UIColor(red: 231/255, green: 231/255, blue: 231/255, alpha: 1)
            
            
            
            let line = UIView()
            contentView.addSubview(line)
            line.snp_makeConstraints(closure: { (make) in
                make.top.equalTo(line04.snp_bottom)
                make.centerX.equalTo(line04.snp_centerX)
                make.bottom.equalTo(contentView.snp_bottom)
                make.width.equalTo(1)
                //make.left.equalTo(contentView.frame.size.width/2).offset(-0.5)
                
            })
            line.backgroundColor = UIColor(red: 231/255, green: 231/255, blue: 231/255, alpha: 1)
            
            
            if flagTemp {
            
            //取消支付
            contentView.addSubview(cancelBtn)
            cancelBtn.snp_makeConstraints(closure: { (make) in
                make.top.equalTo(line.snp_top)
                make.left.equalTo(contentView.snp_left)
                make.right.equalTo(line.snp_left)
                make.bottom.equalTo(line.snp_bottom)
            })
            cancelBtn.setTitle("取消支付", forState: UIControlState.Normal)
            cancelBtn.setTitleColor(UIColor.grayColor(), forState: UIControlState.Normal)
            cancelBtn.addTarget(self, action: Selector("cancelBtnClk"), forControlEvents: UIControlEvents.TouchUpInside)
            
            //确认支付
            contentView.addSubview(payOrderBtn)
            payOrderBtn.snp_makeConstraints(closure: { (make) in
                make.top.equalTo(line.snp_top)
                make.right.bottom.equalTo(contentView.snp_right)
                make.left.equalTo(line.snp_right)
                make.bottom.equalTo(line.snp_bottom)
            })
            payOrderBtn.setTitle("确认支付", forState: UIControlState.Normal)
            payOrderBtn.setTitleColor(UIColor.redColor(), forState: UIControlState.Normal)
            payOrderBtn.addTarget(self, action: #selector(ShowGiftAndPayView.payOrderBtnClk), forControlEvents: UIControlEvents.TouchUpInside)
            }else{
                let okBtn = UIButton()
                contentView.addSubview(okBtn)
                okBtn.snp_makeConstraints(closure: { (make) in
                    make.left.right.bottom.equalTo(0)
                    make.top.equalTo(line.snp_top)
                })
                okBtn.setTitle("确定", forState: UIControlState.Normal)
                okBtn.addTarget(self, action: Selector("cancelBtnClk"), forControlEvents: UIControlEvents.TouchUpInside)
                okBtn.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
                line.hidden = true
            }
            
        }
        
        //self.backgroundColor = UIColor.brownColor()
    }
    
    
    func cancelBtnClk()  {
        delegate?.cancelRightNowPayOrder()
        self.removeFromSuperview()
    }
    
    func payOrderBtnClk(){

        delegate?.payOrder(self.orderNum, price: self.price - self.discountPrice, time: self.time, goodsName: self.goodsTitle, payMethod: self.payMethod)
//        cancelBtnClk()
        self.removeFromSuperview()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
