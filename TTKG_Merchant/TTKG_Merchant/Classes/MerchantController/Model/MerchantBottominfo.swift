//
//	MerchantBottominfo.swift
//
//	Create by yd on 8/8/2016
//	Copyright © 2016. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class MerchantBottominfo : NSObject, NSCoding{

	var title : String!
	var value : String!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: NSDictionary){
		title = dictionary["title"] as? String
		value = dictionary["value"] as? String
	}

	/**
	 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> NSDictionary
	{
		var dictionary = NSMutableDictionary()
		if title != nil{
			dictionary["title"] = title
		}
		if value != nil{
			dictionary["value"] = value
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         title = aDecoder.decodeObjectForKey("title") as? String
         value = aDecoder.decodeObjectForKey("value") as? String

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encodeWithCoder(aCoder: NSCoder)
	{
		if title != nil{
			aCoder.encodeObject(title, forKey: "title")
		}
		if value != nil{
			aCoder.encodeObject(value, forKey: "value")
		}

	}

}