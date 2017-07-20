//
//  RegisterManager.swift
//  TTKG_Merchant
//
//  Created by iosnull on 16/8/1.
//  Copyright © 2016年 yd. All rights reserved.
//

import Foundation


class RegisterManager {
    
    /**
     返回用户注册时的信息
     
     - returns: return value description
     */
    func showRegisterInfo() ->(tel:String,virifyCode:String,registedFlag:Bool,userServiceArea:ServiceAreaRootClass?) {
        return (tel,virifyCode,registedFlag,userServiceArea)
    }
    
    
    //1用户名称
    var tel = String(){
        didSet{
            modelChanged("用户电话")
        }
    }
    //2开放注册的区域
    var userServiceArea:ServiceAreaRootClass?{
        didSet{
            modelChanged("开放注册的区域")
        }
    }
    //3短信验证码
    var virifyCode = String(){
        didSet{
            modelChanged("短信验证码")
        }
    }
    //4已经注册状态
    var registedFlag = false{
        didSet{
            if registedFlag {
                modelChanged("已经注册状态")
            }else{
                modelChanged("可以注册状态")
            }
            
        }
    }
    
    
    private func modelChanged(status:String)  {
        var result = [String:String]()
        result["changeName"] = status
        let notice:NSNotification =  NSNotification(name: "RegisterModelChanged", object: result )
        NSNotificationCenter.defaultCenter().postNotification(notice)
    }
    
    
}