//
//	AppUpDateRootClass.swift
//	模型生成器（小波汉化）JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

class AppUpDateRootClass{

	var resultCount : Int!
	var results : [AppUpDateResult]!


	/**
	 * 用字典来初始化一个实例并设置各个属性值
	 */
	init(fromDictionary dictionary: NSDictionary){
		resultCount = dictionary["resultCount"] as? Int
		results = [AppUpDateResult]()
		if let resultsArray = dictionary["results"] as? [NSDictionary]{
			for dic in resultsArray{
				let value = AppUpDateResult(fromDictionary: dic)
				results.append(value)
			}
		}
	}

}