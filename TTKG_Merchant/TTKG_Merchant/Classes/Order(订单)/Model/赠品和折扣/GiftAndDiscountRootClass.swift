//
//	GiftAndDiscountRootClass.swift
//	模型生成器（小波汉化）JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

class GiftAndDiscountRootClass{

	var code : Int!
	var data : GiftAndDiscountData!
	var msg : String!


	/**
	 * 用字典来初始化一个实例并设置各个属性值
	 */
	init(fromDictionary dictionary: NSDictionary){
		code = dictionary["code"] as? Int
		if let dataData = dictionary["data"] as? NSDictionary{
			data = GiftAndDiscountData(fromDictionary: dataData)
		}
		msg = dictionary["msg"] as? String
	}

}