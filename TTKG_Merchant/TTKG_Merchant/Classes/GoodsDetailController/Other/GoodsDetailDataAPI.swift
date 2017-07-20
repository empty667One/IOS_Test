//
//  GoodsDetailDataAPI.swift
//  ttkg_customer
//
//  Created by iosnull on 16/7/8.
//  Copyright © 2016年 iosnull. All rights reserved.
//

import Foundation
//首页数据API （外观模式）
class GoodsDetailDataAPI:GoodsDetailHTTPClientDelegate{
    /*单例*/
    static let shareInstance = GoodsDetailDataAPI()
    private init() {
        
        persistencyManager = GoodsDetailManager()
        httpClient = GoodsDetailHTTPClient()
        isOnline = true
        httpClient?.delegate = self
        
    }

    private let persistencyManager: GoodsDetailManager?
    private let httpClient: GoodsDetailHTTPClient?
    private let isOnline: Bool?

    //从服务器获取商品信息
    func requestGoodsDetailInfoFromServer(shopid:String,productid:String,roleid:String,userid:String){
        if (isOnline != false) {//网络连接检测
            //移除商品详情
            persistencyManager?.removeGoodsDetailInfo()
            //重新网络获取商品详情
            httpClient?.requestGoodsDetailInfo(shopid, productid: productid, roleid:roleid,userid: userid )
        }else{
            
        }
    }
    
    //从服务器获取到商品信息
    internal func goodsDetailInfo(model: GoodsDetailInfoModel) {
        if (model.code == 0)  {
                
                persistencyManager?.setGoodsDetailInfo(model.data)
            }else{
            //返回数据有误
            notMoreData()
        }
    }
    
    //获取商品详情数据
    func getGoodsDetailInfo() -> GoodsDetailInfoData? {
        return persistencyManager?.getGoodsDetailInfo()
    }
    
    private func notMoreData(){
        NSNotificationCenter.defaultCenter().postNotification(NSNotification(name: "GoodsDetailInfoDataChanged", object: nil))
    }

}