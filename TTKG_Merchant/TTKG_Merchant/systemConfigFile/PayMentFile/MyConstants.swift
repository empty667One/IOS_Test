//
//  MyConstants.swift
//  TTKG_Custmer
//
//  Created by yd on 16/6/24.
//  Copyright © 2016年 yd. All rights reserved.
//

import Foundation

//微信、支付宝配置文件
/********************************微信********************************/
//let WXPaySuccessNotification = "WeixinPaySuccessNotification"//微信支付通知

//let WX_APPID = "wx8342726f54c12192"//微信商户号
//let WX_APP_SECRET = "cb8f3d32faa539e46555447c1b51f385"//微信私钥

//let AppScheme:String = "wx8342726f54c12192"

/********************************支付宝********************************/
let AlipayPartner:String = "2088221890611657"
let AlipaySeller:String = "stt0928@163.com"
let AlipayPrivateKey:String = "MIICeAIBADANBgkqhkiG9w0BAQEFAASCAmIwggJeAgEAAoGBAOU9p1T8g9/MOLWGLNKsFrQzw3cLZWY406/NatQ7I/NricpNp6BBI+g6YS9ZbSq6zur3sjD6lNSBUzcT8X1g47edho9+Sl+G/9FNS2QblIPnEl3I2IHOU1RFQmmovDN7ukyFBYLEThkmUhPuA6FQiDioGaz7dwKzLQlCPtulU1g7AgMBAAECgYEArgCTT8XwD2KDNP3obeyjuxqDZovm5qWBwLKKQRe23SCmUUGKV/C54Z7Wf8tAOqvbPazPu6+oYnjbgjYIGmP908RVosZWt6zJO9cPaDDl8iYSoAOG+/tT2h9KU40W4DUsNIj8yj1NObhI1dwI7DuLWzLZ3NbkwID1nYAeAUS+4SECQQD/2/u8gVwve993ftUG7NFuoIXyLDsM92SORaPPDLMgsf3TJ/SyvYa2EgT9Ps250oqUQXTUmbJ8LqlX1l5AUUzLAkEA5V3sXCo3HEmpA6adRb/iXyRLPLkX0zj8ZPgoUQO2iPc5LreDQtJ8KwUjZHEwN/7CDI1T3ulroA273XEx/jikUQJAMk24563zRu6u19qa3XqwDnUHAL8LeRgmsAYnF60ihroX8mz3ojC7DI7sZjHz1qX7UvyvkKELQ3kVGEzwSOrzEwJBAJeQCuGUG7qbig2ZiY9Pjpxj9Tt4659tpopp2Oo/09yJ0MVoClqbj+U1jf+PM9eshjmZIfTItY+bw6o+ZFSixSECQQCSzfQIafubfZ0vVwoSgZTkS2YMSuxz6V4qrH6+X6ffyPEk3Wam8/MME3QIJmo3EIaKHQC2vBoM+ssjBDUp+nP6"

//支付宝通知URL
let AlipayNotifyURL:String =  serverUrl + "/notify/alipay/notify_url.aspx"
//微信通知URL
let WeixinNotifyURL:String = serverUrl + "/notify/weixin/notify_url.aspx" //"http://api.ttkgmall.com/Weixin/Notify.aspx" //



