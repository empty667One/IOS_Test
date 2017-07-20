//
//  GoodsDetailHTTPClient.swift
//  ttkg_customer
//
//  Created by iosnull on 16/7/8.
//  Copyright © 2016年 iosnull. All rights reserved.
//

import Foundation
import Alamofire

protocol GoodsDetailHTTPClientDelegate {
    func goodsDetailInfo(model:GoodsDetailInfoModel)
}

class GoodsDetailHTTPClient{
    var delegate:GoodsDetailHTTPClientDelegate?
    //请求商品详情
    func requestGoodsDetailInfo(shopid:String, productid:String, roleid:String, userid:String) {
        let timeTemp = NSDate().getLocationTime() + userInfo_Global.timeStemp
        let MD5_time = Data_Access_MD5_RSA().DataAccessTo_MD5_RSA(timeTemp)
        
        let url = serverUrl  + "/product/details"
        let parameters = ["shopid":shopid,"productid":productid,"roleid":roleid, "userid":userid,"sign":MD5_time,"timespan":timeTemp.description]
        
        Alamofire.request(.GET, url, parameters: parameters).responseString { response -> Void in
            
            
            switch response.result {
            case .Success:
                let dict:NSDictionary?
                do {
                    dict = try NSJSONSerialization.JSONObjectWithData(response.data!, options: NSJSONReadingOptions.MutableContainers) as? NSDictionary
                    
                    self.delegate?.goodsDetailInfo(GoodsDetailInfoModel.init(fromDictionary: dict!))
                }catch _ {
                    self.goodDetail_SendErrorMsg(onlineErrorMsg, status: "404")

                }
                
            case .Failure(let error):
                self.goodDetail_SendErrorMsg(onlineErrorMsg, status: "404")
            }
            
        }

    }
    
    /*************************************************************************************/
    private func goodDetail_SendErrorMsg(errorMsg:String,status:String){
        let errorContent = ["errorMsg":errorMsg,"status":status]
        let notice:NSNotification =  NSNotification(name: "goodDetail_SendErrorMsg", object: errorContent)
        NSNotificationCenter.defaultCenter().postNotification(notice)
    }
}