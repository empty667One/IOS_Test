//
//  AlipayAndWeixinPay.swift
//  ttkg_customer
//
//  Created by yd on 16/7/13.
//  Copyright © 2016年 iosnull. All rights reserved.
//

import UIKit



protocol AlipayAndWeixinPayDelegate:class{
    func paymentSuccess(paymentType paymentType:PaymentType)
    func paymentFail(paymentType paymentType:PaymentType)
}

class AlipayAndWeixinPay: NSObject {
    var order:MyOrder!
    var delegate:AlipayAndWeixinPayDelegate?
    //支付宝
    func Alipay(tradeNo:String,productName:String,productDescription:String,amount:String) {
        
        let alipayOrder = AlipayOrder(partner: AlipayPartner, seller: AlipaySeller, tradeNO: tradeNo, productName: productName, productDescription: productDescription, amount: amount, notifyURL: AlipayNotifyURL, service: "mobile.securitypay.pay", paymentType: "1", inputCharset: "utf-8", itBPay: "30m", showUrl: "m.alipay.com", rsaDate: nil, appID: nil)
        
        let orderSpec = alipayOrder.description //orderA.description
        
        let signer = RSADataSigner(privateKey: AlipayPrivateKey)
        let signedString = signer.signString(orderSpec)
        
        let orderString = "\(orderSpec)&sign=\"\(signedString)\"&sign_type=\"RSA\""
        
        
        
        AlipaySDK.defaultService().payOrder(orderString, fromScheme: APP_ID, callback: {[weak self] resultDic in
            
                
            //支付宝调起标记，delegate用
                alipayOrWeiXinStateFlag = true
            
                let resultDic = resultDic as Dictionary
                if let resultStatus = resultDic["resultStatus"] as? String {
                    if resultStatus == "9000" {
                        
                        //发通知进行页面跳转（去待发货页面）
                        let status = ["alipayStatus":"successful"]
                        let notice = NSNotification(name: "AlipayResult", object: status)
                        NSNotificationCenter.defaultCenter().postNotification(notice)
                        
                    }else if resultStatus == "6001"{

                        //取消了支付宝支付
                        let status = ["alipayStatus":"cancellAlipay"]
                        let notice = NSNotification(name: "AlipayResult", object: status)
                        NSNotificationCenter.defaultCenter().postNotification(notice)
                        
                    }else{
                        //未知故障
                        let status = ["alipayStatus":"error"]
                        let notice = NSNotification(name: "AlipayResult", object: status)
                        NSNotificationCenter.defaultCenter().postNotification(notice)
                    }
                }
            
            
            
            })
        
    }

    //微信支付
    func weiXinPay(tradeNO:String,productName:String,productDescription:String,amount:String,notifyURL:String)->Int{
        
        if !WXApi.isWXAppInstalled() {
            
            //没有安装微信客服端
            let status = ["WeiXinStatus":"notInstall","selectPage":1]
            let notice = NSNotification(name: "WeiXinResult", object: status)
            NSNotificationCenter.defaultCenter().postNotification(notice)
            
            return 0
        }
        
        
        
        let req = payRequsestHandler()
        
        req.initq(APP_ID, mch_id: MCH_ID)
        req.setKey(PARTNER_ID)
        
        let dict:NSMutableDictionary? = req.sendPay_demo("18908502495", order_name: productName + tradeNO, order_price: amount, orderno: tradeNO,notify_URL:notifyURL)
        NSLog("dict=\(dict?.description)")
        
        if dict != nil {//获取签名成功
            //微信调起标记，delegate用
            alipayOrWeiXinStateFlag = true
            
            
            let stamp  =  dict!.objectForKey("timestamp") as! String
            
            //调起微信支付
            let req :PayReq            = PayReq()
            req.openID              = dict!.objectForKey("appid") as! String
            req.partnerId           = dict!.objectForKey("partnerid") as! String//[dict objectForKey:@"partnerid"];
            req.prepayId            = dict!.objectForKey("prepayid") as! String//[dict objectForKey:@"prepayid"];
            req.nonceStr            = dict!.objectForKey("noncestr") as! String//[dict objectForKey:@"noncestr"];
            
            req.package             = dict!.objectForKey("package") as! String //[dict objectForKey:@"package"];
            req.sign                = dict!.objectForKey("sign") as! String //[dict objectForKey:@"sign"];
            
            let sec = NSNumberFormatter().numberFromString(stamp)!.integerValue
            req.timeStamp           = UInt32(sec)
            WXApi.sendReq(req)
            
            NSLog("appid=%@\npartid=%@\nprepayid=%@\nnoncestr=%@\ntimestamp=%ld\npackage=%@\nsign=%@",req.openID,req.partnerId,req.prepayId,req.nonceStr,req.timeStamp,req.package,req.sign );
            
            
        }else{//签名不成功
            //错误提示
            //NSLog("获取失败")
            //发通知给tabbar控制器、给商品购物车，进行页面跳转（待付款）
            let status = ["WeiXinStatus":"signedError","selectPage":1]
            let notice = NSNotification(name: "WeiXinResult", object: status)
            NSNotificationCenter.defaultCenter().postNotification(notice)
            
            return 1
        }
        
        //没有登陆微信
        let status = ["WeiXinStatus":"notLogin"]
        let notice = NSNotification(name: "WeiXinResult", object: status)
        NSNotificationCenter.defaultCenter().postNotification(notice)
        
        return 1
    }
    
    
}
