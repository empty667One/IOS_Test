//
//  DetalOrderListData.swift
//  TTKG_Merchant
//
//  Created by 123 on 17/7/8.
//  Copyright © 2017年 yd. All rights reserved.
//

import UIKit

class DetalOrderListData: NSObject,NSCoding {
    var mc : String!  //产品名
    var sl : Int!     //数量
    var dw : String!  //单位
    var zj : Double!  //总价
    var hj : Double!  //合计
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: NSDictionary){
        
        mc = dictionary["mc"] as? String
        sl = dictionary["sl"] as? Int
        
        dw = dictionary["dw"] as? String
        zj = dictionary["zj"] as? Double
        hj = dictionary["hj"] as? Double

    }
    
    /**
     * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> NSDictionary
    {
        var dictionary = NSMutableDictionary()
       
        if mc != nil{
            dictionary["mc"] = mc
        }
        if sl != nil{
            dictionary["sl"] = sl
        }
       
        if dw != nil{
            dictionary["dw"] = dw
        }
        if zj != nil{
            dictionary["zj"] = zj
        }
        if hj != nil{
            dictionary["hj"] = hj
        }

        return dictionary
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        
        mc = aDecoder.decodeObjectForKey("mc") as? String
        sl = aDecoder.decodeObjectForKey("sl") as? Int
        dw = aDecoder.decodeObjectForKey("dw") as? String
        zj = aDecoder.decodeObjectForKey("zj") as? Double
        hj = aDecoder.decodeObjectForKey("hj") as? Double

        
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encodeWithCoder(aCoder: NSCoder)
    {
        
        if mc != nil{
            aCoder.encodeObject(mc, forKey: "mc")
        }
        if sl != nil{
            aCoder.encodeObject(sl, forKey: "sl")
        }
        
        if dw != nil{
            aCoder.encodeObject(dw, forKey: "dw")
        }
        if zj != nil{
            aCoder.encodeObject(zj, forKey: "zj")
        }
        if zj != nil{
            aCoder.encodeObject(zj, forKey: "zj")
        }
        
    }

}
