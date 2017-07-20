//
//  GetNetWorkTime.swift
//  TTKG_Merchant
//
//  Created by yd on 16/8/31.
//  Copyright © 2016年 yd. All rights reserved.
//

import UIKit
import Alamofire

class GetNetWorkTime: NSObject {
    
    
    func requestNetWorkTime(){
        let url = serverUrl + "/platform/date"
        Alamofire.request(.GET, url, parameters:nil )
            .responseString { response -> Void in
                switch response.result {
                case .Success:
                    let dict:NSDictionary?
                    do {
                        dict = try NSJSONSerialization.JSONObjectWithData(response.data!, options: NSJSONReadingOptions.MutableContainers) as? NSDictionary
                        
                    }catch _ {
                        dict = nil
                    }
                    var timeModel = NetWorkModel.init(fromDictionary: dict!)
                    NSLog("timeModel == \(timeModel.data.description)")
                    if timeModel.code == 0 {
                        let refDate = NSDate()
                        let timeTemp = Int64(refDate.timeIntervalSince1970*1000)
                        userInfo_Global.timeStemp = Int64(timeTemp - timeModel.data)
                        NSLog("userInfo_Global == \(userInfo_Global.timeStemp)")
                    }
            
                case .Failure( _):
                    break
                }
        }
        
    }
}
