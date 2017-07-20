//
//  PayMethodFile.swift
//  TTKG_Merchant
//
//  Created by yd on 16/8/17.
//  Copyright © 2016年 yd. All rights reserved.
//

import UIKit
import Alamofire

class ShuangGouAndHuoDaoPay: NSObject,UIAlertViewDelegate {

    private var telNum = String("4006008195")
    //alertView的点击
    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
        
        
            if alertView.tag == 0 {
                if buttonIndex == 0 {
                    UIApplication.sharedApplication().openURL(NSURL(string: "tel://\(telNum)")!)
                }
            }else{
                
            }
        
        
            
        
        
    }
    
    var payResultModel : PayResultModel!
    
    
    //查询爽购余额并进行支付
    func requestCheckShuangGouAmount(price:Double,tradeno:String){
        
        //获取客服电话
        func requestTelphone() {
            let timeTemp = NSDate().getLocationTime() + userInfo_Global.timeStemp
            let MD5_time = Data_Access_MD5_RSA().DataAccessTo_MD5_RSA(timeTemp)
            let parameters = ["sign":MD5_time,"timespan":timeTemp.description]
            let url = serverUrl + "/platform/contact"
            Alamofire.request(.GET, url, parameters:parameters )
                .responseString { response -> Void in
                    
                    
                    switch response.result {
                    case .Success:
                        let dict:NSDictionary?
                        do {
                            dict = try NSJSONSerialization.JSONObjectWithData(response.data!, options: NSJSONReadingOptions.MutableContainers) as? NSDictionary
                            
                            if dict!["code"] as! Int == 0{
                                
                                let dic = dict!["data"] as! NSDictionary
                                self.telNum = (dic["tel"] as? String)!
                                let alertView = UIAlertView(title: "温馨提示", message: "亲，开通此功能需要联系我们的人工客服电话：\(self.telNum)", delegate: self, cancelButtonTitle: "开通", otherButtonTitles: "取消")
                                alertView.tag = 0
                                alertView.show()
                                
                            }
                            
                        }catch _ {
                            dict = nil
                        }
                        
                        
                        
                        
                        
                        
                    case .Failure(let error):
                        print(error)
                    }
                    
            }
            
        }
        
        
        let timeTemp = NSDate().getLocationTime() + userInfo_Global.timeStemp
        let MD5_time = Data_Access_MD5_RSA().DataAccessTo_MD5_RSA(timeTemp)
        
            let parameters = ["userid":userInfo_Global.keyid,"usertype":1,"sign":MD5_time,"timespan":timeTemp.description]
            
            let url = serverUrl + "/merchant/creditstate"
            Alamofire.request(.GET, url, parameters:parameters as! [String : AnyObject] )
                .responseString { response -> Void in
                    switch response.result {
                    case .Success:
                        let dict:NSDictionary?
                        do {
                            dict = try NSJSONSerialization.JSONObjectWithData(response.data!, options: NSJSONReadingOptions.MutableContainers) as? NSDictionary
                            //1用户没有开通爽购
                            if ( (dict!["code"] as? Int) == 0) && ( (dict!["data"]!["creditstatus"] as? Bool) == false ){
                                
                                requestTelphone()
                                
                                
                            }else if ( (dict!["code"] as? Int) == 0) && ( (dict!["data"]!["creditstatus"] as? Bool) == true ){
                                let creditavailable = dict!["data"]!["creditavailable"] as! Double
                                if price > creditavailable {//2不够支付
                                    
                                    let alertView = UIAlertView(title: "订单提示", message: "爽购可用余额￥\(creditavailable)\n支付金额￥\(price)\n不能完成该笔支付，请经常还款噢...还能享受更多优惠", delegate: self, cancelButtonTitle: "确定")
                                    alertView.tag = 1
                                    alertView.show()
                                    
                                }else{//可以支付
                                    self.requestShuangGouToPay(tradeno)
                                }
                            }else{
                                //其他故障
                            }
                            
                            
                        }catch _ {
                            dict = nil
                        }
                    case .Failure(let error):
                        print(error)
                    }
                    
            }
            
        
    }
    
    //爽购付款
    func requestShuangGouToPay(tradeno:String) {
        let timeTemp = NSDate().getLocationTime() + userInfo_Global.timeStemp
        let MD5_time = Data_Access_MD5_RSA().DataAccessTo_MD5_RSA(timeTemp)
        
        let url = serverUrl + "/payment/credit"
        let parameters = ["userid":userInfo_Global.keyid,"tradeno":tradeno,"usertype":1,"sign":MD5_time,"timespan":timeTemp.description]
        Alamofire.request(.POST, url, parameters: parameters as? [String : AnyObject])
            .responseString { response -> Void in
                
                switch response.result {
                case .Success:
                    let dict:NSDictionary?
                    do {
                        dict = try NSJSONSerialization.JSONObjectWithData(response.data!, options: NSJSONReadingOptions.MutableContainers) as? NSDictionary
                        
                        
                        let status = dict
                        let notice = NSNotification(name: "ShuangGouResult", object: status)
                        NSNotificationCenter.defaultCenter().postNotification(notice)
                        
                    }catch _ {
                        dict = nil
                    }
                    //self.payResultModel = PayResultModel.init(fromDictionary: dict!)
                    
                case .Failure(let error):
                    print(error)
                }
        }
    }
    
    //货到付款
    func requestDeliverToPay(tradeno:String){
        let timeTemp = NSDate().getLocationTime() + userInfo_Global.timeStemp
        let MD5_time = Data_Access_MD5_RSA().DataAccessTo_MD5_RSA(timeTemp)
        
        let url = serverUrl + "/payment/deferred"
        let parameters = ["userid":userInfo_Global.keyid,"tradeno":tradeno,"usertype":1,"sign":MD5_time,"timespan":timeTemp.description]
        Alamofire.request(.POST, url, parameters: parameters as? [String : AnyObject])
            .responseString { response -> Void in
                
                switch response.result {
                case .Success:
                    let dict:NSDictionary?
                    do {
                        dict = try NSJSONSerialization.JSONObjectWithData(response.data!, options: NSJSONReadingOptions.MutableContainers) as? NSDictionary
                        
                        let status = dict
                        let notice = NSNotification(name: "HuoDaoFuKuanResult", object: status)
                        NSNotificationCenter.defaultCenter().postNotification(notice)
                        
                    }catch _ {
                        dict = nil
                    }
                    self.payResultModel = PayResultModel.init(fromDictionary: dict!)
                    
                    if (self.payResultModel.code == 0){
                        
                    }
                    
                case .Failure(let error):
                    print(error)
                }
        }

    }
    
}
