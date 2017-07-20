//
//  ShoppingCarHTTPClient.swift
//  TTKG_Merchant
//
//  Created by iosnull on 16/8/3.
//  Copyright © 2016年 yd. All rights reserved.
//

import Foundation
import Alamofire

protocol ShoppingCarHTTPClientDelegate {
    func responseShoppingCarListData(model:ShoppingCarRootClass)
    
    func responseRemoveShoppingCar(code:Int,msg:String,cartids:[Int])
    
    func responseResetShopCarGoodsNum(code:Int,msg:String,cartid:Int,num:Int)
}

class ShoppingCarHTTPClient {
    var delegate:ShoppingCarHTTPClientDelegate?
    
    
    /**
     重置商品数量
     
     - parameter cartid:   cartid description
     - parameter quantity: quantity description
     */
    func requestResetShopCarGoodsNum(cartid:Int,quantity:Int) {
        let timeTemp = NSDate().getLocationTime() + userInfo_Global.timeStemp
        let MD5_time = Data_Access_MD5_RSA().DataAccessTo_MD5_RSA(timeTemp)
        
        let url = serverUrl + "/shoppingcart/update"
        let p = ["cartid":cartid,"quantity":quantity,"sign":MD5_time,"timespan":timeTemp.description]
        
        Alamofire.request(.POST, url, parameters:p as! [String : AnyObject] )
            .responseString { response -> Void in
                switch response.result {
                case .Success:
                    let dict:NSDictionary?
                    do {
                        dict = try NSJSONSerialization.JSONObjectWithData(response.data!, options: NSJSONReadingOptions.MutableContainers) as? NSDictionary
                        
                        let code = dict!["code"] as? Int
                        let msg = dict!["msg"] as? String
                        
                        self.delegate?.responseResetShopCarGoodsNum(code!, msg: msg!, cartid: cartid,num:quantity)
                        
                    }catch _ {
                        self.ShoppingCarAPI_SendErrorMsg(onlineErrorMsg, status: "404")
                    }
                    
                    
                case .Failure(let _):
                    self.ShoppingCarAPI_SendErrorMsg(onlineErrorMsg, status: "404")
                }
                
        }
    }
    
    
    /**
     移除购物车
     
     - parameter cartid: cartid description
     */
    func removeGoods(cartid:String,cartids:[Int]) {
        let timeTemp = NSDate().getLocationTime() + userInfo_Global.timeStemp
        let MD5_time = Data_Access_MD5_RSA().DataAccessTo_MD5_RSA(timeTemp)
        
        let url = serverUrl + "/shoppingcart/remove"
        let p = ["cartid":cartid,"sign":MD5_time,"timespan":timeTemp.description]
        
        Alamofire.request(.POST, url, parameters:p )
            .responseString { response -> Void in
                switch response.result {
                case .Success:
                    let dict:NSDictionary?
                    do {
                        dict = try NSJSONSerialization.JSONObjectWithData(response.data!, options: NSJSONReadingOptions.MutableContainers) as? NSDictionary
                        
                        let code = dict!["code"] as? Int
                        let msg = dict!["msg"] as? String
                        
                        self.delegate?.responseRemoveShoppingCar(code!, msg: msg!, cartids: cartids)
                        
                    }catch _ {
                        self.ShoppingCarAPI_SendErrorMsg(onlineErrorMsg, status: "404")
                    }
                    
                    
                case .Failure(let _):
                    self.ShoppingCarAPI_SendErrorMsg(onlineErrorMsg, status: "404")
                }
                
        }
    }
    
    /**
     从服务器请求购物车数据
     
     - parameter userid: 用户身份证
     */
    func requestShoppingCarList(userid:Int)  {
        let timeTemp = NSDate().getLocationTime() + userInfo_Global.timeStemp
        let MD5_time = Data_Access_MD5_RSA().DataAccessTo_MD5_RSA(timeTemp)
        
        let url = serverUrl + "/shoppingcart/list"
        let p = ["userid":userid,"userType":1,"sign":MD5_time,"timespan":timeTemp.description]
        Alamofire.request(.GET, url, parameters:p as? [String : AnyObject] )
            .responseString { response -> Void in
                switch response.result {
                case .Success:
                    let dict:NSDictionary?
                    do {
                        dict = try NSJSONSerialization.JSONObjectWithData(response.data!, options: NSJSONReadingOptions.MutableContainers) as? NSDictionary
                        
                        self.delegate?.responseShoppingCarListData(ShoppingCarRootClass.init(fromDictionary: dict!))
                        
                    }catch _ {
                        self.ShoppingCarAPI_SendErrorMsg(onlineErrorMsg, status: "404")
                    }
                    
                    
                case .Failure(let _):
                    self.ShoppingCarAPI_SendErrorMsg(onlineErrorMsg, status: "404")
                }
                
        }
    }
    
    
    /********************************************************/
    /********************************************************/
    /********************************************************/
    private func ShoppingCarAPI_SendErrorMsg(errorMsg:String,status:String){
        let errorContent = ["errorMsg":errorMsg,"status":status]
        let notice:NSNotification =  NSNotification(name: "ShoppingCarAPI_SendErrorMsg", object: errorContent)
        NSNotificationCenter.defaultCenter().postNotification(notice)
    }
    
}