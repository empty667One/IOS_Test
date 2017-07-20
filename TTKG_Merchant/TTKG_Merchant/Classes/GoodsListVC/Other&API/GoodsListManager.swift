//
//  ShoppingCarManager.swift
//  TTKG_Merchant
//
//  Created by iosnull on 16/8/3.
//  Copyright © 2016年 yd. All rights reserved.
//

import Foundation

class GoodsListManager {
    
    
    /// 模型发生改变后触发通知
    private var modelChangedCnt = 0{
        didSet{
            shoppingCarModelChanged()
        }
    }
    
    //大品牌
    var bigBrandDatas = [BigBrandData](){
        didSet{
            let notice:NSNotification =  NSNotification(name: "BigBrandDataChanged", object: nil)
            NSNotificationCenter.defaultCenter().postNotification(notice)
        }
    }
    
    
    //商品列表
    var goodsDatas = [MerchantGoodsData](){
        didSet{
            modelChangedCnt += 1
        }
    }
    
    //添加商品列表
    func addGoodsDatas(data:[MerchantGoodsData])  {
        
        for nowGoodsData in data {
            var insertFalg = true //判断商品是否重复标记
            for currentGoodsData in self.goodsDatas {
                if nowGoodsData.productid == currentGoodsData.productid {
                    insertFalg = false
                    break
                }
            }
            
            if insertFalg {//不重复就进行添加
                self.goodsDatas.append(nowGoodsData)
            }
            
        }
        
        //触发器
        modelChangedCnt += 1
    }
    
    /********************************************************/
    /********************************************************/
    /********************************************************/
    
    private func shoppingCarModelChanged(){
        let notice:NSNotification =  NSNotification(name: "GoodsListModelChanged", object: nil)
        NSNotificationCenter.defaultCenter().postNotification(notice)
    }
}