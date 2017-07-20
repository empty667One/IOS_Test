//
//	CData.swift
//
//	Create by yd on 4/8/2016
//	Copyright © 2016. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class CData : NSObject, NSCoding{
    
    var list : [CList]!
    var name : String!
    var selectFlag = false
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: NSDictionary){
        list = [CList]()
        if let listArray = dictionary["list"] as? [NSDictionary]{
            for dic in listArray{
                let value = CList(fromDictionary: dic)
                list.append(value)
            }
        }
        name = dictionary["name"] as? String
    }
    
    /**
     * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> NSDictionary
    {
        var dictionary = NSMutableDictionary()
        if list != nil{
            var dictionaryElements = [NSDictionary]()
            for listElement in list {
                dictionaryElements.append(listElement.toDictionary())
            }
            dictionary["list"] = dictionaryElements
        }
        if name != nil{
            dictionary["name"] = name
        }
        return dictionary
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        list = aDecoder.decodeObjectForKey("list") as? [CList]
        name = aDecoder.decodeObjectForKey("name") as? String
        
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encodeWithCoder(aCoder: NSCoder)
    {
        if list != nil{
            aCoder.encodeObject(list, forKey: "list")
        }
        if name != nil{
            aCoder.encodeObject(name, forKey: "name")
        }
        
    }
    
}