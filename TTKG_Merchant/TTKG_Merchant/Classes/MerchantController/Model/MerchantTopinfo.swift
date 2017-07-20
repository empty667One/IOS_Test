//
//	MerchantTopinfo.swift
//
//	Create by yd on 8/8/2016
//	Copyright © 2016. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class MerchantTopinfo : NSObject, NSCoding{

	var activitycount : Int!
	var allproductcount : Int!
	var carryamount : String!
	var hotcount : Int!
	var order : Int!
	var privilege : String!
	var privilegecount : Int!
	var shopname : String!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: NSDictionary){
		activitycount = dictionary["activitycount"] as? Int
		allproductcount = dictionary["allproductcount"] as? Int
		carryamount = dictionary["carryamount"] as? String
		hotcount = dictionary["hotcount"] as? Int
		order = dictionary["order"] as? Int
		privilege = dictionary["privilege"] as? String
		privilegecount = dictionary["privilegecount"] as? Int
		shopname = dictionary["shopname"] as? String
	}

	/**
	 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> NSDictionary
	{
		var dictionary = NSMutableDictionary()
		if activitycount != nil{
			dictionary["activitycount"] = activitycount
		}
		if allproductcount != nil{
			dictionary["allproductcount"] = allproductcount
		}
		if carryamount != nil{
			dictionary["carryamount"] = carryamount
		}
		if hotcount != nil{
			dictionary["hotcount"] = hotcount
		}
		if order != nil{
			dictionary["order"] = order
		}
		if privilege != nil{
			dictionary["privilege"] = privilege
		}
		if privilegecount != nil{
			dictionary["privilegecount"] = privilegecount
		}
		if shopname != nil{
			dictionary["shopname"] = shopname
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         activitycount = aDecoder.decodeObjectForKey("activitycount") as? Int
         allproductcount = aDecoder.decodeObjectForKey("allproductcount") as? Int
         carryamount = aDecoder.decodeObjectForKey("carryamount") as? String
         hotcount = aDecoder.decodeObjectForKey("hotcount") as? Int
         order = aDecoder.decodeObjectForKey("order") as? Int
         privilege = aDecoder.decodeObjectForKey("privilege") as? String
         privilegecount = aDecoder.decodeObjectForKey("privilegecount") as? Int
         shopname = aDecoder.decodeObjectForKey("shopname") as? String

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encodeWithCoder(aCoder: NSCoder)
	{
		if activitycount != nil{
			aCoder.encodeObject(activitycount, forKey: "activitycount")
		}
		if allproductcount != nil{
			aCoder.encodeObject(allproductcount, forKey: "allproductcount")
		}
		if carryamount != nil{
			aCoder.encodeObject(carryamount, forKey: "carryamount")
		}
		if hotcount != nil{
			aCoder.encodeObject(hotcount, forKey: "hotcount")
		}
		if order != nil{
			aCoder.encodeObject(order, forKey: "order")
		}
		if privilege != nil{
			aCoder.encodeObject(privilege, forKey: "privilege")
		}
		if privilegecount != nil{
			aCoder.encodeObject(privilegecount, forKey: "privilegecount")
		}
		if shopname != nil{
			aCoder.encodeObject(shopname, forKey: "shopname")
		}

	}

}