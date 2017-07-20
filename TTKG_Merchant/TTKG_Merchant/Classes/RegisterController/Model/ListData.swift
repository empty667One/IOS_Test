//
//	ListData.swift
//
//	Create by yd on 3/8/2016
//	Copyright © 2016. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class ListData : NSObject, NSCoding{

	var citys : [ListCity]!
	var provinceid : Int!
	var provincename : String!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: NSDictionary){
		citys = [ListCity]()
		if let citysArray = dictionary["citys"] as? [NSDictionary]{
			for dic in citysArray{
				let value = ListCity(fromDictionary: dic)
				citys.append(value)
			}
		}
		provinceid = dictionary["provinceid"] as? Int
		provincename = dictionary["provincename"] as? String
	}

	/**
	 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> NSDictionary
	{
		var dictionary = NSMutableDictionary()
		if citys != nil{
			var dictionaryElements = [NSDictionary]()
			for citysElement in citys {
				dictionaryElements.append(citysElement.toDictionary())
			}
			dictionary["citys"] = dictionaryElements
		}
		if provinceid != nil{
			dictionary["provinceid"] = provinceid
		}
		if provincename != nil{
			dictionary["provincename"] = provincename
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         citys = aDecoder.decodeObjectForKey("citys") as? [ListCity]
         provinceid = aDecoder.decodeObjectForKey("provinceid") as? Int
         provincename = aDecoder.decodeObjectForKey("provincename") as? String

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encodeWithCoder(aCoder: NSCoder)
	{
		if citys != nil{
			aCoder.encodeObject(citys, forKey: "citys")
		}
		if provinceid != nil{
			aCoder.encodeObject(provinceid, forKey: "provinceid")
		}
		if provincename != nil{
			aCoder.encodeObject(provincename, forKey: "provincename")
		}

	}

}