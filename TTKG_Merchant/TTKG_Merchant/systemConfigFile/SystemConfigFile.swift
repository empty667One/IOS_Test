//
//  SystemConfigFile.swift
//  TTKG_Merchant
//
//  Created by yd on 16/7/29.
//  Copyright © 2016年 yd. All rights reserved.
//

import Foundation
import UIKit

let screenWith = UIScreen.mainScreen().bounds.width
let screenHeigh = UIScreen.mainScreen().bounds.height

/**
 *  用户登录后返回的登录信息
 */
struct UserInfo_Global {
    var address = String()
    var areaid = String()
    var keyid = Int()
    var loginid = String()
    var name = String()
    var picurl = String()
    var roleid = Int()
    var shopname = String()
    var tel = String()
    var sparetel = String()
    var password = String()
    var timeStemp = Int64()
    var ptmc = String()
    
    
}

//微信或支付宝启动后设置该变量为true
var alipayOrWeiXinStateFlag = false

/******************************************************************/
/******************************************************************/
/******************************************************************/


//用户信息
var userInfo_Global = UserInfo_Global()

 /// 联网标记
var onlineState = true
 /// 无网络连接
let onlineErrorMsg = "无网络连接"

 /// 服务器接口地址
let serverUrl = "https://api.ttkgmall.com"
//let serverUrl = "http://testapib.ttkgmall.com"

//本地服务器接口地址
//let serverUrl = "http://192.168.1.141:8800"


//let serverPicUrl = "https://administrator.ttkgmall.com"
let serverPicUrl = "http://testmanage.ttkgmall.com"



/******************************************************************/
/******************************************************************/
/******************************************************************/

//当前服务器时间和本地手机时间差(用于签名)
var timeDifferenceValue = String()

/**
 服务器绝对时间，由于签名
 
 - parameter timeDifferenceValue:当前服务器与本机的时间差
 
 - returns: return value 当前服务器的时间
 */

func serverAbsoluteTime() -> String {
    var time = String() //- timeDifferenceValue
    
    return time
}


/**
 参数加密
 
 - parameter data: data description
 - parameter time: time description
 
 - returns: return value description
 */
func signParameters_MD5_RSA(parameters:[String],time:String) -> String {
    
    
    var data = String()
    for item in parameters {
        data += String(item)
    }
    
    let key = "68A6BB9A2E47F5D620A20F34D399FC698DEB77DE"//待加密的key，参数加密成功后拼接在后面
    let str_MD5 = (data + time + key).md5()
    NSLog("str_MD5 == \(str_MD5)")
    let rsa = RSA_Encryptor.sharedRSA_Encryptor()
    let publicKeyPath = NSBundle.mainBundle().pathForResource("public_key", ofType: "der")
    rsa.loadPublicKeyFromFile(publicKeyPath)
    let encryptedString = rsa.rsaEncryptString(str_MD5)
    NSLog("加密:\n \(encryptedString)")
    return encryptedString
}
/******************************************************************/
/******************************************************************/
/******************************************************************/
