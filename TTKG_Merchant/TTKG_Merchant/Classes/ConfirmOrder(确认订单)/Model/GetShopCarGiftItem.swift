//
//	GetShopCarGiftItem.swift
//
//	Create by yd on 16/8/2016
//	Copyright © 2016. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

class GetShopCarGiftItem{

	var activitiemassage : String!
	var productname : String!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: NSDictionary){
		activitiemassage = dictionary["activitiemassage"] as? String
		productname = dictionary["productname"] as? String
	}

}