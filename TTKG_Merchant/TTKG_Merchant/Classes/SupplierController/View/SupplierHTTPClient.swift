//
//  SupplierHTTPClient.swift
//  TTKG_Merchant
//
//  Created by macmini on 16/8/9.
//  Copyright © 2016年 yd. All rights reserved.
//

import Foundation
import Alamofire

protocol SupplierHTTPClientDelegate {
    
    func responseMerchantData(model:MerchantInfoRootClass)
    
}

class SupplierHTTPClient {
    
    var delegate:SupplierHTTPClientDelegate?
    
    func requestMerchantData(userid:Int,usertype:Int,areaid :String ,page:Int,count:Int) {
        let timeTemp = NSDate().getLocationTime() + userInfo_Global.timeStemp
        let MD5_time = Data_Access_MD5_RSA().DataAccessTo_MD5_RSA(timeTemp)
        
        let url = serverUrl + "/home/shoplist"
        let p = ["userid":userid.description,"usertype":usertype.description,"areaid": areaid,"page":page.description,"count":count.description,"sign":MD5_time,"timespan":timeTemp.description]
        
        Alamofire.request(.GET, url, parameters:p )
            .responseString { response -> Void in
                switch response.result {
                case .Success:
                    let dict:NSDictionary?
                    do {
                        dict = try NSJSONSerialization.JSONObjectWithData(response.data!, options: NSJSONReadingOptions.MutableContainers) as? NSDictionary
                        
                        self.delegate?.responseMerchantData(MerchantInfoRootClass.init(fromDictionary: dict!))
                        
                    }catch _ {
                        self.SupplierAPI_SendErrorMsg(onlineErrorMsg, status: "404")
                }
                case .Failure :
                        self.SupplierAPI_SendErrorMsg(onlineErrorMsg, status: "404")

            }
        }
        
    }
    
    private func SupplierAPI_SendErrorMsg(errorMsg:String,status:String){
        let errorContent = ["errorMsg":errorMsg,"status":status]
        let notice:NSNotification =  NSNotification(name: "SupplierAPI_SendErrorMsg", object: errorContent)
        NSNotificationCenter.defaultCenter().postNotification(notice)
    }
}