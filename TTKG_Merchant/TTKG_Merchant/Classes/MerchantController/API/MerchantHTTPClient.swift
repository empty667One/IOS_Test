//
//  MerchantHTTPClient.swift
//  TTKG_Merchant
//
//  Created by yd on 16/8/10.
//  Copyright © 2016年 yd. All rights reserved.
//

import Foundation
import Alamofire

protocol MerchantHTTPClientDelegate {
    /*!
     
     - author: hu
     - date: 16-08-10 11:08:16
     获取商家所有产品数据
     
     - parameter model: 所有产品数据模型
     */
    func allGoodsDataFromServer(model:MerchantGoodsModel)
    /*!
     
     - author: hu
     - date: 16-08-10 11:08:55
     获取商家热销产品数据
     
     - parameter model: 热销产品数据模型
     */
    func hotGoodsDataFromServer(model:MerchantGoodsModel)
    /*!
     
     - author: hu
     - date: 16-08-10 11:08:39
     获取商家优惠产品数据
     
     - parameter model: 优惠产品数据模型
     */
    func YHGoodsDataFromServer(model:MerchantGoodsModel)
    /*!
     
     - author: hu
     - date: 16-08-10 11:08:04
     获取商家广告数据
     
     - parameter model: 广告数据模型
     */
    func merchantADDataFromServer(model:MerchantADDetailModel)
}


class MerchantHTTPClient {
    var delegate : MerchantHTTPClientDelegate?
    
    
    /*!
     
     - author: hu
     - date: 16-08-10 10:08:12
     请求商家所有商品
     */
    func requestAllGoodsForMerchant(shopid:String,pageindex:String,asc:String,sort:String) {
        let timeTemp = NSDate().getLocationTime() + userInfo_Global.timeStemp
        let MD5_time = Data_Access_MD5_RSA().DataAccessTo_MD5_RSA(timeTemp)
        
        let url = serverUrl + "/product/list"
        let parameters = ["shopid":shopid,"pageindex":pageindex,"sort":sort,"asc":asc,"sign":MD5_time,"timespan":timeTemp.description]
        Alamofire.request(.GET, url, parameters: parameters)
            .responseString { response -> Void in
                
                switch response.result {
                case .Success:
                    let dict:NSDictionary?
                    do {
                        dict = try NSJSONSerialization.JSONObjectWithData(response.data!, options: NSJSONReadingOptions.MutableContainers) as? NSDictionary
                        self.delegate?.allGoodsDataFromServer(MerchantGoodsModel.init(fromDictionary: dict!))
                        
                    }catch _ {
                        self.Merchant_SendErrorMsg(onlineErrorMsg,status:"404")
                    }
                    
                case .Failure(let error):
                    self.Merchant_SendErrorMsg(onlineErrorMsg,status:"404")
                }
        }
        
    }
    
    /*!
     
     - author: hu
     - date: 16-08-10 10:08:09
     请求商家热销产品
     */
    func requestHotGoodsForMerchant(shopid:String,pageindex:String,asc:String,sort:String){
        let timeTemp = NSDate().getLocationTime() + userInfo_Global.timeStemp
        let MD5_time = Data_Access_MD5_RSA().DataAccessTo_MD5_RSA(timeTemp)
        
        let url = serverUrl + "/product/hot"
        let parameters = ["shopid":shopid,"pageindex":pageindex,"sort":sort,"asc":asc,"sign":MD5_time,"timespan":timeTemp.description]
        Alamofire.request(.GET, url, parameters: parameters)
            .responseString { response -> Void in
                
                switch response.result {
                case .Success:
                    let dict:NSDictionary?
                    do {
                        dict = try NSJSONSerialization.JSONObjectWithData(response.data!, options: NSJSONReadingOptions.MutableContainers) as? NSDictionary
                        
                        self.delegate?.hotGoodsDataFromServer(MerchantGoodsModel.init(fromDictionary: dict!))
                        
                    }catch _ {
                        self.Merchant_SendErrorMsg(onlineErrorMsg,status:"404")
                    }
                    
                case .Failure(let error):
                    self.Merchant_SendErrorMsg(onlineErrorMsg,status:"404")
                }
        }
        
    }
    
    /*!
     
     - author: hu
     - date: 16-08-10 10:08:33
    请求商家优惠产品
     */
    func requestYHGoodsForMerchant(shopid:String,pageindex:String,asc:String,sort:String) {
        let timeTemp = NSDate().getLocationTime() + userInfo_Global.timeStemp
        let MD5_time = Data_Access_MD5_RSA().DataAccessTo_MD5_RSA(timeTemp)
        
        let url = serverUrl + "/product/privilege"
        let parameters = ["shopid":shopid,"pageindex":pageindex,"sort":sort,"asc":asc,"sign":MD5_time,"timespan":timeTemp.description]
        Alamofire.request(.GET, url, parameters: parameters)
            .responseString { response -> Void in
                
                switch response.result {
                case .Success:
                    let dict:NSDictionary?
                    do {
                        dict = try NSJSONSerialization.JSONObjectWithData(response.data!, options: NSJSONReadingOptions.MutableContainers) as? NSDictionary
                        self.delegate?.YHGoodsDataFromServer(MerchantGoodsModel.init(fromDictionary: dict!))
                        
                        
                    }catch _ {
                       self.Merchant_SendErrorMsg(onlineErrorMsg,status:"404")
                    }
                    
                case .Failure(let error):
                    self.Merchant_SendErrorMsg(onlineErrorMsg,status:"404")
                }
        }
        
    }
    
    /*!
     
     - author: hu
     - date: 16-08-10 11:08:10
     请求商家活动
     */
    func requestADForMerchant(shopid:String){
        let timeTemp = NSDate().getLocationTime() + userInfo_Global.timeStemp
        let MD5_time = Data_Access_MD5_RSA().DataAccessTo_MD5_RSA(timeTemp)
        
        let url = serverUrl + "/product/shopactivty"
        let parameters = ["shopid":shopid,"sign":MD5_time,"timespan":timeTemp.description]
        NSLog("parameters=\(parameters.description)")
        Alamofire.request(.GET, url, parameters: parameters)
            .responseString { response -> Void in
                
                switch response.result {
                case .Success:
                    let dict:NSDictionary?
                    do {
                        dict = try NSJSONSerialization.JSONObjectWithData(response.data!, options: NSJSONReadingOptions.MutableContainers) as? NSDictionary
                        
                        self.delegate?.merchantADDataFromServer(MerchantADDetailModel.init(fromDictionary: dict!))
                        
                    }catch _ {
                        self.Merchant_SendErrorMsg(onlineErrorMsg,status:"404")
                    }
                    
                case .Failure(let error):
                    self.Merchant_SendErrorMsg(onlineErrorMsg,status:"404")
                }
        }
        
    }
    
    /*************************************************************************************/
    private func Merchant_SendErrorMsg(errorMsg:String,status:String){
        let errorContent = ["errorMsg":errorMsg,"status":status]
        let notice:NSNotification =  NSNotification(name: "Merchant_SendErrorMsg", object: errorContent)
        NSNotificationCenter.defaultCenter().postNotification(notice)
    }

}






