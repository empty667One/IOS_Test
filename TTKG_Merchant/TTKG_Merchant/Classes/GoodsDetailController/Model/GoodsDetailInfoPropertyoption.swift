//
//	GoodsDetailInfoPropertyoption.swift
//
//	Create by yd on 12/8/2016
//	Copyright © 2016. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class GoodsDetailInfoPropertyoption : NSObject, NSCoding{

	var propertykeyid : Int!
	var title : String!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: NSDictionary){
		propertykeyid = dictionary["propertykeyid"] as? Int
		title = dictionary["title"] as? String
	}

	/**
	 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> NSDictionary
	{
		var dictionary = NSMutableDictionary()
		if propertykeyid != nil{
			dictionary["propertykeyid"] = propertykeyid
		}
		if title != nil{
			dictionary["title"] = title
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         propertykeyid = aDecoder.decodeObjectForKey("propertykeyid") as? Int
         title = aDecoder.decodeObjectForKey("title") as? String

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encodeWithCoder(aCoder: NSCoder)
	{
		if propertykeyid != nil{
			aCoder.encodeObject(propertykeyid, forKey: "propertykeyid")
		}
		if title != nil{
			aCoder.encodeObject(title, forKey: "title")
		}

	}

}