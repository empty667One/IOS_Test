//
//	GiftAndDiscountData.swift
//	模型生成器（小波汉化）JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

class GiftAndDiscountData{

	var actitiemassage : String!
	var discountamount : Double!
	var hasdiscount : Bool!
	var products : [GiftAndDiscountProduct]!
	var shopname : String!
	var timespan : String!


	/**
	 * 用字典来初始化一个实例并设置各个属性值
	 */
	init(fromDictionary dictionary: NSDictionary){
		actitiemassage = dictionary["actitiemassage"] as? String
		discountamount = dictionary["discountamount"] as? Double
		hasdiscount = dictionary["hasdiscount"] as? Bool
		products = [GiftAndDiscountProduct]()
		if let productsArray = dictionary["products"] as? [NSDictionary]{
			for dic in productsArray{
				let value = GiftAndDiscountProduct(fromDictionary: dic)
				products.append(value)
			}
		}
		shopname = dictionary["shopname"] as? String
		timespan = dictionary["timespan"] as? String
	}

}