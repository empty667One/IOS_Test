//
//	GoodsBrandData.swift
//	模型生成器（小波汉化）JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

extension GoodsBrandData{
    
    /**
    返回大品牌名称和图片url
    
    - returns:
    */
    func ex_ex_dataForCellShow()->(name:String,imgUrl:String){
        return (self.name,self.icon)
    }
}

class GoodsBrandData{

	var brandid : Int!
	var icon : String!
	var name : String!


	/**
	 * 用字典来初始化一个实例并设置各个属性值
	 */
	init(fromDictionary dictionary: NSDictionary){
		brandid = dictionary["brandid"] as? Int
		icon = dictionary["icon"] as? String
		name = dictionary["name"] as? String
	}

}