//
//	ListStreet.swift
//
//	Create by yd on 3/8/2016
//	Copyright © 2016. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class ListStreet : NSObject, NSCoding{

	var streetid : Int!
	var streetname : String!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: NSDictionary){
		streetid = dictionary["streetid"] as? Int
		streetname = dictionary["streetname"] as? String
	}

	/**
	 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> NSDictionary
	{
		var dictionary = NSMutableDictionary()
		if streetid != nil{
			dictionary["streetid"] = streetid
		}
		if streetname != nil{
			dictionary["streetname"] = streetname
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         streetid = aDecoder.decodeObjectForKey("streetid") as? Int
         streetname = aDecoder.decodeObjectForKey("streetname") as? String

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encodeWithCoder(aCoder: NSCoder)
	{
		if streetid != nil{
			aCoder.encodeObject(streetid, forKey: "streetid")
		}
		if streetname != nil{
			aCoder.encodeObject(streetname, forKey: "streetname")
		}

	}

}