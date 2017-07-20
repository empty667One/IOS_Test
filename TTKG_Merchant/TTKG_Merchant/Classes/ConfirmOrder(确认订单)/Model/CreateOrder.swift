//
//	CreateOrder.swift
//
//	Create by yd on 12/7/2016
//	Copyright © 2016. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class CreateOrder {

    var code : Int!
    var data : CreateData!
    var msg : String!
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: NSDictionary){
        code = dictionary["code"] as? Int
        if let dataData = dictionary["data"] as? NSDictionary{
            data = CreateData(fromDictionary: dataData)
        }
        msg = dictionary["msg"] as? String
    }
}