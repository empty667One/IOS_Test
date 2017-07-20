//
//	GiftAndDiscountProduct.swift
//	模型生成器（小波汉化）JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

class GiftAndDiscountProduct{

	var activitiemassage : String!
	var productname : String!


	/**
	 * 用字典来初始化一个实例并设置各个属性值
	 */
	init(fromDictionary dictionary: NSDictionary){
		activitiemassage = dictionary["activitiemassage"] as? String
		productname = dictionary["productname"] as? String
	}

}