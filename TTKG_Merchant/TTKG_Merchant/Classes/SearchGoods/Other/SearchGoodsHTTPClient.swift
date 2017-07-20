//
//  SearchGoodsHTTPClient.swift
//  ttkg_customer
//
//  Created by iosnull on 16/7/12.
//  Copyright © 2016年 iosnull. All rights reserved.
//

import Foundation
import Alamofire

protocol SearchGoodsHTTPClientDelegate {
    func hotGoodsInfo(model:MerchantGoodsModel)
    func normalSearchGoodsInfo(model:MerchantGoodsModel)
}

class SearchGoodsHTTPClient {
    var delegate:SearchGoodsHTTPClientDelegate?
    
    //获取普通搜索商品
    func getNormalSearchGoodsName(goodsName:String) {
        let timeTemp = NSDate().getLocationTime() + userInfo_Global.timeStemp
        let MD5_time = Data_Access_MD5_RSA().DataAccessTo_MD5_RSA(timeTemp)
        
        var para = [
            //"shopid": shopID_GlobleVar,//商家KeyID
            "keywords":goodsName,
            "sign":MD5_time,"timespan":timeTemp.description
        ]
        let url = serverUrl + "/product/search"
        
        Alamofire.request(.GET, url, parameters: para).responseString { response -> Void in
            switch response.result {
            case .Success:
                let dict:NSDictionary?
                do {
                    dict = try NSJSONSerialization.JSONObjectWithData(response.data!, options: NSJSONReadingOptions.MutableContainers) as? NSDictionary
                    
                    let model = MerchantGoodsModel.init(fromDictionary: dict!)
                    self.delegate!.normalSearchGoodsInfo(model)
                }catch _ {
                    self.searchGoods_SendErrorMsg(onlineErrorMsg, status: "404")
                }
                
            case .Failure(let error):
                self.searchGoods_SendErrorMsg(onlineErrorMsg, status: "404")
            }
            
        }
    }
    
    
    //根据名称搜索所有商家的商品
    func requestAllMerchantGoodsByName(searchname:String) {
        let timeTemp = NSDate().getLocationTime() + userInfo_Global.timeStemp
        let MD5_time = Data_Access_MD5_RSA().DataAccessTo_MD5_RSA(timeTemp)
        
        var para = [
            "searchname":searchname,
            "areaid":String(userInfo_Global.areaid),
            "roleid": String(userInfo_Global.roleid),//角色id,
            "pageindex": "1",//页数,
            "pagesize":"100",
            "sortid": "1",//排序, 1 : 销量，2 : 价格，不提供参数为默认排序
            "asc":"1",//排序，0：升序，1：降序
            "sign":MD5_time,"timespan":timeTemp.description
        ]
        let url = serverUrl + "/product/list"
        
        Alamofire.request(.GET, url, parameters: para).responseString { response -> Void in
            switch response.result {
            case .Success:
                let dict:NSDictionary?
                do {
                    dict = try NSJSONSerialization.JSONObjectWithData(response.data!, options: NSJSONReadingOptions.MutableContainers) as? NSDictionary
                    let normalSearchResult = MerchantGoodsModel.init(fromDictionary: dict!)
                    self.delegate!.normalSearchGoodsInfo(normalSearchResult)
                }catch _ {
                    self.searchGoods_SendErrorMsg(onlineErrorMsg, status: "404")
                }
                
            case .Failure(let error):
                self.searchGoods_SendErrorMsg(onlineErrorMsg, status: "404")
            }
            
        }
    }
    
    //根据名称搜索商家的商品
    func requestMerchantGoodsByName(searchname:String,shopid:String)  {
        let timeTemp = NSDate().getLocationTime() + userInfo_Global.timeStemp
        let MD5_time = Data_Access_MD5_RSA().DataAccessTo_MD5_RSA(timeTemp)
        
        var para = [
            "shopid":shopid,
            "searchname":searchname,
            "areaid":String(userInfo_Global.areaid),
            "roleid": String(userInfo_Global.roleid),//角色id,
            "pageindex": "1",//页数,
            "pagesize":"100",
            "sortid": "1",//排序, 1 : 销量，2 : 价格，不提供参数为默认排序
            "asc":"1",//排序，0：升序，1：降序
            "sign":MD5_time,"timespan":timeTemp.description
        ]
        let url = serverUrl + "/product/list"
        
        Alamofire.request(.GET, url, parameters: para).responseString { response -> Void in
            switch response.result {
            case .Success:
                let dict:NSDictionary?
                do {
                    dict = try NSJSONSerialization.JSONObjectWithData(response.data!, options: NSJSONReadingOptions.MutableContainers) as? NSDictionary
                    let normalSearchResult = MerchantGoodsModel.init(fromDictionary: dict!)
                    self.delegate!.normalSearchGoodsInfo(normalSearchResult)
                }catch _ {
                    self.searchGoods_SendErrorMsg(onlineErrorMsg, status: "404")
                }
                
            case .Failure(let error):
                self.searchGoods_SendErrorMsg(onlineErrorMsg, status: "404")
            }
            
        }
        
    }
    
    //获取全部热门商品
    func requestAllHotGoods()  {
        let timeTemp = NSDate().getLocationTime() + userInfo_Global.timeStemp
        let MD5_time = Data_Access_MD5_RSA().DataAccessTo_MD5_RSA(timeTemp)
        
        let para = [
            "areaid":String(userInfo_Global.areaid),
            "roleid": String(userInfo_Global.roleid),//角色id,
            "pageindex": "1",//页数,
            "pagesize":"20",
            "sortid": "1",//排序, 1 : 销量，2 : 价格，不提供参数为默认排序
            "asc":"1",//排序，0：升序，1：降序
            "sign":MD5_time,
            "timespan":timeTemp.description
        ]
        let url = serverUrl + "/product/allhotsearch"
        
        Alamofire.request(.GET, url, parameters: para).responseString { response -> Void in
            switch response.result {
            case .Success:
                let dict:NSDictionary?
                do {
                    dict = try NSJSONSerialization.JSONObjectWithData(response.data!, options: NSJSONReadingOptions.MutableContainers) as? NSDictionary
                    let hotSearchRootClass = MerchantGoodsModel.init(fromDictionary: dict!)
                    self.delegate!.hotGoodsInfo(hotSearchRootClass)
                }catch _ {
                    self.searchGoods_SendErrorMsg(onlineErrorMsg, status: "404")
                }
                
            case .Failure(let error):
                self.searchGoods_SendErrorMsg(onlineErrorMsg, status: "404")
            }
            
        }
    }
    
    //获取商家热门商品
    func requestMerchantHotGoods(shopid:String) {
        let timeTemp = NSDate().getLocationTime() + userInfo_Global.timeStemp
        let MD5_time = Data_Access_MD5_RSA().DataAccessTo_MD5_RSA(timeTemp)
        
        var para = [
            "shopid":shopid,
            "areaid":String(userInfo_Global.areaid),
            "roleid": String(userInfo_Global.roleid),//角色id,
            "pageindex": "1",//页数,
            "pagesize":"20",
            "sortid": "1",//排序, 1 : 销量，2 : 价格，不提供参数为默认排序
            "asc":"1",//排序，0：升序，1：降序
            "sign":MD5_time,"timespan":timeTemp.description
        ]
        let url = serverUrl + "/product/list"
        
        Alamofire.request(.GET, url, parameters: para).responseString { response -> Void in
            switch response.result {
            case .Success:
                let dict:NSDictionary?
                do {
                    dict = try NSJSONSerialization.JSONObjectWithData(response.data!, options: NSJSONReadingOptions.MutableContainers) as? NSDictionary
                    let hotSearchRootClass = MerchantGoodsModel.init(fromDictionary: dict!)
                    self.delegate!.hotGoodsInfo(hotSearchRootClass)
                }catch _ {
                    self.searchGoods_SendErrorMsg(onlineErrorMsg, status: "404")
                }
                
            case .Failure(let error):
                    self.searchGoods_SendErrorMsg(onlineErrorMsg, status: "404")
            }
            
        }
    }
    
    /*************************************************************************************/
    private func searchGoods_SendErrorMsg(errorMsg:String,status:String){
        let errorContent = ["errorMsg":errorMsg,"status":status]
        let notice:NSNotification =  NSNotification(name: "searchGoods_SendErrorMsg", object: errorContent)
        NSNotificationCenter.defaultCenter().postNotification(notice)
    }
}