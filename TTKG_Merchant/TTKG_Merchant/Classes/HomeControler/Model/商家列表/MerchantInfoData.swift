//
//	MerchantInfoData.swift
//	模型生成器（小波汉化）JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

class MerchantInfoData{

	var brands : String!
	var carryingamount : Int!
	var products : [MerchantInfoProduct]!
	var shopid : Int!
	var shopname : String!


	/**
	 * 用字典来初始化一个实例并设置各个属性值
	 */
	init(fromDictionary dictionary: NSDictionary){
		brands = dictionary["brands"] as? String
		carryingamount = dictionary["carryingamount"] as? Int
		products = [MerchantInfoProduct]()
		if let productsArray = dictionary["products"] as? [NSDictionary]{
			for dic in productsArray{
				let value = MerchantInfoProduct(fromDictionary: dic)
				products.append(value)
			}
		}
		shopid = dictionary["shopid"] as? Int
		shopname = dictionary["shopname"] as? String
	}

}