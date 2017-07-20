//
//	ShoppingCarProduct.swift
//	模型生成器（小波汉化）JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

class ShoppingCarProduct{

	var cartid : Int!
	var image : String!
	var merchantid : Int!
	var price : Double!
	var productname : String!
	var quantity : Int!

    //默认选中
    var selectedFlag = true {
        didSet{
            let notice:NSNotification =  NSNotification(name: "shoppingCarModelChanged", object: nil)
            NSNotificationCenter.defaultCenter().postNotification(notice)
        }
    }

	/**
	 * 用字典来初始化一个实例并设置各个属性值
	 */
	init(fromDictionary dictionary: NSDictionary){
		cartid = dictionary["cartid"] as? Int
		image = dictionary["image"] as? String
		merchantid = dictionary["merchantid"] as? Int
		price = dictionary["price"] as? Double
		productname = dictionary["productname"] as? String
		quantity = dictionary["quantity"] as? Int
	}

}