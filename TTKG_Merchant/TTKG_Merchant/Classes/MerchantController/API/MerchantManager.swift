//
//  MerchantManager.swift
//  TTKG_Merchant
//
//  Created by yd on 16/8/10.
//  Copyright © 2016年 yd. All rights reserved.
//

import Foundation

class MerchantManager {
    
    var allGoodsListData = [MerchantGoodsData]()
    
    var hotGoodsListData = [MerchantGoodsData]()
    
    var yhGoodsListData = [MerchantGoodsData]()
    
    var merchantAdListData = [MerchantADDetailData]()
    
    /// 所有商品model发生改变发通知
    private var allGoodsSenderFlag = 0 {
        didSet{
            NSNotificationCenter.defaultCenter().postNotificationName("allGoodsSenderFlag", object: nil)
        }
    }
    /// 热销商品model发生改变发通知
    private var hotGoodsSenderFlag = 0 {
        didSet{
            NSNotificationCenter.defaultCenter().postNotificationName("hotGoodsSenderFlag", object: nil)
        }
    }
    /// 优惠商品model发生改变发通知
    private var yhGoodsSenderFlag = 0 {
        didSet{
            NSNotificationCenter.defaultCenter().postNotificationName("yhGoodsSenderFlag", object: nil)
        }
    }
    /// 商家广告model发生改变发通知
    private var adListDataSenderFlag = 0 {
        didSet{
            NSNotificationCenter.defaultCenter().postNotificationName("adListDataSenderFlag", object: nil)
        }
    }
    /*!
     *  @author hu, 16-08-10 14:08:24
     *
     *  @brief 所有商品数据处理
     */
    func getAllGoodsListData() -> [MerchantGoodsData] {
        return allGoodsListData
    }
    
    func removeAllGoodsListData() {
        allGoodsListData = []
    }
    
    func addAllGoodsListData(allGoodsListDataTemp:[MerchantGoodsData]) {
        
        self.allGoodsListData += allGoodsListDataTemp
        
        
        
        allGoodsSenderFlag += 1
    }
    
    
    /*!
     *  @author hu, 16-08-10 14:08:24
     *
     *  @brief 热销商品数据处理
     */
    
    func getHotGoodsListData() -> [MerchantGoodsData] {
        return hotGoodsListData
    }
    
    func removeHotGoodsListData() {
        hotGoodsListData = []
    }
    
    func addHotGoodsListData(hotGoodsListDataTemp:[MerchantGoodsData]) {
        self.hotGoodsListData += hotGoodsListDataTemp
        hotGoodsSenderFlag += 1
    }
    
    /*!
     *  @author hu, 16-08-10 14:08:43
     *
     *  @brief 优惠商品数据处理
     */
    func getYHGoodsListData() -> [MerchantGoodsData] {
        return yhGoodsListData
    }
    
    func removeYHGoodsListData() {
        yhGoodsListData = []
    }
    
    func addYHGoodsListData(yhGoodsListDataTemp:[MerchantGoodsData]) {
        self.yhGoodsListData += yhGoodsListDataTemp
        yhGoodsSenderFlag += 1
    }
    
    
    /*!
     *  @author hu, 16-08-10 14:08:17
     *
     *  @brief 商家广告数据处理
     */
    func getMerchantAdListData() -> [MerchantADDetailData] {
        return merchantAdListData
    }
    
    func removeMerchantAdListData() {
        merchantAdListData = []
    }
    
    func addMerchantAdListData(merchantAdListDataTemp:[MerchantADDetailData]) {
        self.merchantAdListData = merchantAdListDataTemp
         adListDataSenderFlag += 1
    }
    
    
}

