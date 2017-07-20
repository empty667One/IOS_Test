//
//	ScrollADData.swift
//	模型生成器（小波汉化）JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation



class ScrollADData{

	var datatype : Int! = Int()
	var picurl : String! =  String()
	var productid : Int! = Int()
	var remark : String! =  String()
	var shopid : Int! = Int()
	var title : String! =  String()


	/**
	 * 用字典来初始化一个实例并设置各个属性值
	 */
	init(fromDictionary dictionary: NSDictionary){
		datatype = dictionary["datatype"] as? Int
		picurl = dictionary["picurl"] as? String
		productid = dictionary["productid"] as? Int
		remark = dictionary["remark"] as? String
		shopid = dictionary["shopid"] as? Int
		title = dictionary["title"] as? String
	}

}