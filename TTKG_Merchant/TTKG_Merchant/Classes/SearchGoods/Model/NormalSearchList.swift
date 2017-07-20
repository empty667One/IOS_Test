//
//	NormalSearchList.swift
//	模型生成器（小波汉化）JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


extension NormalSearchList {
    func ex_infoForCell() -> (name:String,imgurl:String,nowPrice:String,oldPrice:String?,gift:String?) {
        let imgurl = self.img
        let name = self.name
        var nowPrice:String = String()
        var oldPrice:String?
        var gift:String?
        
        if self.ispromotion == 0 {//是否促销 0：开启；1：关闭
            nowPrice = self.promotionprice.description
            oldPrice = self.price.description
        }else{
            nowPrice = self.price.description
        }
        
        if self.isgive == 0 {//1,//是否开启活动 0:开启，1:关闭
            gift = self.give
        }
        
        return (name,imgurl,nowPrice,oldPrice,gift)
    }
}

class NormalSearchList : NSObject, NSCoding{

	var give : String!
	var img : String!
	var isgive : Int!
	var ispromotion : Int!
	var name : String!
	var price : Double!
	var proid : Int!
	var promotionprice : Double!
	var sales : Int!


	/**
	 * 用字典来初始化一个实例并设置各个属性值
	 */
	init(fromDictionary dictionary: NSDictionary){
		give = dictionary["give"] as? String
		img = dictionary["img"] as? String
		isgive = dictionary["isgive"] as? Int
		ispromotion = dictionary["ispromotion"] as? Int
		name = dictionary["name"] as? String
		price = dictionary["price"] as? Double
		proid = dictionary["proid"] as? Int
		promotionprice = dictionary["promotionprice"] as? Double
		sales = dictionary["sales"] as? Int
	}

	/**
	 * 把所有属性值存到一个NSDictionary对象，键是相应的属性名。
	 */
	func toDictionary() -> NSDictionary
	{
		var dictionary = NSMutableDictionary()
		if give != nil{
			dictionary["give"] = give
		}
		if img != nil{
			dictionary["img"] = img
		}
		if isgive != nil{
			dictionary["isgive"] = isgive
		}
		if ispromotion != nil{
			dictionary["ispromotion"] = ispromotion
		}
		if name != nil{
			dictionary["name"] = name
		}
		if price != nil{
			dictionary["price"] = price
		}
		if proid != nil{
			dictionary["proid"] = proid
		}
		if promotionprice != nil{
			dictionary["promotionprice"] = promotionprice
		}
		if sales != nil{
			dictionary["sales"] = sales
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         give = aDecoder.decodeObjectForKey("give") as? String
         img = aDecoder.decodeObjectForKey("img") as? String
         isgive = aDecoder.decodeObjectForKey("isgive") as? Int
         ispromotion = aDecoder.decodeObjectForKey("ispromotion") as? Int
         name = aDecoder.decodeObjectForKey("name") as? String
         price = aDecoder.decodeObjectForKey("price") as? Double
         proid = aDecoder.decodeObjectForKey("proid") as? Int
         promotionprice = aDecoder.decodeObjectForKey("promotionprice") as? Double
         sales = aDecoder.decodeObjectForKey("sales") as? Int

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encodeWithCoder(aCoder: NSCoder)
	{
		if give != nil{
			aCoder.encodeObject(give, forKey: "give")
		}
		if img != nil{
			aCoder.encodeObject(img, forKey: "img")
		}
		if isgive != nil{
			aCoder.encodeObject(isgive, forKey: "isgive")
		}
		if ispromotion != nil{
			aCoder.encodeObject(ispromotion, forKey: "ispromotion")
		}
		if name != nil{
			aCoder.encodeObject(name, forKey: "name")
		}
		if price != nil{
			aCoder.encodeObject(price, forKey: "price")
		}
		if proid != nil{
			aCoder.encodeObject(proid, forKey: "proid")
		}
		if promotionprice != nil{
			aCoder.encodeObject(promotionprice, forKey: "promotionprice")
		}
		if sales != nil{
			aCoder.encodeObject(sales, forKey: "sales")
		}

	}

}