//
//  ShoppingCarAPI.swift
//  TTKG_Merchant
//
//  Created by iosnull on 16/8/3.
//  Copyright © 2016年 yd. All rights reserved.
//

import Foundation


class GoodsListAPI:GoodsListHTTPClientDelegate{
    
    
    /*单例*/
    static let shareInstance = GoodsListAPI()
    private  init() {
    
    persistencyManager = GoodsListManager()
    httpClient = GoodsListHTTPClient()
    httpClient.delegate = self
    }
    
    private let persistencyManager:GoodsListManager
    private let httpClient:GoodsListHTTPClient
    
    
    func getGoodsList() -> [MerchantGoodsData] {
        return persistencyManager.goodsDatas
    }
    
    
    /********************************************************/
    /********************************************************/
    /********************************************************/
    
//    //按品牌，配送条件，价格筛选
//    {
//    "areaid": 6,//经营区域id
//    "roleid": 4,//角色id
//    "brandid": 5,//品牌id
//    "carryingamount": 50,//起配条件金额
//    "minprice": 0,//价格区间的最小价格
//    "maxprice": 20,//价格区间的最大价格
//    "pageindex": 1,//页数
//    "pagesize": 10,//页大小
//    "sort": 0,//排序，0：按销量排序，1：按价格排序
//    "asc": 0//升序降序，0：升序，1：降序
//    }
    
    func requestGoodsByCondition(brandid:String,categoryid:String,carryingamount:String,minprice:String,maxprice:String,pageindex:String,pagesize:String,sort:String,asc:String) {
        if onlineState {
            httpClient.requestGoodsByCondition(userInfo_Global.areaid, roleid: userInfo_Global.roleid.description,brandid:brandid,categoryid:categoryid,carryingamount:carryingamount,minprice:minprice,maxprice:maxprice,pageindex:pageindex,pagesize:pagesize,sort:sort,asc:asc)
        }else{
            goodsList_SendErrorMsg(onlineErrorMsg, status: "404")
        }
    }
    
    
    
        /********************************************************/
        /********************************************************/
        /********************************************************/
//        //根据产品分类类别id查询产品
//    {
//        "categoryid": 1,//分类类别id
//        "areaid": 6,//经营区域id
//        "roleid": 4,//角色id
//        "pageindex": 1,//页数
//        "pagesize": 10,//页大小
//        "sort": 0,//排序，0：按销量排序，1：按价格排序
//        "asc": 0//升序降序，0：升序，1：降序
//    }
    
    func requestGoodsByClass(categoryid:String,pageindex:String,pagesize:String,sort:String,asc:String) {
        if onlineState {
            httpClient.requestGoodsByClass(categoryid,areaid:userInfo_Global.areaid, roleid: userInfo_Global.roleid.description,pageindex: pageindex,pagesize: pagesize,sort: sort,asc: asc)
        }else{
            goodsList_SendErrorMsg(onlineErrorMsg, status: "404")
        }
    }
    
//    //根据产品品牌id查询产品
//    {
//    "brandid": 5,//品牌id
//    "areaid": 6,//经营区域id
//    "roleid": 4,//角色id
//    "pageindex": 1,//页数
//    "pagesize": 10,//页大小
//    "sort": 0,//排序，0：按销量排序，1：按价格排序
//    "asc": 0//升序降序，0：升序，1：降序
//    }
    
    func requestGoodsByBrand(brandid:String,pageindex:String,pagesize:String,sort:String,asc:String) {
        if onlineState {
            httpClient.requestGoodsByBrand(brandid,areaid:userInfo_Global.areaid, roleid: userInfo_Global.roleid.description,pageindex: pageindex,pagesize: pagesize,sort: sort,asc: asc)
        }else{
            goodsList_SendErrorMsg(onlineErrorMsg, status: "404")
        }
    }
    
    /********************************************************/
    /********************************************************/
    /********************************************************/
    
    func getBigBrand() -> [BigBrandData] {
        return persistencyManager.bigBrandDatas
    }
    
    //服务器请求获取大品牌（筛选用）
    func requestBigBrand() {
        if onlineState {
            httpClient.requestrequestBigBrand(userInfo_Global.areaid, roleid: userInfo_Global.roleid.description)
        }else{
            goodsList_SendErrorMsg(onlineErrorMsg, status: "404")
        }
    }
    

    /**
     大品牌服务器返回
     
     - parameter model: model description
     */
    func responseBigBrandData(model:BigBrandRootClass){
        if model.code == 0 {
            persistencyManager.bigBrandDatas = model.data
        }else{
            goodsList_SendErrorMsg(model.msg, status: "404")
        }
    }
    /********************************************************/
    /********************************************************/
    /********************************************************/
    
//    //按品牌，配送条件，价格筛选
//    {
//    "areaid": 6,//经营区域id
//    "roleid": 4,//角色id
//    "brandid": 5,//品牌id
//    "carryingamount": 50,//起配条件金额
//    "minprice": 0,//价格区间的最小价格
//    "maxprice": 20,//价格区间的最大价格
//    "pageindex": 1,//页数
//    "pagesize": 10,//页大小
//    "sort": 0,//排序，0：按销量排序，1：按价格排序
//    "asc": 0//升序降序，0：升序，1：降序
//    }
    
//    func requestGoodsListByBrandid(brandid:String,carryingamount:String,minprice:String,maxprice:String,pageindex:String,pagesize:String,sort:String,asc:String) {
//        
//        if onlineState {
//            httpClient.requestGoodsListByAreaid(userInfo_Global.areaid.description, roleid: userInfo_Global.roleid.description, brandid: brandid, carryingamount: carryingamount, minprice: minprice, maxprice: maxprice, pageindex: pageindex, pagesize: pagesize, sort: sort, asc: asc)
//        }else{
//            goodsList_SendErrorMsg(onlineErrorMsg, status: "404")
//        }
//        
//    }
    
    
    func responseGoodsListData(model:MerchantGoodsModel){
        if model.code == 0 {
            if model.data.count == 0 {
                goodsList_SendErrorMsg(model.msg, status: "404")
            }
            persistencyManager.goodsDatas = model.data
            //persistencyManager.addGoodsDatas(model.data)
        }else{
            goodsList_SendErrorMsg(model.msg, status: "404")
        }
    }
    
    /********************************************************/
    /********************************************************/
    /********************************************************/
    private func goodsList_SendErrorMsg(errorMsg:String,status:String){
        let errorContent = ["errorMsg":errorMsg,"status":status]
        let notice:NSNotification =  NSNotification(name: "goodsList_SendErrorMsg", object: errorContent)
        NSNotificationCenter.defaultCenter().postNotification(notice)
    }
    
    

    
}