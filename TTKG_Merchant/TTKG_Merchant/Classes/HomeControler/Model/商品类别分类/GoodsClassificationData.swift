//
//	GoodsClassificationData.swift
//	模型生成器（小波汉化）JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


extension GoodsClassificationData{
    /**
    返回商品分类名称和对应的img
    
    - returns:name 分类名称    imgUrl 图片url
    */
    func ex_dataForCellShow()->(name:String,imgUrl:String){
        return (self.name,self.icon)
    }
}



class GoodsClassificationData{

	var categoryid : Int!
	var icon : String!
	var name : String!


	/**
	 * 用字典来初始化一个实例并设置各个属性值
	 */
	init(fromDictionary dictionary: NSDictionary){
		categoryid = dictionary["categoryid"] as? Int
		icon = dictionary["icon"] as? String
		name = dictionary["name"] as? String
	}

}