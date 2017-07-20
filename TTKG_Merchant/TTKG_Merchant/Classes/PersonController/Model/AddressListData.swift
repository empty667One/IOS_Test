//
//	AddressListData.swift
//
//	Create by macmini on 15/8/2016
//	Copyright © 2016. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class AddressListData : NSObject, NSCoding{

	var address : String!
	var addressid : Int!
	var country : String!
	var isaudit : Int!
	var isdefault : Bool!
	var name : String!
	var phone : String!
	var postcode : String!
	var sparetel : String!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: NSDictionary){
		address = dictionary["address"] as? String
		addressid = dictionary["addressid"] as? Int
		country = dictionary["country"] as? String
		isaudit = dictionary["isaudit"] as? Int
		isdefault = dictionary["isdefault"] as? Bool
		name = dictionary["name"] as? String
		phone = dictionary["phone"] as? String
		postcode = dictionary["postcode"] as? String
		sparetel = dictionary["sparetel"] as? String
	}

	/**
	 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> NSDictionary
	{
		var dictionary = NSMutableDictionary()
		if address != nil{
			dictionary["address"] = address
		}
		if addressid != nil{
			dictionary["addressid"] = addressid
		}
		if country != nil{
			dictionary["country"] = country
		}
		if isaudit != nil{
			dictionary["isaudit"] = isaudit
		}
		if isdefault != nil{
			dictionary["isdefault"] = isdefault
		}
		if name != nil{
			dictionary["name"] = name
		}
		if phone != nil{
			dictionary["phone"] = phone
		}
		if postcode != nil{
			dictionary["postcode"] = postcode
		}
		if sparetel != nil{
			dictionary["sparetel"] = sparetel
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         address = aDecoder.decodeObjectForKey("address") as? String
         addressid = aDecoder.decodeObjectForKey("addressid") as? Int
         country = aDecoder.decodeObjectForKey("country") as? String
         isaudit = aDecoder.decodeObjectForKey("isaudit") as? Int
         isdefault = aDecoder.decodeObjectForKey("isdefault") as? Bool
         name = aDecoder.decodeObjectForKey("name") as? String
         phone = aDecoder.decodeObjectForKey("phone") as? String
         postcode = aDecoder.decodeObjectForKey("postcode") as? String
         sparetel = aDecoder.decodeObjectForKey("sparetel") as? String

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encodeWithCoder(aCoder: NSCoder)
	{
		if address != nil{
			aCoder.encodeObject(address, forKey: "address")
		}
		if addressid != nil{
			aCoder.encodeObject(addressid, forKey: "addressid")
		}
		if country != nil{
			aCoder.encodeObject(country, forKey: "country")
		}
		if isaudit != nil{
			aCoder.encodeObject(isaudit, forKey: "isaudit")
		}
		if isdefault != nil{
			aCoder.encodeObject(isdefault, forKey: "isdefault")
		}
		if name != nil{
			aCoder.encodeObject(name, forKey: "name")
		}
		if phone != nil{
			aCoder.encodeObject(phone, forKey: "phone")
		}
		if postcode != nil{
			aCoder.encodeObject(postcode, forKey: "postcode")
		}
		if sparetel != nil{
			aCoder.encodeObject(sparetel, forKey: "sparetel")
		}

	}

}