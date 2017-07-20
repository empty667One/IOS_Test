//
//  OrderListData.swift
//  TTKG_Merchant
//
//  Created by 123 on 17/7/6.
//  Copyright © 2017年 yd. All rights reserved.
//

import UIKit

class OrderListData: NSObject ,NSCoding{
    var orderno : String!
    var creattime : String!
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: NSDictionary){
        orderno = dictionary["orderno"] as? String
        creattime = dictionary["creattime"] as? String
        
    }
    
    /**
     * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> NSDictionary
    {
        var dictionary = NSMutableDictionary()
        if orderno != nil{
            dictionary["orderno"] = orderno
        }
        if creattime != nil{
            dictionary["creattime"] = creattime
        }
                return dictionary
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        orderno = aDecoder.decodeObjectForKey("orderno") as? String
        creattime = aDecoder.decodeObjectForKey("creattime") as? String
           }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encodeWithCoder(aCoder: NSCoder)
    {
        if orderno != nil{
            aCoder.encodeObject(orderno, forKey: "orderno")
        }
        if creattime != nil{
            aCoder.encodeObject(creattime, forKey: "creattime")
        }
           
    }

}
