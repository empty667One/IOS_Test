//
//  ShoppingCarFooterView.swift
//  TTKG_Merchant
//
//  Created by iosnull on 16/8/4.
//  Copyright © 2016年 yd. All rights reserved.
//

import Foundation
import SnapKit


protocol ShoppingCarFooterViewDelegate {
    //更多信息需要进行显示标记
    func moreInfoNeedShow(flag:Bool,section:Int)
}

class ShoppingCarFooterView:UIView {
    
    var delegate:ShoppingCarFooterViewDelegate?
    
    //获取字符串宽高
    func getTextRectSize(text:NSString,font:UIFont,size:CGSize) -> CGRect {
        let attributes = [NSFontAttributeName: font]
        let option = NSStringDrawingOptions.UsesLineFragmentOrigin
        let rect:CGRect = text.boundingRectWithSize(size, options: option, attributes: attributes, context: nil)
        
        return rect;
    }
    
    //当前底部视图伸缩状态
    var showMoreLineFlag = false
    //点击展示更多信息按钮
    var moreInfoShowBtn = UIButton()
    //箭头向上或向下或没有
    var showMoreInfoImg = UIImageView()
    //商家有更多内容需要显示标记
    var moreInfoShowFlag = false {
        didSet{
//            if moreInfoShowFlag {
//                moreInfoShowBtn.hidden = false
//            }else{
//                moreInfoShowBtn.hidden = true
//            }
        }
    }
    //商家要说的话（活动）
    var merchantWantSay = "" {
        didSet{
            //计算需要展示的内容宽高
            let rect = getTextRectSize(merchantWantSay, font: UIFont.systemFontOfSize(9), size: CGSize(width: screenWith-55, height: 100))
            
            //一行不能显示完商家活动信息
            if rect.height > 12 {
                moreInfoShowFlag = true
            }else{
                moreInfoShowFlag = false
            }
            
            merchantActivity.text = merchantWantSay
        }
    }
        
    
    //起配金额
    var shippingAmount = UILabel()
    //商家活动
    private var merchantActivity = UILabel()
    
    private let line = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(shippingAmount)
        self.addSubview(merchantActivity)
        
        shippingAmount.font = UIFont.systemFontOfSize(10)
        merchantActivity.font = UIFont.systemFontOfSize(9)
        merchantActivity.textColor = UIColor.redColor()
        merchantActivity.numberOfLines = 0
        
        shippingAmount.snp_makeConstraints { (make) in
            make.left.equalTo(40)
            make.right.equalTo(0)
            make.height.equalTo(14)
            make.top.equalTo(4)
        }
        
        merchantActivity.snp_makeConstraints { (make) in
            make.left.equalTo(shippingAmount.snp_left)
            make.bottom.equalTo(0).offset(-2)
            make.top.equalTo(shippingAmount.snp_bottom)
            make.right.equalTo(0).offset(-15)
        }
        
        
        self.addSubview(line)
        line.snp_makeConstraints { (make) in
            make.left.right.bottom.equalTo(0)
            make.height.equalTo(1)
        }
        
        line.backgroundColor = UIColor(red: 208/255, green: 208/255, blue: 208/255, alpha: 1)
        
        self.addSubview(moreInfoShowBtn)
        moreInfoShowBtn.snp_makeConstraints { (make) in
            make.left.right.top.bottom.equalTo(0)
//            make.right.equalTo(0).offset(-2)
//            make.bottom.equalTo(self.snp_bottom).offset(-1)
//            make.width.height.equalTo(13)
        }
        
        moreInfoShowBtn.hidden = true
        moreInfoShowBtn.addTarget(self, action: #selector(ShoppingCarFooterView.moreInfoShowBtnClk), forControlEvents: UIControlEvents.TouchUpInside)
        
        self.addSubview(showMoreInfoImg)
        showMoreInfoImg.snp_makeConstraints { (make) in
                make.right.equalTo(0).offset(-2)
                make.bottom.equalTo(self.snp_bottom).offset(-1)
                make.width.height.equalTo(13)
        }
        
        
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //更多信息可以进行显示
    func moreInfoShowBtnClk(){
        self.delegate?.moreInfoNeedShow(showMoreLineFlag,section:self.tag)
    }
    
    
    
}