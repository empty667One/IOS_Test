//
//	PaymentData.swift
//
//	Create by yd on 12/7/2016
//	Copyright © 2016. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class PaymentData {

    var icon : String!
    var paymentid : Int!
    var title : String!
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: NSDictionary){
        icon = dictionary["icon"] as? String
        paymentid = dictionary["paymentid"] as? Int
        title = dictionary["title"] as? String
    }
}