//
//	GoodsClassificationRootClass.swift
//	模型生成器（小波汉化）JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

class GoodsClassificationRootClass{

	var code : Int!
	var data : [GoodsClassificationData]!
	var msg : String!


	/**
	 * 用字典来初始化一个实例并设置各个属性值
	 */
	init(fromDictionary dictionary: NSDictionary){
		code = dictionary["code"] as? Int
		data = [GoodsClassificationData]()
		if let dataArray = dictionary["data"] as? [NSDictionary]{
			for dic in dataArray{
				let value = GoodsClassificationData(fromDictionary: dic)
				data.append(value)
			}
		}
		msg = dictionary["msg"] as? String
	}

}