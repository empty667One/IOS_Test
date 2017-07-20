//
//  SearchGoodsDataAPI.swift
//  ttkg_customer
//
//  Created by iosnull on 16/7/12.
//  Copyright © 2016年 iosnull. All rights reserved.
//

import Foundation

class SearchGoodsDataAPI:SearchGoodsHTTPClientDelegate{
    /*单例*/
    static let shareInstance = SearchGoodsDataAPI()
    private init() {
        
        persistencyManager = SearchGoodsManager()
        httpClient = SearchGoodsHTTPClient()
        isOnline = true
        
        httpClient?.delegate = self
        
    }
    
    private let persistencyManager: SearchGoodsManager?
    private let httpClient: SearchGoodsHTTPClient?
    private let isOnline: Bool?

    /*******************************************************/
    //获取到热门数据数据，进行回调处理
    internal func hotGoodsInfo(model:MerchantGoodsModel){
        self.persistencyManager!.removeHotGoods()
        if model.code == 0 {
            let list = model.data
            persistencyManager!.addHotGoods(list)
        }else{
            
        }
        
    }
    
    //返回热门商品信息
    func getHotGoodsInfo() -> [MerchantGoodsData] {
        return self.persistencyManager!.getHotGoodsInfo()
    }
    
    func removeHotGoodsData(){
        persistencyManager!.removeNormalSearchGoods()
        persistencyManager!.removeHotGoods()
    }
    

    
    //获取单个商家热门商品
    func requestMerchantHotGoods(shopid: String) {
        if (isOnline != false) {//网络连接检测
            //重新网络获取热门商品
            httpClient?.requestMerchantHotGoods(shopid)
        }else{
            
        }
    }
    
    //获取所有商家下的热门商品
    func requestAllHotGoods(){
        if (isOnline != false) {//网络连接检测
            //重新网络获取热门商品
            httpClient?.requestAllHotGoods()
        }else{
            
        }
    }
    
    //根据名称搜索所有商家的商品
    func requestAllMerchantGoodsByName(searchname:String){
        if (isOnline != false) {//网络连接检测
            //重新网络获取热门商品
            httpClient?.requestAllMerchantGoodsByName(searchname)
        }else{
            
        }
    }
    
    
    //根据名称搜索商家的商品
    func requestMerchantGoodsByName(searchname:String,shopid:String){
        if (isOnline != false) {//网络连接检测
            //重新网络获取热门商品
            httpClient?.requestMerchantGoodsByName(searchname, shopid: shopid)
        }else{
            
        }
    }
    /*******************************************************/
    //从服务器搜索关键字商品
    func requestNormalSearchGoodsFromServer(goodsName:String)  {
        if (isOnline != false) {//网络连接检测
            persistencyManager!.removeNormalSearchGoods()
            //重新网络获取热门商品
            httpClient?.getNormalSearchGoodsName(goodsName)
        }else{
            
        }
    }
    
    //获取到普通搜索，进行回调处理
    func normalSearchGoodsInfo(model:MerchantGoodsModel){
        if model.code == 0    {
            if model.data.count == 0 {
               NSNotificationCenter.defaultCenter().postNotification(NSNotification(name: "notSearchedGoods", object: nil)) 
            }else{
                let list = model.data
                persistencyManager!.addNormalSearchGoods(list)
            }
            
        }else{//没有商品信息
            NSNotificationCenter.defaultCenter().postNotification(NSNotification(name: "notSearchedGoods", object: nil))
        }
    }
    
    //返回普通搜索商品列表
    func getNormalSearchGoods() -> [MerchantGoodsData] {
        return persistencyManager!.getNormalSearchGoods()
    }
    
}