//
//	GoodsDetailInfoSpecioption.swift
//
//	Create by yd on 12/8/2016
//	Copyright © 2016. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class GoodsDetailInfoSpecioption : NSObject, NSCoding{

	var givemsg : String!
	var images : [GoodsDetailInfoImage]!
	var isgivestate : Bool!
	var ispromotional : Int!
	var merchantkeyid : Int!
	var minimum : Int!
	var originalprice : Double!
	var promotionalprice : Double!
	var salesvolume : Int!
	var specioptiontitle : String!
	var stock : Int!
    var isbuy : Int!

	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: NSDictionary){
		givemsg = dictionary["givemsg"] as? String
		images = [GoodsDetailInfoImage]()
		if let imagesArray = dictionary["images"] as? [NSDictionary]{
			for dic in imagesArray{
				let value = GoodsDetailInfoImage(fromDictionary: dic)
				images.append(value)
			}
		}
		isgivestate = dictionary["isgivestate"] as? Bool
		ispromotional = dictionary["ispromotional"] as? Int
		merchantkeyid = dictionary["merchantkeyid"] as? Int
		minimum = dictionary["minimum"] as? Int
		originalprice = dictionary["originalprice"] as? Double
		promotionalprice = dictionary["promotionalprice"] as? Double
		salesvolume = dictionary["salesvolume"] as? Int
		specioptiontitle = dictionary["specioptiontitle"] as? String
		stock = dictionary["stock"] as? Int
        isbuy = dictionary["isbuy"] as? Int
	}

	/**
	 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> NSDictionary
	{
		var dictionary = NSMutableDictionary()
		if givemsg != nil{
			dictionary["givemsg"] = givemsg
		}
		if images != nil{
			var dictionaryElements = [NSDictionary]()
			for imagesElement in images {
				dictionaryElements.append(imagesElement.toDictionary())
			}
			dictionary["images"] = dictionaryElements
		}
		if isgivestate != nil{
			dictionary["isgivestate"] = isgivestate
		}
		if ispromotional != nil{
			dictionary["ispromotional"] = ispromotional
		}
		if merchantkeyid != nil{
			dictionary["merchantkeyid"] = merchantkeyid
		}
		if minimum != nil{
			dictionary["minimum"] = minimum
		}
		if originalprice != nil{
			dictionary["originalprice"] = originalprice
		}
		if promotionalprice != nil{
			dictionary["promotionalprice"] = promotionalprice
		}
		if salesvolume != nil{
			dictionary["salesvolume"] = salesvolume
		}
		if specioptiontitle != nil{
			dictionary["specioptiontitle"] = specioptiontitle
		}
		if stock != nil{
			dictionary["stock"] = stock
		}
        if isbuy != nil {
            dictionary["isbuy"] = isbuy
        }
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         givemsg = aDecoder.decodeObjectForKey("givemsg") as? String
         images = aDecoder.decodeObjectForKey("images") as? [GoodsDetailInfoImage]
         isgivestate = aDecoder.decodeObjectForKey("isgivestate") as? Bool
         ispromotional = aDecoder.decodeObjectForKey("ispromotional") as? Int
         merchantkeyid = aDecoder.decodeObjectForKey("merchantkeyid") as? Int
         minimum = aDecoder.decodeObjectForKey("minimum") as? Int
         originalprice = aDecoder.decodeObjectForKey("originalprice") as? Double
         promotionalprice = aDecoder.decodeObjectForKey("promotionalprice") as? Double
         salesvolume = aDecoder.decodeObjectForKey("salesvolume") as? Int
         specioptiontitle = aDecoder.decodeObjectForKey("specioptiontitle") as? String
         stock = aDecoder.decodeObjectForKey("stock") as? Int
        isbuy = aDecoder.decodeObjectForKey("isbuy") as? Int

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encodeWithCoder(aCoder: NSCoder)
	{
		if givemsg != nil{
			aCoder.encodeObject(givemsg, forKey: "givemsg")
		}
		if images != nil{
			aCoder.encodeObject(images, forKey: "images")
		}
		if isgivestate != nil{
			aCoder.encodeObject(isgivestate, forKey: "isgivestate")
		}
		if ispromotional != nil{
			aCoder.encodeObject(ispromotional, forKey: "ispromotional")
		}
		if merchantkeyid != nil{
			aCoder.encodeObject(merchantkeyid, forKey: "merchantkeyid")
		}
		if minimum != nil{
			aCoder.encodeObject(minimum, forKey: "minimum")
		}
		if originalprice != nil{
			aCoder.encodeObject(originalprice, forKey: "originalprice")
		}
		if promotionalprice != nil{
			aCoder.encodeObject(promotionalprice, forKey: "promotionalprice")
		}
		if salesvolume != nil{
			aCoder.encodeObject(salesvolume, forKey: "salesvolume")
		}
		if specioptiontitle != nil{
			aCoder.encodeObject(specioptiontitle, forKey: "specioptiontitle")
		}
		if stock != nil{
			aCoder.encodeObject(stock, forKey: "stock")
		}
        if isbuy != nil {
            aCoder.encodeObject(isbuy,forKey: "isbuy")
        }

	}

}