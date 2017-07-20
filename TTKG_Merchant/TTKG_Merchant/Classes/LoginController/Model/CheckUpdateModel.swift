//
//	CheckUpdateModel.swift
//
//	Create by yd on 31/8/2016
//	Copyright © 2016. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class CheckUpdateModel : NSObject, NSCoding{

	var appstate : Int!
	var descriptionField : String!
	var msg : String!
	var state : Int!
	var success : Bool!
	var version : String!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: NSDictionary){
		appstate = dictionary["appstate"] as? Int
		descriptionField = dictionary["description"] as? String
		msg = dictionary["msg"] as? String
		state = dictionary["state"] as? Int
		success = dictionary["success"] as? Bool
		version = dictionary["version"] as? String
	}

	/**
	 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> NSDictionary
	{
		var dictionary = NSMutableDictionary()
		if appstate != nil{
			dictionary["appstate"] = appstate
		}
		if descriptionField != nil{
			dictionary["description"] = descriptionField
		}
		if msg != nil{
			dictionary["msg"] = msg
		}
		if state != nil{
			dictionary["state"] = state
		}
		if success != nil{
			dictionary["success"] = success
		}
		if version != nil{
			dictionary["version"] = version
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         appstate = aDecoder.decodeObjectForKey("appstate") as? Int
         descriptionField = aDecoder.decodeObjectForKey("description") as? String
         msg = aDecoder.decodeObjectForKey("msg") as? String
         state = aDecoder.decodeObjectForKey("state") as? Int
         success = aDecoder.decodeObjectForKey("success") as? Bool
         version = aDecoder.decodeObjectForKey("version") as? String

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encodeWithCoder(aCoder: NSCoder)
	{
		if appstate != nil{
			aCoder.encodeObject(appstate, forKey: "appstate")
		}
		if descriptionField != nil{
			aCoder.encodeObject(descriptionField, forKey: "description")
		}
		if msg != nil{
			aCoder.encodeObject(msg, forKey: "msg")
		}
		if state != nil{
			aCoder.encodeObject(state, forKey: "state")
		}
		if success != nil{
			aCoder.encodeObject(success, forKey: "success")
		}
		if version != nil{
			aCoder.encodeObject(version, forKey: "version")
		}

	}

}