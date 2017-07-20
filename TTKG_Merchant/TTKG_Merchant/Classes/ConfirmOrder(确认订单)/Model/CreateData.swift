//
//	CreateData.swift
//
//	Create by yd on 12/7/2016
//	Copyright © 2016. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class CreateData {

    var timespan : String!
    var totalfee : String!
    var tradeno : String!
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: NSDictionary){
        timespan = dictionary["timespan"] as? String
        totalfee = dictionary["totalfee"] as? String
        tradeno = dictionary["tradeno"] as? String
    }
}