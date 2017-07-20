//
//	MerchantInfoProduct.swift
//	模型生成器（小波汉化）JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

class MerchantInfoProduct{

	var image : String!
	var price : Double!
    var productid : Int!


	/**
	 * 用字典来初始化一个实例并设置各个属性值
	 */
	init(fromDictionary dictionary: NSDictionary){
		image = dictionary["image"] as? String
		price = dictionary["price"] as? Double
        productid = dictionary["productid"] as? Int
	}

}