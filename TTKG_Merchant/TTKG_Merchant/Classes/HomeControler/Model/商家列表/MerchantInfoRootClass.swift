//
//	MerchantInfoRootClass.swift
//	模型生成器（小波汉化）JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

class MerchantInfoRootClass{

	var code : Int!
	var data : [MerchantInfoData]!
	var msg : String!


	/**
	 * 用字典来初始化一个实例并设置各个属性值
	 */
	init(fromDictionary dictionary: NSDictionary){
		code = dictionary["code"] as? Int
		data = [MerchantInfoData]()
		if let dataArray = dictionary["data"] as? [NSDictionary]{
			for dic in dataArray{
				let value = MerchantInfoData(fromDictionary: dic)
				data.append(value)
			}
		}
		msg = dictionary["msg"] as? String
	}

}