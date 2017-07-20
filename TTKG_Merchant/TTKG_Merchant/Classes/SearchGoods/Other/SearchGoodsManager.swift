//
//  SearchGoodsManager.swift
//  ttkg_customer
//
//  Created by iosnull on 16/7/12.
//  Copyright © 2016年 iosnull. All rights reserved.
//

import Foundation


class SearchGoodsManager {
    //热门搜索数据
    var hotSearchList = [MerchantGoodsData]()
    
    //普通搜索数据
    var normalSearchList = [MerchantGoodsData]()
    
    //触发器
    private var sendFlag = 0 {
        didSet{//发通知给控制器
            NSNotificationCenter.defaultCenter().postNotification(NSNotification(name: "hotGoodsChanged", object: nil))
        }
    }
    
    private var normalSendFlag = 0 {
        didSet{
            NSNotificationCenter.defaultCenter().postNotification(NSNotification(name: "normalSearchGoodsChanged", object: nil))
        }
    }
    
    /***************************************************************/
    //移除普通搜索数据
    func removeNormalSearchGoods()  {
        self.normalSearchList = []
        normalSendFlag += 1
    }
    
    //添加普通搜索数据
    func addNormalSearchGoods(normalSearchList:[MerchantGoodsData]) {
        self.normalSearchList = normalSearchList
        normalSendFlag += 1
    }
    
    //返回普通搜索数据
    func getNormalSearchGoods() -> [MerchantGoodsData] {
        return self.normalSearchList
    }
    
    /***************************************************************/
    //移除热门商品信息
    func removeHotGoods()  {
        hotSearchList = []
    }
    
    //添加热门商品信息
    func addHotGoods(hotSearchList:[MerchantGoodsData])  {
        self.hotSearchList = hotSearchList
        sendFlag += 1
    }
    
    //获取热门商品信息
    func getHotGoodsInfo() -> [MerchantGoodsData] {
        return self.hotSearchList
    }
}