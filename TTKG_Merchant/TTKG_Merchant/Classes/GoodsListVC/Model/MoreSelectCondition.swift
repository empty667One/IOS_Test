//
//	MoreSelectCondition.swift
//	模型生成器（小波汉化）JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

class MoreSelectCondition{

	var selectedFlag = Int()
	var title = [String]()

    init(title:[String],selectedFlag:Int){
        self.selectedFlag = selectedFlag
        self.title = title
    }

//	/**
//	 * 用字典来初始化一个实例并设置各个属性值
//	 */
//	init(fromDictionary dictionary: NSDictionary){
//		selected = dictionary["selected"] as? Int
//		title = dictionary["title"] as? [String]
//	}

}