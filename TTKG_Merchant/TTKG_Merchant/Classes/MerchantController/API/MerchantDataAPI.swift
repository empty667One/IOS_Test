//
//  MerchantDataAPI.swift
//  TTKG_Merchant
//
//  Created by yd on 16/8/10.
//  Copyright © 2016年 yd. All rights reserved.
//

import Foundation

class MerchantDataAPI : MerchantHTTPClientDelegate {
    static let shareInstance = MerchantDataAPI()
    
    private init() {
        persistencyManager = MerchantManager()
        httpClient = MerchantHTTPClient()
        httpClient?.delegate = self
    }
    
    private let persistencyManager : MerchantManager?
    private let httpClient : MerchantHTTPClient?
    
    /*!
     *  @author hu, 16-08-10 14:08:21
     *
     *  @brief 获取商家所有商品
     */
    func getAllGoodsList() ->[MerchantGoodsData] {
        return (persistencyManager?.getAllGoodsListData())!
    }
    func removeAllGoodsList(){
        persistencyManager?.removeAllGoodsListData()
    }
    
    //获取商家所有产品默认的十条数据
    func requestAllGoodsDefaultData(shopid: String) {
        let asc =  ""
        let sort =  ""
        let pageindex = "1"
        persistencyManager?.removeAllGoodsListData()
        httpClient?.requestAllGoodsForMerchant(shopid, pageindex: pageindex, asc: asc, sort: sort)
        
    }
    //获取商家所有产品销量高排序默认的十条数据
    func requestAllGoodsDefaultSaleHeight(shopid: String){
        let sort =  "0"
        let asc =  "0"
        let pageindex = "1"
        persistencyManager?.removeAllGoodsListData()
        httpClient?.requestAllGoodsForMerchant(shopid, pageindex: pageindex, asc: asc, sort: sort)
    }
    //获取商家所有产品销量低排序默认的十条数据
    func requestAllGoodsDefaultSaleLow(shopid: String){
        let sort =  "0"
        let asc =  "1"
        let pageindex = "1"
        persistencyManager?.removeAllGoodsListData()
        httpClient?.requestAllGoodsForMerchant(shopid, pageindex: pageindex, asc: asc, sort: sort)
    }
    
    //获取商家所有产品价格高排序默认的十条数据
    func requestAllGoodsDefaultPriceHeight(shopid: String){
        let sort =  "1"
        let asc =  "0"
        let pageindex = "1"
        persistencyManager?.removeAllGoodsListData()
        httpClient?.requestAllGoodsForMerchant(shopid, pageindex: pageindex, asc: asc, sort: sort)
    }
    //获取商家所有产品价格低排序默认的十条数据
    func requestAllGoodsDefaultPriceLow(shopid: String){
        let sort =  "1"
        let asc =  "1"
        let pageindex = "1"
        persistencyManager?.removeAllGoodsListData()
        httpClient?.requestAllGoodsForMerchant(shopid, pageindex: pageindex, asc: asc, sort: sort)
    }
    
    
    //获取商家所有产品默认更多的数据
    func requestAllGoodsDefaultMoreData(shopid: String) {
        let sort =  ""
        let asc =  ""
        let cnt = persistencyManager?.getAllGoodsListData().count
        NSLog("cnt=\(cnt)")
        var pageindex = (cnt! + 10 - 1 )/10
        if cnt < 10 {
            persistencyManager?.removeAllGoodsListData()
        }else{
            pageindex += 1
            
        }
        httpClient?.requestAllGoodsForMerchant(shopid, pageindex: pageindex.description, asc: asc, sort: sort)
        
    }
    
    //获取商家所有产品高销量排序更多的数据
    func requestAllGoodsSaleHeightMoreData(shopid: String) {
        let sort =  "0"
        let asc =  "0"
        let cnt = persistencyManager?.getAllGoodsListData().count
        var pageindex = (cnt! + 10 - 1 )/10
        if cnt < 10 {
            persistencyManager?.removeAllGoodsListData()
        }else{
            pageindex += 1
            
        }
        httpClient?.requestAllGoodsForMerchant(shopid, pageindex: pageindex.description, asc: asc, sort: sort)
    }
    
    func requestAllGoodsSaleLowMoreData(shopid: String) {
        let sort =  "0"
        let asc =  "1"
        let cnt = persistencyManager?.getAllGoodsListData().count
        var pageindex = (cnt! + 10 - 1 )/10
        if cnt < 10 {
            persistencyManager?.removeAllGoodsListData()
        }else{
            pageindex += 1
            
        }
        httpClient?.requestAllGoodsForMerchant(shopid, pageindex: pageindex.description, asc: asc, sort: sort)
    }
    //获取商家所有产品高价格排序更多的数据
    func requestAllGoodsHeightPriceMoreData(shopid: String) {
        let sort =  "1"
        let asc =  "0"
        let cnt = persistencyManager?.getAllGoodsListData().count
        var pageindex = (cnt! + 10 - 1 )/10
        if cnt < 10 {
            persistencyManager?.removeAllGoodsListData()
        }else{
            pageindex += 1
            
        }
        httpClient?.requestAllGoodsForMerchant(shopid, pageindex: pageindex.description, asc: asc, sort: sort)
    }
    
    func requestAllGoodsLowPriceMoreData(shopid: String) {
        let sort =  "1"
        let asc =  "1"
        let cnt = persistencyManager?.getAllGoodsListData().count
        var pageindex = (cnt! + 10 - 1 )/10
        if cnt < 10 {
            persistencyManager?.removeAllGoodsListData()
        }else{
            pageindex += 1
            
        }
        httpClient?.requestAllGoodsForMerchant(shopid, pageindex: pageindex.description, asc: asc, sort: sort)
    }
    
    /*!
     *  @author hu, 16-08-10 14:08:10
     *
     *  @brief 处理热销商品的数据处理
     */
    //获取商家热销产品默认的十条数据
    
    func getHotGoodsList() ->[MerchantGoodsData] {
        return (persistencyManager?.getHotGoodsListData())!
    }
    func removeHotGoodsList(){
        persistencyManager?.removeHotGoodsListData()
    }
    
    
    func requestHotGoodsDefaultData(shopid: String) {
        let asc =  ""
        let sort =  ""
        let pageindex = "1"
        persistencyManager?.removeHotGoodsListData()
        httpClient?.requestHotGoodsForMerchant(shopid, pageindex: pageindex, asc: asc, sort: sort)
        
    }
    //获取商家热销产品销量高排序默认的十条数据
    func requestHotGoodsDefaultSaleHeight(shopid: String){
        let sort =  "0"
        let asc =  "0"
        let pageindex = "1"
        persistencyManager?.removeHotGoodsListData()
        httpClient?.requestHotGoodsForMerchant(shopid, pageindex: pageindex, asc: asc, sort: sort)
    }
    //获取商家热销产品销量低排序默认的十条数据
    func requestHotGoodsDefaultSaleLow(shopid: String){
        let sort =  "0"
        let asc =  "1"
        let pageindex = "1"
        persistencyManager?.removeHotGoodsListData()
        httpClient?.requestHotGoodsForMerchant(shopid, pageindex: pageindex, asc: asc, sort: sort)
    }
    
    //获取商家热销产品价格高排序默认的十条数据
    func requestHotGoodsDefaultPriceHeight(shopid: String){
        let sort =  "1"
        let asc =  "0"
        let pageindex = "1"
        persistencyManager?.removeHotGoodsListData()
        httpClient?.requestHotGoodsForMerchant(shopid, pageindex: pageindex, asc: asc, sort: sort)
    }
    //获取商家热销产品价格低排序默认的十条数据
    func requestHotGoodsDefaultPriceLow(shopid: String){
        let sort =  "1"
        let asc =  "1"
        let pageindex = "1"
        persistencyManager?.removeHotGoodsListData()
        httpClient?.requestHotGoodsForMerchant(shopid, pageindex: pageindex, asc: asc, sort: sort)
    }
    
    
    //获取商家热销产品默认更多的数据
    func requestHotGoodsDefaultMoreData(shopid: String) {
        let sort =  ""
        let asc =  ""
        let cnt = persistencyManager?.getHotGoodsListData().count
        var pageindex = (cnt! + 10 - 1 )/10
        if cnt < 10 {
            persistencyManager?.removeHotGoodsListData()
        }else{
            pageindex += 1
            
        }
        httpClient?.requestHotGoodsForMerchant(shopid, pageindex: pageindex.description, asc: asc, sort: sort)
        
    }
    
    //获取商家热销产品高销量排序更多的数据
    func requestHotGoodsSaleHeightMoreData(shopid: String) {
        let sort =  "0"
        let asc =  "0"
        let cnt = persistencyManager?.getHotGoodsListData().count
        var pageindex = (cnt! + 10 - 1 )/10
        if cnt < 10 {
            persistencyManager?.removeHotGoodsListData()
        }else{
            pageindex += 1
            
        }
        httpClient?.requestHotGoodsForMerchant(shopid, pageindex: pageindex.description, asc: asc, sort: sort)
    }
    
    func requestHotGoodsSaleLowMoreData(shopid: String) {
        let sort =  "0"
        let asc =  "1"
        let cnt = persistencyManager?.getHotGoodsListData().count
        var pageindex = (cnt! + 10 - 1 )/10
        if cnt < 10 {
            persistencyManager?.removeHotGoodsListData()
        }else{
            pageindex += 1
            
        }
        httpClient?.requestHotGoodsForMerchant(shopid, pageindex: pageindex.description, asc: asc, sort: sort)
    }
    //获取商家热销产品高价格排序更多的数据
    func requestHotGoodsHeightPriceMoreData(shopid: String) {
        let sort =  "1"
        let asc =  "0"
        let cnt = persistencyManager?.getHotGoodsListData().count
        var pageindex = (cnt! + 10 - 1 )/10
        if cnt < 10 {
            persistencyManager?.removeHotGoodsListData()
        }else{
            pageindex += 1
            
        }
        httpClient?.requestHotGoodsForMerchant(shopid, pageindex: pageindex.description, asc: asc, sort: sort)
    }
    
    func requestHotGoodsLowPriceMoreData(shopid: String) {
        let sort =  "1"
        let asc =  "1"
        let cnt = persistencyManager?.getHotGoodsListData().count
        var pageindex = (cnt! + 10 - 1 )/10
        if cnt < 10 {
            persistencyManager?.removeHotGoodsListData()
        }else{
            pageindex += 1
            
        }
        httpClient?.requestHotGoodsForMerchant(shopid, pageindex: pageindex.description, asc: asc, sort: sort)
    }
    
    
    /*!
     *  @author hu, 16-08-10 14:08:10
     *
     *  @brief 处理优惠商品的数据处理
     */
    //获取商家优惠产品默认的十条数据
    
    func getYHGoodsList() ->[MerchantGoodsData] {
        return (persistencyManager?.getYHGoodsListData())!
    }
    func removeYHGoodsList(){
        persistencyManager?.removeYHGoodsListData()
    }
    
    
    func requestYHGoodsDefaultData(shopid: String) {
        let asc =  ""
        let sort =  ""
        let pageindex = "1"
        persistencyManager?.removeYHGoodsListData()
        httpClient?.requestYHGoodsForMerchant(shopid, pageindex: pageindex, asc: asc, sort: sort)
        
    }
    //获取商家热销产品销量高排序默认的十条数据
    func requestYHGoodsDefaultSaleHeight(shopid: String){
        let sort =  "0"
        let asc =  "0"
        let pageindex = "1"
        persistencyManager?.removeYHGoodsListData()
        httpClient?.requestYHGoodsForMerchant(shopid, pageindex: pageindex, asc: asc, sort: sort)
    }
    //获取商家热销产品销量低排序默认的十条数据
    func requestYHGoodsDefaultSaleLow(shopid: String){
        let sort =  "0"
        let asc =  "1"
        let pageindex = "1"
        persistencyManager?.removeYHGoodsListData()
        httpClient?.requestYHGoodsForMerchant(shopid, pageindex: pageindex, asc: asc, sort: sort)
    }
    
    //获取商家热销产品价格高排序默认的十条数据
    func requestYHGoodsDefaultPriceHeight(shopid: String){
        let sort =  "1"
        let asc =  "0"
        let pageindex = "1"
        persistencyManager?.removeYHGoodsListData()
        httpClient?.requestYHGoodsForMerchant(shopid, pageindex: pageindex, asc: asc, sort: sort)
    }
    //获取商家热销产品价格低排序默认的十条数据
    func requestYHGoodsDefaultPriceLow(shopid: String){
        let sort =  "1"
        let asc =  "1"
        let pageindex = "1"
        persistencyManager?.removeYHGoodsListData()
        httpClient?.requestYHGoodsForMerchant(shopid, pageindex: pageindex, asc: asc, sort: sort)
    }
    
    
    //获取商家热销产品默认更多的数据
    func requestYHGoodsDefaultMoreData(shopid: String) {
        let sort =  ""
        let asc =  ""
        let cnt = persistencyManager?.getYHGoodsListData().count
        var pageindex = (cnt! + 10 - 1 )/10
        if cnt < 10 {
            persistencyManager?.removeYHGoodsListData()
        }else{
            pageindex += 1
            
        }
        httpClient?.requestYHGoodsForMerchant(shopid, pageindex: pageindex.description, asc: asc, sort: sort)
        
    }
    
    //获取商家热销产品高销量排序更多的数据
    func requestYHGoodsSaleHeightMoreData(shopid: String) {
        let sort =  "0"
        let asc =  "0"
        let cnt = persistencyManager?.getYHGoodsListData().count
        var pageindex = (cnt! + 10 - 1 )/10
        if cnt < 10 {
            persistencyManager?.removeYHGoodsListData()
        }else{
            pageindex += 1
            
        }
        httpClient?.requestYHGoodsForMerchant(shopid, pageindex: pageindex.description, asc: asc, sort: sort)
    }
    
    func requestYHGoodsSaleLowMoreData(shopid: String) {
        let sort =  "0"
        let asc =  "1"
        let cnt = persistencyManager?.getYHGoodsListData().count
        var pageindex = (cnt! + 10 - 1 )/10
        if cnt < 10 {
            persistencyManager?.removeYHGoodsListData()
        }else{
            pageindex += 1
            
        }
        httpClient?.requestYHGoodsForMerchant(shopid, pageindex: pageindex.description, asc: asc, sort: sort)
    }
    //获取商家热销产品高价格排序更多的数据
    func requestYHGoodsHeightPriceMoreData(shopid: String) {
        let sort =  "1"
        let asc =  "0"
        let cnt = persistencyManager?.getYHGoodsListData().count
        var pageindex = (cnt! + 10 - 1 )/10
        if cnt < 10 {
            persistencyManager?.removeYHGoodsListData()
        }else{
            pageindex += 1
            
        }
        httpClient?.requestYHGoodsForMerchant(shopid, pageindex: pageindex.description, asc: asc, sort: sort)
    }
    
    func requestYHGoodsLowPriceMoreData(shopid: String) {
        let sort =  "1"
        let asc =  "1"
        let cnt = persistencyManager?.getYHGoodsListData().count
        var pageindex = (cnt! + 10 - 1 )/10
        if cnt < 10 {
            persistencyManager?.removeYHGoodsListData()
        }else{
            pageindex += 1
            
        }
        
        
        httpClient?.requestYHGoodsForMerchant(shopid, pageindex: pageindex.description, asc: asc, sort: sort)
    }

    /*!
     *  @author hu, 16-08-10 14:08:10
     *
     *  @brief 处理商家广告的数据处理
     */
    //获取商家商家广告默认数据
    
    func getMerchantAdDataList() ->[MerchantADDetailData] {
        return (persistencyManager?.getMerchantAdListData())!
    }
    
    func removeMerchantAdDataList(){
        persistencyManager?.removeMerchantAdListData()
    }
    
    func requestMerchantAdData(shopid: String) {
        
        httpClient?.requestADForMerchant(shopid)
        
    }
    
    
    
    
    
    /*!
     *  @author hu, 16-08-10 14:08:10
     *
     *  @brief 处理代理方法
     */
    
    func allGoodsDataFromServer(model: MerchantGoodsModel) {
        
        if model.code == 0 {
            persistencyManager?.addAllGoodsListData(model.data)
        }
        
    }
    
    func hotGoodsDataFromServer(model: MerchantGoodsModel) {
        if model.code == 0 {
            persistencyManager?.addHotGoodsListData(model.data)
        }
    }
    
    func YHGoodsDataFromServer(model: MerchantGoodsModel) {
        if model.code == 0 {
            persistencyManager?.addYHGoodsListData(model.data)
        }
    }
    
    func merchantADDataFromServer(model: MerchantADDetailModel) {
        if model.code == 0 {
            persistencyManager?.addMerchantAdListData(model.data)
        }
    }
    
    
}








