//
//	GoodsDetailInfoProperty.swift
//
//	Create by yd on 12/8/2016
//	Copyright © 2016. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class GoodsDetailInfoProperty : NSObject, NSCoding{

	var propertyoptions : [GoodsDetailInfoPropertyoption]!
	var propertytitle : String!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: NSDictionary){
		propertyoptions = [GoodsDetailInfoPropertyoption]()
		if let propertyoptionsArray = dictionary["propertyoptions"] as? [NSDictionary]{
			for dic in propertyoptionsArray{
				let value = GoodsDetailInfoPropertyoption(fromDictionary: dic)
				propertyoptions.append(value)
			}
		}
		propertytitle = dictionary["propertytitle"] as? String
	}

	/**
	 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> NSDictionary
	{
		var dictionary = NSMutableDictionary()
		if propertyoptions != nil{
			var dictionaryElements = [NSDictionary]()
			for propertyoptionsElement in propertyoptions {
				dictionaryElements.append(propertyoptionsElement.toDictionary())
			}
			dictionary["propertyoptions"] = dictionaryElements
		}
		if propertytitle != nil{
			dictionary["propertytitle"] = propertytitle
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         propertyoptions = aDecoder.decodeObjectForKey("propertyoptions") as? [GoodsDetailInfoPropertyoption]
         propertytitle = aDecoder.decodeObjectForKey("propertytitle") as? String

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encodeWithCoder(aCoder: NSCoder)
	{
		if propertyoptions != nil{
			aCoder.encodeObject(propertyoptions, forKey: "propertyoptions")
		}
		if propertytitle != nil{
			aCoder.encodeObject(propertytitle, forKey: "propertytitle")
		}

	}

}