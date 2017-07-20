//
//	CList.swift
//
//	Create by yd on 4/8/2016
//	Copyright © 2016. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class CList : NSObject, NSCoding{

	var categoryid : Int!
	var icon : String!
	var name : String!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: NSDictionary){
		categoryid = dictionary["categoryid"] as? Int
		icon = dictionary["icon"] as? String
		name = dictionary["name"] as? String
	}

	/**
	 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> NSDictionary
	{
		var dictionary = NSMutableDictionary()
		if categoryid != nil{
			dictionary["categoryid"] = categoryid
		}
		if icon != nil{
			dictionary["icon"] = icon
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
         categoryid = aDecoder.decodeObjectForKey("categoryid") as? Int
         icon = aDecoder.decodeObjectForKey("icon") as? String
         name = aDecoder.decodeObjectForKey("name") as? String

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encodeWithCoder(aCoder: NSCoder)
	{
		if categoryid != nil{
			aCoder.encodeObject(categoryid, forKey: "categoryid")
		}
		if icon != nil{
			aCoder.encodeObject(icon, forKey: "icon")
		}
		if name != nil{
			aCoder.encodeObject(name, forKey: "name")
		}

	}

}