//
//	NormalSearchRootClass.swift
//	模型生成器（小波汉化）JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class NormalSearchRootClass : NSObject, NSCoding{

	var data : NormalSearchData!
	var message : String!
	var status : Int!
	var success : Bool!


	/**
	 * 用字典来初始化一个实例并设置各个属性值
	 */
	init(fromDictionary dictionary: NSDictionary){
		if let dataData = dictionary["data"] as? NSDictionary{
			data = NormalSearchData(fromDictionary: dataData)
		}
		message = dictionary["message"] as? String
		status = dictionary["status"] as? Int
		success = dictionary["success"] as? Bool
	}

	/**
	 * 把所有属性值存到一个NSDictionary对象，键是相应的属性名。
	 */
	func toDictionary() -> NSDictionary
	{
		var dictionary = NSMutableDictionary()
		if data != nil{
			dictionary["data"] = data.toDictionary()
		}
		if message != nil{
			dictionary["message"] = message
		}
		if status != nil{
			dictionary["status"] = status
		}
		if success != nil{
			dictionary["success"] = success
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         data = aDecoder.decodeObjectForKey("data") as? NormalSearchData
         message = aDecoder.decodeObjectForKey("message") as? String
         status = aDecoder.decodeObjectForKey("status") as? Int
         success = aDecoder.decodeObjectForKey("success") as? Bool

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encodeWithCoder(aCoder: NSCoder)
	{
		if data != nil{
			aCoder.encodeObject(data, forKey: "data")
		}
		if message != nil{
			aCoder.encodeObject(message, forKey: "message")
		}
		if status != nil{
			aCoder.encodeObject(status, forKey: "status")
		}
		if success != nil{
			aCoder.encodeObject(success, forKey: "success")
		}

	}

}