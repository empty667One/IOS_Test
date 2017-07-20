//
//	PayResultModel.swift
//
//	Create by yd on 17/8/2016
//	Copyright © 2016. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class PayResultModel : NSObject, NSCoding{

	var code : Int!
	var msg : String!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: NSDictionary){
		code = dictionary["code"] as? Int
		msg = dictionary["msg"] as? String
	}

	/**
	 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> NSDictionary
	{
		var dictionary = NSMutableDictionary()
		if code != nil{
			dictionary["code"] = code
		}
		if msg != nil{
			dictionary["msg"] = msg
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         code = aDecoder.decodeObjectForKey("code") as? Int
         msg = aDecoder.decodeObjectForKey("msg") as? String

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encodeWithCoder(aCoder: NSCoder)
	{
		if code != nil{
			aCoder.encodeObject(code, forKey: "code")
		}
		if msg != nil{
			aCoder.encodeObject(msg, forKey: "msg")
		}

	}

}