//
//  ShoppingCarHTTPClient.swift
//  TTKG_Merchant
//
//  Created by iosnull on 16/8/3.
//  Copyright © 2016年 yd. All rights reserved.
//

import Foundation
import Alamofire

protocol GoodsListHTTPClientDelegate {
    //大品牌
    func responseBigBrandData(model:BigBrandRootClass)
    //商品列表
    func responseGoodsListData(model:MerchantGoodsModel)
}

class GoodsListHTTPClient {
    var delegate:GoodsListHTTPClientDelegate?
    
    
    func requestGoodsByBrand(brandid:String,areaid:String, roleid:String,pageindex:String,pagesize:String,sort:String,asc:String){
        let timeTemp = NSDate().getLocationTime() + userInfo_Global.timeStemp
        let MD5_time = Data_Access_MD5_RSA().DataAccessTo_MD5_RSA(timeTemp)
        
        let url = serverUrl + "/product/list"
        let p = ["brandid"      :brandid,
                 "areaid"       :areaid,
                 "roleid"       :roleid,
                 "pageindex"    :pageindex,
                 "pagesize"     :pagesize,
                 "sort"         :sort,
                 "asc"          :asc,
                 "sign":MD5_time,
                 "timespan":timeTemp.description]
        
        
        Alamofire.request(.GET, url, parameters:p )
            .responseString { response -> Void in
                switch response.result {
                case .Success:
                    let dict:NSDictionary?
                    do {
                        dict = try NSJSONSerialization.JSONObjectWithData(response.data!, options: NSJSONReadingOptions.MutableContainers) as? NSDictionary
                        
                        self.delegate?.responseGoodsListData(MerchantGoodsModel.init(fromDictionary: dict!))
                        
                    }catch _ {
                        self.goodsListAPI_SendErrorMsg(onlineErrorMsg, status: "404")
                    }
                    
                    
                case .Failure(let _):
                    self.goodsListAPI_SendErrorMsg(onlineErrorMsg, status: "404")
                }
                
        }
    }
    
    
    func requestGoodsByClass(categoryid:String,areaid:String, roleid:String,pageindex:String,pagesize:String,sort:String,asc:String) {
        let timeTemp = NSDate().getLocationTime() + userInfo_Global.timeStemp
        let MD5_time = Data_Access_MD5_RSA().DataAccessTo_MD5_RSA(timeTemp)
        
        let url = serverUrl + "/product/list"
        let p = ["categoryid"   :categoryid,
                 "areaid"       :areaid,
                 "roleid"       :roleid,
                 "pageindex"    :pageindex,
                 "pagesize"     :pagesize,
                 "sort"         :sort,
                 "asc"          :asc,
                 "sign":MD5_time,
                 "timespan":timeTemp.description]
        
        
        Alamofire.request(.GET, url, parameters:p )
            .responseString { response -> Void in
                switch response.result {
                case .Success:
                    let dict:NSDictionary?
                    do {
                        dict = try NSJSONSerialization.JSONObjectWithData(response.data!, options: NSJSONReadingOptions.MutableContainers) as? NSDictionary
                        
                        self.delegate?.responseGoodsListData(MerchantGoodsModel.init(fromDictionary: dict!))
                        
                    }catch _ {
                        self.goodsListAPI_SendErrorMsg(onlineErrorMsg, status: "404")
                    }
                    
                    
                case .Failure(let _):
                    self.goodsListAPI_SendErrorMsg(onlineErrorMsg, status: "404")
                }
                
        }
    }
    
    
    /**
     根据筛选条件请求商品列表数据
     
     - parameter areaid:         areaid description
     - parameter roleid:         roleid description
     - parameter brandid:        brandid description
     - parameter carryingamount: carryingamount description
     - parameter minprice:       minprice description
     - parameter maxprice:       maxprice description
     - parameter pageindex:      pageindex description
     - parameter pagesize:       pagesize description
     - parameter sort:           sort description
     - parameter asc:            asc description
     */
    func requestGoodsByCondition(areaid:String, roleid:String,brandid:String,categoryid:String,carryingamount:String,minprice:String,maxprice:String,pageindex:String,pagesize:String,sort:String,asc:String){
        let timeTemp = NSDate().getLocationTime() + userInfo_Global.timeStemp
        let MD5_time = Data_Access_MD5_RSA().DataAccessTo_MD5_RSA(timeTemp)
        
        let url = serverUrl + "/product/list"
        let p = [
                 "areaid"       :areaid,
                 "roleid"       :roleid,
                 "brandid"      :brandid,
                 "categoryid"   :categoryid,
                 "carryingamount":carryingamount,
                 "minprice":minprice,
                 "maxprice":maxprice,
                 "pageindex"    :pageindex,
                 "pagesize"     :pagesize,
                 "sort"         :sort,
                 "asc"          :asc ,
                 "sign":MD5_time,
                 "timespan":timeTemp.description]
        
        
        Alamofire.request(.GET, url, parameters:p )
            .responseString { response -> Void in
                switch response.result {
                case .Success:
                    let dict:NSDictionary?
                    do {
                        dict = try NSJSONSerialization.JSONObjectWithData(response.data!, options: NSJSONReadingOptions.MutableContainers) as? NSDictionary
                        
                        self.delegate?.responseGoodsListData(MerchantGoodsModel.init(fromDictionary: dict!))
                        
                    }catch _ {
                        self.goodsListAPI_SendErrorMsg(onlineErrorMsg, status: "404")
                    }
                    
                    
                case .Failure(let _):
                    self.goodsListAPI_SendErrorMsg(onlineErrorMsg, status: "404")
                }
                
        }
        
        
    }
    
    /**
     请求大品牌数据
     
     - parameter areaid: areaid description
     - parameter roleid: roleid description
     */
    func requestrequestBigBrand(areaid:String,roleid:String)  {
        let timeTemp = NSDate().getLocationTime() + userInfo_Global.timeStemp
        let MD5_time = Data_Access_MD5_RSA().DataAccessTo_MD5_RSA(timeTemp)
        
        let url = serverUrl + "/product/brand"
        let p = ["areaid":areaid,"roleid":roleid,"sign":MD5_time,"timespan":timeTemp.description]
        
        Alamofire.request(.GET, url, parameters:p )
            .responseString { response -> Void in
                switch response.result {
                case .Success:
                    let dict:NSDictionary?
                    do {
                        dict = try NSJSONSerialization.JSONObjectWithData(response.data!, options: NSJSONReadingOptions.MutableContainers) as? NSDictionary
                        
                        self.delegate?.responseBigBrandData(BigBrandRootClass.init(fromDictionary: dict!))
                        
                    }catch _ {
                        self.goodsListAPI_SendErrorMsg(onlineErrorMsg, status: "404")
                    }
                    
                    
                case .Failure(let _):
                    self.goodsListAPI_SendErrorMsg(onlineErrorMsg, status: "404")
                }
                
        }
    }
    
  

    
    
    /********************************************************/
    /********************************************************/
    /********************************************************/
    private func goodsListAPI_SendErrorMsg(errorMsg:String,status:String){
        let errorContent = ["errorMsg":errorMsg,"status":status]
        let notice:NSNotification =  NSNotification(name: "goodsList_SendErrorMsg", object: errorContent)
        NSNotificationCenter.defaultCenter().postNotification(notice)
    }
    
}