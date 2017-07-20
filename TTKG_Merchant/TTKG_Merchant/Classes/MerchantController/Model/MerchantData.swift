//
//	MerchantData.swift
//
//	Create by yd on 8/8/2016
//	Copyright © 2016. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class MerchantData : NSObject, NSCoding{

	var bottominfo : [MerchantBottominfo]!
	var topinfo : MerchantTopinfo!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: NSDictionary){
		bottominfo = [MerchantBottominfo]()
		if let bottominfoArray = dictionary["bottominfo"] as? [NSDictionary]{
			for dic in bottominfoArray{
				let value = MerchantBottominfo(fromDictionary: dic)
				bottominfo.append(value)
			}
		}
		if let topinfoData = dictionary["topinfo"] as? NSDictionary{
			topinfo = MerchantTopinfo(fromDictionary: topinfoData)
		}
	}

	/**
	 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> NSDictionary
	{
		var dictionary = NSMutableDictionary()
		if bottominfo != nil{
			var dictionaryElements = [NSDictionary]()
			for bottominfoElement in bottominfo {
				dictionaryElements.append(bottominfoElement.toDictionary())
			}
			dictionary["bottominfo"] = dictionaryElements
		}
		if topinfo != nil{
			dictionary["topinfo"] = topinfo.toDictionary()
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         bottominfo = aDecoder.decodeObjectForKey("bottominfo") as? [MerchantBottominfo]
         topinfo = aDecoder.decodeObjectForKey("topinfo") as? MerchantTopinfo

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encodeWithCoder(aCoder: NSCoder)
	{
		if bottominfo != nil{
			aCoder.encodeObject(bottominfo, forKey: "bottominfo")
		}
		if topinfo != nil{
			aCoder.encodeObject(topinfo, forKey: "topinfo")
		}

	}

}