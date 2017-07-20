//
//  GoodsDetailManager.swift
//  ttkg_customer
//
//  Created by iosnull on 16/7/8.
//  Copyright © 2016年 iosnull. All rights reserved.
//

import Foundation
class GoodsDetailManager {
    private var goodsDetailInfoData:GoodsDetailInfoData?
    //触发器
    private var sendFlag = 0 {
        didSet{//发通知给控制器
            NSNotificationCenter.defaultCenter().postNotification(NSNotification(name: "GoodsDetailInfoDataChanged", object: nil))
        }
    }
    
    func getGoodsDetailInfo() -> GoodsDetailInfoData? {
        return self.goodsDetailInfoData
    }
    
    func removeGoodsDetailInfo() {
        self.goodsDetailInfoData = nil
    }
    
    func setGoodsDetailInfo(goodsDetailInfoData:GoodsDetailInfoData) {
        self.goodsDetailInfoData = goodsDetailInfoData
        sendFlag += 1
    }
}