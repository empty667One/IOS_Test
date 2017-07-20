//
//  TopFourButton.swift
//  TTKG_Merchant
//
//  Created by iosnull on 16/8/5.
//  Copyright © 2016年 yd. All rights reserved.
//

import Foundation
import SnapKit


protocol TopFourButtonViewDelegate {
    //按照排序,请求商品
    func requestGoodsListBySort(name:String,sort:String)
}

class TopFourButtonView:UIView,SortBtnDelegate  {
    
    var delegate:TopFourButtonViewDelegate?
    
    //综合排序按钮
    private var generalSortBtn = SortBtn(frame: CGRect(x: 0, y: 0, width: screenWith/4, height: 40),img:"",title:"综合")
    //销量排序按钮
    private var sellCntSortBtn = SortBtn(frame: CGRect(x: screenWith/4, y: 0, width: screenWith/4, height: 40),img:"",title:"销量")
    //价格排序按钮
    private var priceSortBtn = SortBtn(frame: CGRect(x: 2*screenWith/4, y: 0, width: screenWith/4, height: 40),img:"",title:"价格")
    //筛选按钮
    private var moreSortSelectBtn = SortBtn(frame: CGRect(x: 3*screenWith/4, y: 0, width: screenWith/4, height: 40),img:"",title:"筛选")
    
    var allBtnArr = [SortBtn]()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(generalSortBtn)
        self.addSubview(sellCntSortBtn)
        self.addSubview(priceSortBtn)
        self.addSubview(moreSortSelectBtn)
        
        allBtnArr = [generalSortBtn,sellCntSortBtn,priceSortBtn,moreSortSelectBtn]
        
        generalSortBtn.delegate = self
        sellCntSortBtn.delegate = self
        priceSortBtn.delegate = self
        moreSortSelectBtn.delegate = self
        
        generalSortBtn.snp_makeConstraints { (make) in
            make.left.top.bottom.equalTo(0)
            make.width.equalTo(screenWith/4)
        }
        //generalSortBtn.backgroundColor = UIColor.yellowColor()
        
        sellCntSortBtn.snp_makeConstraints { (make) in
            make.top.bottom.equalTo(0)
            make.width.equalTo(generalSortBtn.snp_width)
            make.left.equalTo(generalSortBtn.snp_right)
        }
        //sellCntSortBtn.backgroundColor = UIColor.blueColor()
        
        priceSortBtn.snp_makeConstraints { (make) in
            make.top.bottom.equalTo(0)
            make.width.equalTo(generalSortBtn.snp_width)
            make.left.equalTo(sellCntSortBtn.snp_right)
        }
        //priceSortBtn.backgroundColor = UIColor.brownColor()
        
        moreSortSelectBtn.snp_makeConstraints { (make) in
            make.top.bottom.equalTo(0)
            make.width.equalTo(generalSortBtn.snp_width)
            make.left.equalTo(priceSortBtn.snp_right)
        }
        //moreSortSelectBtn.backgroundColor = UIColor.purpleColor()
        
        self.sortBtnClk("综合", status: SortBtnStatus.noSort)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension TopFourButtonView{
    
    func resetAllBtnTitleColor()  {
        for item:SortBtn in allBtnArr {
            item.title.textColor = UIColor.blackColor()
        }
        
        priceSortBtn.btnStatus = .noSort
        sellCntSortBtn.btnStatus = .noSort
    }
    
    func sortBtnClk(title:String,status:SortBtnStatus){
        
        
        switch title {
        case "综合":
            generalSortBtn.title.textColor = UIColor.redColor()
            sellCntSortBtn.title.textColor = UIColor.blackColor()
            priceSortBtn.title.textColor = UIColor.blackColor()
            
            priceSortBtn.btnStatus = .noSort
            sellCntSortBtn.btnStatus = .noSort
            break
        case "销量":
            generalSortBtn.title.textColor = UIColor.blackColor()
            sellCntSortBtn.title.textColor = UIColor.redColor()
            priceSortBtn.title.textColor = UIColor.blackColor()
            priceSortBtn.btnStatus = .noSort
            
            if status == .noSort {
                sellCntSortBtn.btnStatus = .sortDown
            }else if status == .sortDown{
                sellCntSortBtn.btnStatus = .sortUp
            }else{
                sellCntSortBtn.btnStatus = .sortDown
            }
            
            break
        case "价格":
            generalSortBtn.title.textColor = UIColor.blackColor()
            sellCntSortBtn.title.textColor = UIColor.blackColor()
            priceSortBtn.title.textColor = UIColor.redColor()
            sellCntSortBtn.btnStatus = .noSort
            
            if status == .noSort {
                priceSortBtn.btnStatus = .sortDown
            }else if status == .sortDown{
                priceSortBtn.btnStatus = .sortUp
            }else{
                priceSortBtn.btnStatus = .sortDown
            }
            break
        case "筛选":
            break
            //moreSortSelectBtn.title.textColor = UIColor.redColor()
        default:
            break
        }
        
        var statusTemp = SortBtnStatus.noSort
        if title == "价格" ||  title == "销量" {
            if status == .sortDown {
                statusTemp = .sortUp
            }else if status == .sortUp {
                statusTemp = .sortDown
            }else{
                statusTemp = .sortDown
            }
        }
        
        
        self.delegate?.requestGoodsListBySort(title, sort: String(statusTemp))
    }
}