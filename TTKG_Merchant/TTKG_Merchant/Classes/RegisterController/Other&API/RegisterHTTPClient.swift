//
//  RegisterHTTPClient.swift
//  TTKG_Merchant
//
//  Created by iosnull on 16/8/1.
//  Copyright © 2016年 yd. All rights reserved.
//

import Foundation
import Alamofire

protocol RegisterHTTPClientDelegate {
    /**
     返回用户注册状态
     
     - parameter status: 为true表明该手机号已经被注册过，false表明该手机可以进行注册
     */
    func serverCheckUserHaveBeenRegisted(status:Bool)
    
    /**
     从服务器获取允许的注册区域
     
     - parameter model: model description
     */
    func getUserServiceAreaFromServer(model:ServiceAreaRootClass)
    
    /**
     从服务器获取对应手机号的验证码
     
     - parameter code: 验证码
     */
    func getVirifyCodeFromServer(model:VerifyCodeRootClass)
}

class RegisterHTTPClient {
    var delegate:RegisterHTTPClientDelegate?
    
    /**
     用户注册
     
     - parameter tel:       用户名称
     - parameter pwd:       密码
     - parameter areaid:    区域地址
     - parameter address:   详细地址
     - parameter orangekey: 推荐码
     */
    func registUsr(tel:String,pwd:String,areaid:String,address:String,orangekey:String){
        let url = serverUrl + "/merchant/code"
        let p = ["phone":tel,
            "pwd":pwd,
            "areaid":areaid,
            "address":address,
            "orangekey":orangekey
            ]
        
        Alamofire.request(.POST, url, parameters:p )
            .responseString { response -> Void in
                switch response.result {
                case .Success:
                    let dict:NSDictionary?
                    do {
                        dict = try NSJSONSerialization.JSONObjectWithData(response.data!, options: NSJSONReadingOptions.MutableContainers) as? NSDictionary
                        
                        self.registerResult(dict!["msg"] as! String, status: dict!["code"] as! String)
                        
                    }catch _ {
                        self.registerAPI_SendErrorMsg("无可以网络", status: "404")
                    }
                    
                    
                case .Failure( _):
                    self.registerAPI_SendErrorMsg("无可以网络", status: "404")
                }
                
        }
    }
    
    
    /**
     发送验证码至手机
     */
    func sendVirifyCodeToTel(num:String) {
        let url = serverUrl + "/merchant/code"
        let p = ["phone":num]
        Alamofire.request(.GET, url, parameters:p )
            .responseString { response -> Void in
                switch response.result {
                case .Success:
                    let dict:NSDictionary?
                    do {
                        dict = try NSJSONSerialization.JSONObjectWithData(response.data!, options: NSJSONReadingOptions.MutableContainers) as? NSDictionary
                        
                            self.delegate?.getVirifyCodeFromServer(VerifyCodeRootClass.init(fromDictionary: dict!))
                        
                    }catch _ {
                        self.registerAPI_SendErrorMsg("无可以网络", status: "404")
                    }
                    
                    
                case .Failure( _):
                    self.registerAPI_SendErrorMsg("无可以网络", status: "404")
                }
                
        }
    }
    
    /**
     检测该用户是否已经注册过
     
     - parameter tel: 电话号码
     */
    func checkUserHaveBeenRegisted(tel:String){
        let url = serverUrl + "/merchant/arealist"
        let p = ["phone":tel]
        Alamofire.request(.GET, url, parameters:p )
            .responseString { response -> Void in
                switch response.result {
                case .Success:
                    let dict:NSDictionary?
                    do {
                        dict = try NSJSONSerialization.JSONObjectWithData(response.data!, options: NSJSONReadingOptions.MutableContainers) as? NSDictionary
                        //判断用户已经注册与否
                        if (dict!["code"] as! Int) == 0 {
                            self.delegate?.serverCheckUserHaveBeenRegisted(false)
                        }else{
                            self.delegate?.serverCheckUserHaveBeenRegisted(true)
                        }
                    }catch _ {
                        self.registerAPI_SendErrorMsg("无可以网络", status: "404")
                    }
                    
                    
                case .Failure(let _):
                    self.registerAPI_SendErrorMsg("无可以网络", status: "404")
                }
                
        }
    }
    
    /**
     获取开放注册的区域
     */
    func getUserServiceArea(){
        let url = serverUrl + "/merchant/arealist"
        
        Alamofire.request(.GET, url, parameters: nil)
            .responseString { response -> Void in
                switch response.result {
                case .Success:
                    let dict:NSDictionary?
                    do {
                        dict = try NSJSONSerialization.JSONObjectWithData(response.data!, options: NSJSONReadingOptions.MutableContainers) as? NSDictionary
                        self.delegate?.getUserServiceAreaFromServer(ServiceAreaRootClass.init(fromDictionary: dict!))
                    }catch _ {
                        self.registerAPI_SendErrorMsg("无可以网络", status: "404")
                    }
                    
                    
                case .Failure(let _):
                    self.registerAPI_SendErrorMsg("无可以网络", status: "404")
                }
                
        }
    }
    
    /****************************************************************************/
    //有错误时提示信息通知
    func registerAPI_SendErrorMsg(errorMsg:String,status:String){
        let errorContent = ["errorMsg":errorMsg,"status":status]
        let notice:NSNotification =  NSNotification(name: "RegisterAPI_SendErrorMsg", object: errorContent)
        NSNotificationCenter.defaultCenter().postNotification(notice)
    }
    
    //注册结果信息通知
    func registerResult(msg:String,status:String){
        let content = ["msg":msg,"status":status]
        let notice:NSNotification =  NSNotification(name: "registerResultInfo", object: content)
        NSNotificationCenter.defaultCenter().postNotification(notice)
    }
    
    
    
}