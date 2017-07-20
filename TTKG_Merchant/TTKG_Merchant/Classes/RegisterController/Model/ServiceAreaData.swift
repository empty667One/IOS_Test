//
//	ServiceAreaData.swift
//	模型生成器（小波汉化）JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class ServiceAreaData : NSObject, NSCoding{

	var citys : [AnyObject]!
	var provinceid : Int!
	var provincename : String!


	/**
	 * 用字典来初始化一个实例并设置各个属性值
	 */
	init(fromDictionary dictionary: NSDictionary){
		citys = dictionary["citys"] as? [AnyObject]
		provinceid = dictionary["provinceid"] as? Int
		provincename = dictionary["provincename"] as? String
	}

	/**
	 * 把所有属性值存到一个NSDictionary对象，键是相应的属性名。
	 */
	func toDictionary() -> NSDictionary
	{
		let dictionary = NSMutableDictionary()
		if citys != nil{
			dictionary["citys"] = citys
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
         citys = aDecoder.decodeObjectForKey("citys") as? [AnyObject]
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