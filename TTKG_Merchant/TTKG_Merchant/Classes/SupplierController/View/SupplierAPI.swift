//
//  SupplierAPI.swift
//  TTKG_Merchant
//
//  Created by macmini on 16/8/9.
//  Copyright © 2016年 yd. All rights reserved.
//

import Foundation

class SupplierAPI: SupplierHTTPClientDelegate {
    /*单例*/
    static let shareInstance = SupplierAPI()
    private  init() {
        
        persistencyManager = SupplierManager()
        httpClient = SupplierHTTPClient()
        httpClient.delegate = self
    }
    
    private let persistencyManager:SupplierManager
    private let httpClient:SupplierHTTPClient
    
    
    //从服务器获取数据
    func requestDefaultDataFromServer(keyid: Int, areaid:String) {
        
        if onlineState {
            //persistencyManager.merchantInfoDatas = []
            httpClient.requestMerchantData(keyid, usertype: 1, areaid: areaid ,page: 1, count: 20000)
        }else{
            SupplierAPI_SendErrorMsg(onlineErrorMsg, status: "404")
        }
    }
    
    //上拉加载更多数据
    func requsetMoreDataFromServer(keyid: Int,areaid:String) {
        let page = 1
        httpClient.requestMerchantData(keyid, usertype: 1, areaid:areaid, page: page + 1, count: 20)
    }
    
    
    //得到数据
    func getSupplierDataFromModel() -> [MerchantInfoData]{
    
        let merchantData = persistencyManager.merchantInfoDatas
        
        return merchantData
    }
    
    
    
    func responseMerchantData(model: MerchantInfoRootClass) {
        if model.code == 0{
            persistencyManager.merchantInfoDatas = []
            persistencyManager.addMerchantInfoDatas(model.data)
//            persistencyManager.merchantInfoDatas += model.data
        }else{
            SupplierAPI_SendErrorMsg(model.msg, status: "404")
        }
        
    }
    
    private func SupplierAPI_SendErrorMsg(errorMsg:String,status:String){
        let errorContent = ["errorMsg":errorMsg,"status":status]
        let notice:NSNotification =  NSNotification(name: "SupplierAPI_SendErrorMsg", object: errorContent)
        NSNotificationCenter.defaultCenter().postNotification(notice)
    }
}
