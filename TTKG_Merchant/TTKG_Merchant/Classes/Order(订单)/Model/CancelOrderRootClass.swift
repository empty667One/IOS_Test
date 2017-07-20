//
//	CancelOrderRootClass.swift
//	模型生成器（小波汉化）JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class CancelOrderRootClass{

	var code : Int!
	var msg : String!
	var data : String!
	

	/**
	 * 用字典来初始化一个实例并设置各个属性值
	 */
	init(fromDictionary dictionary: NSDictionary){
		
		code = dictionary["code"] as? Int
		msg = dictionary["msg"] as? String
		data = dictionary["data"] as? String
	}



}