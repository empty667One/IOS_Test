//
//	MerchantADDetailData.swift
//
//	Create by yd on 10/8/2016
//	Copyright © 2016. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class MerchantADDetailData : NSObject, NSCoding{

	var datatype : Int!
	var picurl : String!
	var productid : Int!
	var remark : String!
	var shopid : Int!
	var title : String!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: NSDictionary){
		datatype = dictionary["datatype"] as? Int
		picurl = dictionary["picurl"] as? String
		productid = dictionary["productid"] as? Int
		remark = dictionary["remark"] as? String
		shopid = dictionary["shopid"] as? Int
		title = dictionary["title"] as? String
	}

	/**
	 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> NSDictionary
	{
		var dictionary = NSMutableDictionary()
		if datatype != nil{
			dictionary["datatype"] = datatype
		}
		if picurl != nil{
			dictionary["picurl"] = picurl
		}
		if productid != nil{
			dictionary["productid"] = productid
		}
		if remark != nil{
			dictionary["remark"] = remark
		}
		if shopid != nil{
			dictionary["shopid"] = shopid
		}
		if title != nil{
			dictionary["title"] = title
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         datatype = aDecoder.decodeObjectForKey("datatype") as? Int
         picurl = aDecoder.decodeObjectForKey("picurl") as? String
         productid = aDecoder.decodeObjectForKey("productid") as? Int
         remark = aDecoder.decodeObjectForKey("remark") as? String
         shopid = aDecoder.decodeObjectForKey("shopid") as? Int
         title = aDecoder.decodeObjectForKey("title") as? String

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encodeWithCoder(aCoder: NSCoder)
	{
		if datatype != nil{
			aCoder.encodeObject(datatype, forKey: "datatype")
		}
		if picurl != nil{
			aCoder.encodeObject(picurl, forKey: "picurl")
		}
		if productid != nil{
			aCoder.encodeObject(productid, forKey: "productid")
		}
		if remark != nil{
			aCoder.encodeObject(remark, forKey: "remark")
		}
		if shopid != nil{
			aCoder.encodeObject(shopid, forKey: "shopid")
		}
		if title != nil{
			aCoder.encodeObject(title, forKey: "title")
		}

	}

}