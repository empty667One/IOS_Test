//
//  OrderHTTPClient.swift
//  ttkg_customer
//
//  Created by yd on 16/7/4.
//  Copyright © 2016年 iosnull. All rights reserved.
//

import Foundation
import Alamofire

protocol OrderHTTPClientDelegate {
    func ordersListFromServer(model : OrderModel ,index : Int)
    
    func cancelOrderFromServer(model :CancelOrderRootClass,index:Int)
    
    //模型与取消订单模型一致
    func signInOrderFromServer(model :CancelOrderRootClass,index:Int)
    
    //模型与取消订单模型一致
    func deleteOrderFromServer(model :CancelOrderRootClass,index:Int)
}

class  OrderHTTPClient {
    var delegate : OrderHTTPClientDelegate?
    //请求订单
    func requireOrderData(userid:String,iswaybill:String,status:String,currentpage:String,index:Int,paymentid:Int)  {
        let timeTemp = NSDate().getLocationTime() + userInfo_Global.timeStemp
        let MD5_time = Data_Access_MD5_RSA().DataAccessTo_MD5_RSA(timeTemp)
        
        let url = serverUrl + "/order/list"
        let parameters =  ["userid":userid ,
                           "usertype":"1",
                           "status": status,
                           "paymentid":paymentid,
                           "iswaybill": iswaybill,
                           "page":currentpage,
                           "count":"20",
                           "sign":MD5_time,"timespan":timeTemp.description]
        
        
        
        Alamofire.request(.GET, url, parameters: parameters as! [String : AnyObject]).responseString { response -> Void in
            switch response.result {
                case .Success:
                let dict:NSDictionary?
                do {
                    dict = try NSJSONSerialization.JSONObjectWithData(response.data!, options: NSJSONReadingOptions.MutableContainers) as? NSDictionary
                    
                    
                    self.delegate?.ordersListFromServer(OrderModel.init(fromDictionary: dict!), index: index)
                }catch _ {
                    self.order_SendErrorMsg(onlineErrorMsg, status: "404")
                }
                
                case .Failure(let error):
                self.order_SendErrorMsg(onlineErrorMsg, status: "404")
            }
        
        
        }
        
    }
    
    //取消订单
    func cancelOrder(orderNum:String,index:Int){
        let timeTemp = NSDate().getLocationTime() + userInfo_Global.timeStemp
        let MD5_time = Data_Access_MD5_RSA().DataAccessTo_MD5_RSA(timeTemp)
        
        let url = serverUrl + "/order/remove"
        let parameters =  ["userid":userInfo_Global.keyid,
                           "usertype":"1",
                           "orderno":orderNum,
                           "sign":MD5_time,"timespan":timeTemp.description
                           ]
        
        Alamofire.request(.POST, url, parameters: parameters as? [String : AnyObject]).responseString { response -> Void in
            switch response.result {
            case .Success:
                let dict:NSDictionary?
                do {
                    dict = try NSJSONSerialization.JSONObjectWithData(response.data!, options: NSJSONReadingOptions.MutableContainers) as? NSDictionary
                    
                    self.delegate?.cancelOrderFromServer(CancelOrderRootClass.init(fromDictionary: dict!), index: index)
                }catch _ {
                    self.order_SendErrorMsg(onlineErrorMsg, status: "404")
                }
                
            case .Failure(let error):
                self.order_SendErrorMsg(onlineErrorMsg, status: "404")
            }
            
            
        }
    }
    
    //签收订单
    func signInOrder(orderNum:String, index: Int){
        let timeTemp = NSDate().getLocationTime() + userInfo_Global.timeStemp
        let MD5_time = Data_Access_MD5_RSA().DataAccessTo_MD5_RSA(timeTemp)
        
        let url = serverUrl + "/order/receive"
        let parameters =  ["userid":userInfo_Global.keyid,
                           "usertype":"1",
                           "orderno":orderNum,
                           "sign":MD5_time,"timespan":timeTemp.description
                           ]
        
        Alamofire.request(.POST, url, parameters: parameters as? [String : AnyObject]).responseString { response -> Void in
            switch response.result {
            case .Success:
                let dict:NSDictionary?
                do {
                    dict = try NSJSONSerialization.JSONObjectWithData(response.data!, options: NSJSONReadingOptions.MutableContainers) as? NSDictionary
                    
                    self.delegate?.signInOrderFromServer(CancelOrderRootClass.init(fromDictionary: dict!), index: index)
                }catch _ {
                    self.order_SendErrorMsg(onlineErrorMsg, status: "404")
                }
                
            case .Failure(let error):
                self.order_SendErrorMsg(onlineErrorMsg, status: "404")
            }
            
            
        }
    }
    
    //删除订单
    func deleteOrder(orderNum:String, index: Int){
        let timeTemp = NSDate().getLocationTime() + userInfo_Global.timeStemp
        let MD5_time = Data_Access_MD5_RSA().DataAccessTo_MD5_RSA(timeTemp)
        
        let url = serverUrl + "/order/remove"
        let parameters =  ["userid":userInfo_Global.keyid,
                           "usertype":"1",
                           "orderno":orderNum,
                           "sign":MD5_time,"timespan":timeTemp.description
                           ]
        
        Alamofire.request(.POST, url, parameters: parameters as? [String : AnyObject]).responseString { response -> Void in
            
            switch response.result {
            case .Success:
                let dict:NSDictionary?
                do {
                    dict = try NSJSONSerialization.JSONObjectWithData(response.data!, options: NSJSONReadingOptions.MutableContainers) as? NSDictionary
                    
                    self.delegate?.deleteOrderFromServer(CancelOrderRootClass.init(fromDictionary: dict!), index: index)
                }catch _ {
                    self.order_SendErrorMsg(onlineErrorMsg, status: "404")
                }
                
            case .Failure(let error):
                self.order_SendErrorMsg(onlineErrorMsg, status: "404")
            }
 
        }
    }
    
    /*************************************************************************************/
    private func order_SendErrorMsg(errorMsg:String,status:String){
        let errorContent = ["errorMsg":errorMsg,"status":status]
        let notice:NSNotification =  NSNotification(name: "Order_SendErrorMsg", object: errorContent)
        NSNotificationCenter.defaultCenter().postNotification(notice)
    }
}