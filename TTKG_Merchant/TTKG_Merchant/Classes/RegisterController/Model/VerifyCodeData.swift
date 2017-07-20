//
//	VerifyCodeData.swift
//	模型生成器（小波汉化）JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class VerifyCodeData : NSObject, NSCoding{

	var phone : String!
	var vcode : String!


	/**
	 * 用字典来初始化一个实例并设置各个属性值
	 */
	init(fromDictionary dictionary: NSDictionary){
		phone = dictionary["phone"] as? String
		vcode = dictionary["vcode"] as? String
	}

	/**
	 * 把所有属性值存到一个NSDictionary对象，键是相应的属性名。
	 */
	func toDictionary() -> NSDictionary
	{
		let dictionary = NSMutableDictionary()
		if phone != nil{
			dictionary["phone"] = phone
		}
		if vcode != nil{
			dictionary["vcode"] = vcode
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         phone = aDecoder.decodeObjectForKey("phone") as? String
         vcode = aDecoder.decodeObjectForKey("vcode") as? String

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encodeWithCoder(aCoder: NSCoder)
	{
		if phone != nil{
			aCoder.encodeObject(phone, forKey: "phone")
		}
		if vcode != nil{
			aCoder.encodeObject(vcode, forKey: "vcode")
		}

	}

}