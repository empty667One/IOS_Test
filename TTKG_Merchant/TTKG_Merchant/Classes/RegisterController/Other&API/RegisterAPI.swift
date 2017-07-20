//
//  RegisterAPI.swift
//  TTKG_Merchant
//
//  Created by yd on 16/8/1.
//  Copyright © 2016年 yd. All rights reserved.
//

import Foundation


//extension RegisterVC:RegisterAPI_Notice{
//    
//}

/**
 *  注册API要求控制器实现接收通知处理
 *  需要接受的通知名称是:RegisterAPI_SendErrorMsg   RegisterModelChanged  registerResultInfo
 */
protocol RegisterAPI_Notice {
    
    
    /**
     注册错误信息提示
     - parameter errorMsg: 注册错误信息提示通知
     - parameter status:   错误代码（404：无网络或其他故障，200：成功的）
     */
    func registerAPI_ErrorMsg(notice:NSNotification)
    
    
    
    /**
     用户注册结果(成功或失败，控制器自行处理)
     - parameter status:   错误代码（404：无网络或其他故障，200：成功的）
     - parameter msg: msg 注册错误信息提示通知
     */
    func registResult(notice:NSNotification)
    
    
    
    /**
     注册模型发送改变，会发出通知，控制器负责接收处理
     
     - parameter notice:
     */
    func registerModelChanged(notice:NSNotification)
    
    
}


/// 注册API （外观模式）
class RegisterAPI:RegisterHTTPClientDelegate{
    /*单例*/
    static let shareInstance = RegisterAPI()
    private  init() {
        
        persistencyManager = RegisterManager()
        httpClient = RegisterHTTPClient()
        httpClient.delegate = self
        
        
    }
    
    let persistencyManager:RegisterManager
    let httpClient:RegisterHTTPClient
    
    
    
    /**
     当模型发出通知后，控制器可以使用该函数返回用户注册信息
     
     - returns: return value description
     */
    func showRegisterInfo() ->(tel:String,virifyCode:String,registedFlag:Bool,userServiceArea:ServiceAreaRootClass?){
        return persistencyManager.showRegisterInfo()
    }
    
    /**
     检测用户是否已经注册过
     
     - parameter tel: 用户名称（电话号码）
     */
    func checkUserHaveBeenRegisted(tel:String)  {
        if onlineState {
            httpClient.checkUserHaveBeenRegisted(tel)
        }else{
            registerAPI_SendErrorMsg(onlineErrorMsg, status: "404")
        }
    }
    
    /**
     发送手机验证码
     
     - parameter num: 手机号
     */
    func sendVirifyCodeToTel(num:String)  {
        if onlineState {
            httpClient.sendVirifyCodeToTel(num)
        }else{
            registerAPI_SendErrorMsg(onlineErrorMsg, status: "404")
        }
    }
    
    /**
     用户注册
     
     - parameter tel:       用户名称（手机号）
     - parameter pwd:       用户密码
     - parameter areaid:    用户所在区域
     - parameter address:   用户详细地址
     - parameter orangekey: 推荐码
     */
    func registUsr(tel:String,pwd:String,areaid:String,address:String,orangekey:String)  {
        if onlineState {
            httpClient.registUsr(tel,pwd: pwd,areaid: areaid,address: address,orangekey: orangekey)
        }else{
            registerAPI_SendErrorMsg(onlineErrorMsg, status: "404")
        }
    }
    
    /**
     获取平台开放注册区域
     */
     func getUserServiceArea(){
        if onlineState {
            httpClient.getUserServiceArea()
        }else{
            registerAPI_SendErrorMsg(onlineErrorMsg, status: "404")
        }
    }
    
    
    /**************************************************************************************/
    
    private func registerAPI_SendErrorMsg(errorMsg:String,status:String){
        let errorContent = ["errorMsg":errorMsg,"status":status]
        let notice:NSNotification =  NSNotification(name: "RegisterAPI_SendErrorMsg", object: errorContent)
        NSNotificationCenter.defaultCenter().postNotification(notice)
    }
    
    /**************************************************************************************/
    
    
    /**
     该用户是否已经注册过
     
     - parameter status: status == true 表示已经注册过
     */
    internal func serverCheckUserHaveBeenRegisted(status:Bool){
        if status {//该用户已经被注册了
            persistencyManager.registedFlag = true
        }else{//该用户还没有被注册过
            persistencyManager.registedFlag = false
        }
    }
    
    /**
     获取到开发用户注册的区域地址
     
     - parameter model: model description
     */
    internal  func getUserServiceAreaFromServer(model:ServiceAreaRootClass){
        if model.code == 0 {//获取区域地址成功
            persistencyManager.userServiceArea = model
        }else{
            registerAPI_SendErrorMsg(model.msg, status: "404")
        }
    }
    
    
    internal func getVirifyCodeFromServer(model:VerifyCodeRootClass) {
        if model.code == 0 {//发送成功
            if model.data.phone == persistencyManager.tel {//手机号不匹配
                persistencyManager.virifyCode = model.data.vcode
                registerAPI_SendErrorMsg("验证码发送成功,请查收", status: "200")
            }else{
                registerAPI_SendErrorMsg("验证码过期了,请重新再试", status: "404")
            }
        }else{
            registerAPI_SendErrorMsg(model.msg, status: "404")
        }
    }
    
}







