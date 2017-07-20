//
//	ListCity.swift
//
//	Create by yd on 3/8/2016
//	Copyright © 2016. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class ListCity : NSObject, NSCoding{

	var cityid : Int!
	var cityname : String!
	var countrys : [ListCountry]!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: NSDictionary){
		cityid = dictionary["cityid"] as? Int
		cityname = dictionary["cityname"] as? String
		countrys = [ListCountry]()
		if let countrysArray = dictionary["countrys"] as? [NSDictionary]{
			for dic in countrysArray{
				let value = ListCountry(fromDictionary: dic)
				countrys.append(value)
			}
		}
	}

	/**
	 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> NSDictionary
	{
		var dictionary = NSMutableDictionary()
		if cityid != nil{
			dictionary["cityid"] = cityid
		}
		if cityname != nil{
			dictionary["cityname"] = cityname
		}
		if countrys != nil{
			var dictionaryElements = [NSDictionary]()
			for countrysElement in countrys {
				dictionaryElements.append(countrysElement.toDictionary())
			}
			dictionary["countrys"] = dictionaryElements
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         cityid = aDecoder.decodeObjectForKey("cityid") as? Int
         cityname = aDecoder.decodeObjectForKey("cityname") as? String
         countrys = aDecoder.decodeObjectForKey("countrys") as? [ListCountry]

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encodeWithCoder(aCoder: NSCoder)
	{
		if cityid != nil{
			aCoder.encodeObject(cityid, forKey: "cityid")
		}
		if cityname != nil{
			aCoder.encodeObject(cityname, forKey: "cityname")
		}
		if countrys != nil{
			aCoder.encodeObject(countrys, forKey: "countrys")
		}

	}

}