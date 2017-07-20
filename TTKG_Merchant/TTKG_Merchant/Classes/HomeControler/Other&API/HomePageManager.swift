//
//  HomeManager.swift
//  TTKG_Merchant
//
//  Created by iosnull on 16/8/2.
//  Copyright (c) 2016年 yd. All rights reserved.
//

import Foundation

class HomePageManager {
    
    /// 首页强推来的产品信息
    var adAppData:AdApp_Data?{
        didSet{
            modelChangedCnt += 1
        }
    }
    /********************************************************/
    /********************************************************/
    /********************************************************/
    
     /// 首页推送来的产品信息
    var pushAD_Data:PushAD_Data?{
        didSet{
            modelChangedCnt += 1
        }
    }
    /********************************************************/
    /********************************************************/
    /********************************************************/
    
    
     /// 轮播图
    var scrollADDatas:[ScrollADData]?{
        didSet{
            modelChangedCnt += 1
        }
    }
    
    /********************************************************/
    /********************************************************/
    /********************************************************/
    
    /// 公告
    var noticeMessageDatas:[NoticeMessageData]?{
        didSet{
            modelChangedCnt += 1
        }
    }
    
    /********************************************************/
    /********************************************************/
    /********************************************************/
     /// 大品牌
    var goodsBrandDatas:[GoodsBrandData] = [GoodsBrandData](){
        didSet{
            modelChangedCnt += 1
        }
    }
    
    /********************************************************/
    /********************************************************/
    /********************************************************/
    
     /// 商品分类
    var goodsClassificationDatas:[GoodsClassificationData]?{
        didSet{
            modelChangedCnt += 1
        }
    }
    
    /********************************************************/
    /********************************************************/
    /********************************************************/
    
    /// 商家列表
    var merchantInfoDatas:[MerchantInfoData] = [MerchantInfoData](){
        didSet{
            modelChangedCnt += 1
        }
    }
    
    
    func addMerchantInfoDatas(merchantInfoData:[MerchantInfoData])  {
        for item in merchantInfoData {
            
            var flag = true
            
            for itemTemp:MerchantInfoData in self.merchantInfoDatas {
                if itemTemp.shopid == item.shopid {
                    flag = false
                    break
                }
            }
            
            if flag {
                self.merchantInfoDatas.append(item)
            }
            
        }
        
    }
    
    /********************************************************/
    /********************************************************/
    /********************************************************/
    
    /// 模型发生改变后触发通知
    private var modelChangedCnt = 0{
        didSet{
            homePageModelChanged()
        }
    }
    
    /********************************************************/
    /********************************************************/
    /********************************************************/
    
    private func homePageModelChanged(){
        let notice:NSNotification =  NSNotification(name: "HomePageModelChanged", object: nil)
        NSNotificationCenter.defaultCenter().postNotification(notice)
    }
    
}