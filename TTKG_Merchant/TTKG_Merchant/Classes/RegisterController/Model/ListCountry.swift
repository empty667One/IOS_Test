//
//	ListCountry.swift
//
//	Create by yd on 3/8/2016
//	Copyright © 2016. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class ListCountry : NSObject, NSCoding{

	var countryid : Int!
	var countryname : String!
	var streets : [ListStreet]!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: NSDictionary){
		countryid = dictionary["countryid"] as? Int
		countryname = dictionary["countryname"] as? String
		streets = [ListStreet]()
		if let streetsArray = dictionary["streets"] as? [NSDictionary]{
			for dic in streetsArray{
				let value = ListStreet(fromDictionary: dic)
				streets.append(value)
			}
		}
	}

	/**
	 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> NSDictionary
	{
		var dictionary = NSMutableDictionary()
		if countryid != nil{
			dictionary["countryid"] = countryid
		}
		if countryname != nil{
			dictionary["countryname"] = countryname
		}
		if streets != nil{
			var dictionaryElements = [NSDictionary]()
			for streetsElement in streets {
				dictionaryElements.append(streetsElement.toDictionary())
			}
			dictionary["streets"] = dictionaryElements
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         countryid = aDecoder.decodeObjectForKey("countryid") as? Int
         countryname = aDecoder.decodeObjectForKey("countryname") as? String
         streets = aDecoder.decodeObjectForKey("streets") as? [ListStreet]

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encodeWithCoder(aCoder: NSCoder)
	{
		if countryid != nil{
			aCoder.encodeObject(countryid, forKey: "countryid")
		}
		if countryname != nil{
			aCoder.encodeObject(countryname, forKey: "countryname")
		}
		if streets != nil{
			aCoder.encodeObject(streets, forKey: "streets")
		}

	}

}