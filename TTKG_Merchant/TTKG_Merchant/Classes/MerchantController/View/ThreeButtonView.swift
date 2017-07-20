//
//  ThreeButtonView.swift
//  TTKG_Merchant
//
//  Created by yd on 16/8/11.
//  Copyright © 2016年 yd. All rights reserved.
//

import UIKit
import SnapKit


enum ThreeSortBtn {
    case noselect
    case saleNumUp
    case saleNumDown
    case priceUp
    case priceDown
}

protocol ThreeBtnForGoodsButtonViewDelegate {
    func getSortButtomStatus(status:ThreeSortBtn)
}

//MARK:
/****
 
 热销商品
 
***/
class ThreeForHotGoodsButtonView: UICollectionReusableView {
    
    var delegate : ThreeBtnForGoodsButtonViewDelegate?
    
    
    var defaultBtn = UIButton()    //默认按钮
    var saleNumBtn = UIButton()    //销量按钮
    var priceBtn = UIButton()      //价格按钮
    
    var sortBtnSelectStatus = ThreeSortBtn.noselect
    
    
    override func applyLayoutAttributes(layoutAttributes: UICollectionViewLayoutAttributes) {
        
        self.addSubview(defaultBtn)
        self.addSubview(saleNumBtn)
        self.addSubview(priceBtn)
        
        //默认
        defaultBtn.snp_makeConstraints { (make) in
            make.left.top.bottom.equalTo(0)
            make.width.equalTo(screenWith/3)
        }
        
        defaultBtn.setTitle("默认", forState: UIControlState.Normal)
        defaultBtn.titleLabel?.font = UIFont.systemFontOfSize(14)
        defaultBtn.setTitleColor(UIColor.redColor(), forState: UIControlState.Normal)
        defaultBtn.addTarget(self, action: #selector(ThreeForHotGoodsButtonView.requestDefaultHotGoodsData(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        
        //销量
        saleNumBtn.titleLabel?.font = UIFont.systemFontOfSize(14)
        saleNumBtn.snp_makeConstraints { (make) in
            make.left.equalTo(defaultBtn.snp_right)
            make.top.bottom.equalTo(0)
            make.width.equalTo(screenWith/3)
        }
        saleNumBtn.setImage(UIImage(named: "noSort"), forState: UIControlState.Normal)
        saleNumBtn.imageEdgeInsets = UIEdgeInsets(top: 0, left: 72, bottom: 0, right: 0)
        saleNumBtn.setTitle("销量", forState: UIControlState.Normal)
        saleNumBtn.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        saleNumBtn.addTarget(self, action: #selector(ThreeForHotGoodsButtonView.requestSaleNumHotGoodsData(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        
        //价格
        priceBtn.titleLabel?.font = UIFont.systemFontOfSize(14)
        priceBtn.snp_makeConstraints { (make) in
            make.left.equalTo(saleNumBtn.snp_right)
            make.top.bottom.right.equalTo(0)
        }
        priceBtn.setImage(UIImage(named: "noSort"), forState: UIControlState.Normal)
        priceBtn.imageEdgeInsets = UIEdgeInsets(top: 0, left: 72, bottom: 0, right: 0)
        priceBtn.addTarget(self, action: #selector(ThreeForHotGoodsButtonView.requestPriceHotGoodsData(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        priceBtn.setTitle("价格", forState: UIControlState.Normal)
        priceBtn.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        
        
    }
    
    
    //点击事件
    func requestDefaultHotGoodsData(sender:UIButton) {
        saleNumBtn.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        priceBtn.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        saleNumBtn.setImage(UIImage(named: "noSort"), forState: UIControlState.Normal)
        defaultBtn.setTitleColor(UIColor.redColor(), forState: UIControlState.Normal)
        priceBtn.setImage(UIImage(named: "noSort"), forState: UIControlState.Normal)
        sortBtnSelectStatus = ThreeSortBtn.noselect
        self.delegate?.getSortButtomStatus(sortBtnSelectStatus)
    }
    
    func requestPriceHotGoodsData(sender:UIButton) {
        saleNumBtn.setImage(UIImage(named: "noSort"), forState: UIControlState.Normal)
        defaultBtn.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        saleNumBtn.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        sender.setTitleColor(UIColor.redColor(), forState: .Normal)
        if sender.selected {
            
            sortBtnSelectStatus = ThreeSortBtn.priceUp
            priceBtn.setImage(UIImage(named: "sortUp"), forState: UIControlState.Normal)
            self.delegate?.getSortButtomStatus(sortBtnSelectStatus)
            sender.selected = false
        }else{
            
            priceBtn.setImage(UIImage(named: "sortDown"), forState: UIControlState.Normal)
            sortBtnSelectStatus = ThreeSortBtn.priceDown
            self.delegate?.getSortButtomStatus(sortBtnSelectStatus)
            sender.selected = true
        }
        
    }
    
    func requestSaleNumHotGoodsData(sender:UIButton) {
        priceBtn.setImage(UIImage(named: "noSort"), forState: UIControlState.Normal)
        defaultBtn.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        priceBtn.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        sender.setTitleColor(UIColor.redColor(), forState: .Normal)
        if sender.selected {
            
            sortBtnSelectStatus = ThreeSortBtn.saleNumUp
            saleNumBtn.setImage(UIImage(named: "sortUp"), forState: UIControlState.Normal)
            self.delegate?.getSortButtomStatus(sortBtnSelectStatus)
            sender.selected = false
        }else{
            
            saleNumBtn.setImage(UIImage(named: "sortDown"), forState: UIControlState.Normal)
            sortBtnSelectStatus = ThreeSortBtn.saleNumDown
            self.delegate?.getSortButtomStatus(sortBtnSelectStatus)
            sender.selected = true
        }
    }
    

}


//MARK:
/**
 
 全部商品
 
 **/
class ThreeForAllGoodsButtonView: UICollectionReusableView {
    
    var delegate : ThreeBtnForGoodsButtonViewDelegate?
    
    
    var defaultBtn = UIButton()
    var saleNumBtn = UIButton()
    var priceBtn = UIButton()
    
    var sortBtnSelectStatus = ThreeSortBtn.noselect
    
    
    override func applyLayoutAttributes(layoutAttributes: UICollectionViewLayoutAttributes) {
        
        self.addSubview(defaultBtn)
        self.addSubview(saleNumBtn)
        self.addSubview(priceBtn)
        
        //默认
        defaultBtn.snp_makeConstraints { (make) in
            make.left.top.bottom.equalTo(0)
            make.width.equalTo(screenWith/3)
        }
        
        defaultBtn.setTitle("默认", forState: UIControlState.Normal)
        defaultBtn.titleLabel?.font = UIFont.systemFontOfSize(14)
        defaultBtn.setTitleColor(UIColor.redColor(), forState: UIControlState.Normal)
        defaultBtn.addTarget(self, action: #selector(ThreeForHotGoodsButtonView.requestDefaultHotGoodsData(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        
        
        //销量
        saleNumBtn.titleLabel?.font = UIFont.systemFontOfSize(14)
        saleNumBtn.snp_makeConstraints { (make) in
            make.left.equalTo(defaultBtn.snp_right)
            make.top.bottom.equalTo(0)
            make.width.equalTo(screenWith/3)
        }
        saleNumBtn.setImage(UIImage(named: "noSort"), forState: UIControlState.Normal)
        saleNumBtn.imageEdgeInsets = UIEdgeInsets(top: 0, left: 72, bottom: 0, right: 0)
        saleNumBtn.setTitle("销量", forState: UIControlState.Normal)
        saleNumBtn.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        saleNumBtn.addTarget(self, action: #selector(ThreeForHotGoodsButtonView.requestSaleNumHotGoodsData(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        
        //价格
        priceBtn.titleLabel?.font = UIFont.systemFontOfSize(14)
        priceBtn.snp_makeConstraints { (make) in
            make.left.equalTo(saleNumBtn.snp_right)
            make.top.bottom.right.equalTo(0)
        }
        priceBtn.setImage(UIImage(named: "noSort"), forState: UIControlState.Normal)
        priceBtn.imageEdgeInsets = UIEdgeInsets(top: 0, left: 72, bottom: 0, right: 0)
        priceBtn.addTarget(self, action: #selector(ThreeForHotGoodsButtonView.requestPriceHotGoodsData(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        priceBtn.setTitle("价格", forState: UIControlState.Normal)
        priceBtn.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        
        
    }
    
    
    //点击事件
    func requestDefaultHotGoodsData(sender:UIButton) {
        saleNumBtn.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        priceBtn.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        saleNumBtn.setImage(UIImage(named: "noSort"), forState: UIControlState.Normal)
        defaultBtn.setTitleColor(UIColor.redColor(), forState: UIControlState.Normal)
        priceBtn.setImage(UIImage(named: "noSort"), forState: UIControlState.Normal)
        sortBtnSelectStatus = ThreeSortBtn.noselect
        self.delegate?.getSortButtomStatus(sortBtnSelectStatus)
    }
    
    func requestPriceHotGoodsData(sender:UIButton) {
        saleNumBtn.setImage(UIImage(named: "noSort"), forState: UIControlState.Normal)
        defaultBtn.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        saleNumBtn.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        sender.setTitleColor(UIColor.redColor(), forState: .Normal)
        if sender.selected {
            
            sortBtnSelectStatus = ThreeSortBtn.priceUp
            priceBtn.setImage(UIImage(named: "sortUp"), forState: UIControlState.Normal)
            self.delegate?.getSortButtomStatus(sortBtnSelectStatus)
            sender.selected = false
        }else{
            
            priceBtn.setImage(UIImage(named: "sortDown"), forState: UIControlState.Normal)
            sortBtnSelectStatus = ThreeSortBtn.priceDown
            self.delegate?.getSortButtomStatus(sortBtnSelectStatus)
            sender.selected = true
        }
        
    }
    
    func requestSaleNumHotGoodsData(sender:UIButton) {
        priceBtn.setImage(UIImage(named: "noSort"), forState: UIControlState.Normal)
        defaultBtn.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        priceBtn.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        sender.setTitleColor(UIColor.redColor(), forState: .Normal)
        if sender.selected {
            
            sortBtnSelectStatus = ThreeSortBtn.saleNumUp
            saleNumBtn.setImage(UIImage(named: "sortUp"), forState: UIControlState.Normal)
            self.delegate?.getSortButtomStatus(sortBtnSelectStatus)
            sender.selected = false
        }else{
            
            saleNumBtn.setImage(UIImage(named: "sortDown"), forState: UIControlState.Normal)
            sortBtnSelectStatus = ThreeSortBtn.saleNumDown
            self.delegate?.getSortButtomStatus(sortBtnSelectStatus)
            sender.selected = true
        }
    }

    
}

//MARK:

/**
 
 优惠商品
 
 ***/
class ThreeForYHGoodsButtonView: UICollectionReusableView {
    
    var delegate : ThreeBtnForGoodsButtonViewDelegate?
    
    
    var defaultBtn = UIButton()
    var saleNumBtn = UIButton()
    var priceBtn = UIButton()
    
    var sortBtnSelectStatus = ThreeSortBtn.noselect
    
    
    override func applyLayoutAttributes(layoutAttributes: UICollectionViewLayoutAttributes) {
        
        self.addSubview(defaultBtn)
        self.addSubview(saleNumBtn)
        self.addSubview(priceBtn)
        
        //默认
        defaultBtn.snp_makeConstraints { (make) in
            make.left.top.bottom.equalTo(0)
            make.width.equalTo(screenWith/3)
        }
        
        defaultBtn.setTitle("默认", forState: UIControlState.Normal)
        defaultBtn.titleLabel?.font = UIFont.systemFontOfSize(14)
        defaultBtn.setTitleColor(UIColor.redColor(), forState: UIControlState.Normal)
        defaultBtn.addTarget(self, action: #selector(ThreeForHotGoodsButtonView.requestDefaultHotGoodsData(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        
        
        //销量
        saleNumBtn.titleLabel?.font = UIFont.systemFontOfSize(14)
        saleNumBtn.snp_makeConstraints { (make) in
            make.left.equalTo(defaultBtn.snp_right)
            make.top.bottom.equalTo(0)
            make.width.equalTo(screenWith/3)
        }
        saleNumBtn.setImage(UIImage(named: "noSort"), forState: UIControlState.Normal)
        saleNumBtn.imageEdgeInsets = UIEdgeInsets(top: 0, left: 72, bottom: 0, right: 0)
        saleNumBtn.setTitle("销量", forState: UIControlState.Normal)
        saleNumBtn.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        saleNumBtn.addTarget(self, action: #selector(ThreeForHotGoodsButtonView.requestSaleNumHotGoodsData(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        
        
        //价格
        priceBtn.titleLabel?.font = UIFont.systemFontOfSize(14)
        priceBtn.snp_makeConstraints { (make) in
            make.left.equalTo(saleNumBtn.snp_right)
            make.top.bottom.right.equalTo(0)
        }
        priceBtn.setImage(UIImage(named: "noSort"), forState: UIControlState.Normal)
        priceBtn.imageEdgeInsets = UIEdgeInsets(top: 0, left: 72, bottom: 0, right: 0)
        priceBtn.addTarget(self, action: #selector(ThreeForHotGoodsButtonView.requestPriceHotGoodsData(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        priceBtn.setTitle("价格", forState: UIControlState.Normal)
        priceBtn.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        
        
    }
    
    
    //点击事件
    func requestDefaultHotGoodsData(sender:UIButton) {
        saleNumBtn.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        priceBtn.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        saleNumBtn.setImage(UIImage(named: "noSort"), forState: UIControlState.Normal)
        defaultBtn.setTitleColor(UIColor.redColor(), forState: UIControlState.Normal)
        priceBtn.setImage(UIImage(named: "noSort"), forState: UIControlState.Normal)
        sortBtnSelectStatus = ThreeSortBtn.noselect
        self.delegate?.getSortButtomStatus(sortBtnSelectStatus)
    }
    
    func requestPriceHotGoodsData(sender:UIButton) {
        saleNumBtn.setImage(UIImage(named: "noSort"), forState: UIControlState.Normal)
        defaultBtn.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        saleNumBtn.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        sender.setTitleColor(UIColor.redColor(), forState: .Normal)
        if sender.selected {
            
            sortBtnSelectStatus = ThreeSortBtn.priceUp
            priceBtn.setImage(UIImage(named: "sortUp"), forState: UIControlState.Normal)
            self.delegate?.getSortButtomStatus(sortBtnSelectStatus)
            sender.selected = false
        }else{
            
            priceBtn.setImage(UIImage(named: "sortDown"), forState: UIControlState.Normal)
            sortBtnSelectStatus = ThreeSortBtn.priceDown
            self.delegate?.getSortButtomStatus(sortBtnSelectStatus)
            sender.selected = true
        }
        
    }
    
    func requestSaleNumHotGoodsData(sender:UIButton) {
        priceBtn.setImage(UIImage(named: "noSort"), forState: UIControlState.Normal)
        defaultBtn.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        priceBtn.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        sender.setTitleColor(UIColor.redColor(), forState: .Normal)
        if sender.selected {
            
            sortBtnSelectStatus = ThreeSortBtn.saleNumUp
            saleNumBtn.setImage(UIImage(named: "sortUp"), forState: UIControlState.Normal)
            self.delegate?.getSortButtomStatus(sortBtnSelectStatus)
            sender.selected = false
        }else{
            
            saleNumBtn.setImage(UIImage(named: "sortDown"), forState: UIControlState.Normal)
            sortBtnSelectStatus = ThreeSortBtn.saleNumDown
            self.delegate?.getSortButtomStatus(sortBtnSelectStatus)
            sender.selected = true
        }
    }

    
}


