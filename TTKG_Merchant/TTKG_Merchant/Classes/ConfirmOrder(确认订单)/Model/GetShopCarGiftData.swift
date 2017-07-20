//
//	GetShopCarGiftData.swift
//
//	Create by yd on 16/8/2016
//	Copyright © 2016. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

class GetShopCarGiftData{

	var actitiemassage : String!
	var discountamount : Int!
	var hasdiscount : Bool!
	var items : [GetShopCarGiftItem]!
	var shopname : String!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: NSDictionary){
		actitiemassage = dictionary["actitiemassage"] as? String
		discountamount = dictionary["discountamount"] as? Int
		hasdiscount = dictionary["hasdiscount"] as? Bool
		items = [GetShopCarGiftItem]()
		if let itemsArray = dictionary["items"] as? [NSDictionary]{
			for dic in itemsArray{
				let value = GetShopCarGiftItem(fromDictionary: dic)
				items.append(value)
			}
		}
		shopname = dictionary["shopname"] as? String
	}

}