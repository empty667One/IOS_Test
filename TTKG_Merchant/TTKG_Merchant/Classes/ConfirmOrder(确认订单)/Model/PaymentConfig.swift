//
//	PaymentConfig.swift
//
//	Create by yd on 12/7/2016
//	Copyright © 2016. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class PaymentConfig {

    var code : Int!
    var data : [PaymentData]!
    var msg : String!
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: NSDictionary){
        code = dictionary["code"] as? Int
        data = [PaymentData]()
        if let dataArray = dictionary["data"] as? [NSDictionary]{
            for dic in dataArray{
                let value = PaymentData(fromDictionary: dic)
                data.append(value)
            }
        }
        msg = dictionary["msg"] as? String
    }

}