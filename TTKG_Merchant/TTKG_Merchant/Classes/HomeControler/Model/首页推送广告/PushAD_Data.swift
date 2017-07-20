//
//	PushAD_Data.swift
//
//	Create by macmini on 23/8/2016
//	Copyright © 2016. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

class PushAD_Data{

	var bigpic : String!
	var datatype : Int!
	var picurl : String!
	var productid : Int!
	var remark : String!
	var shopid : Int!
	var title : String!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: NSDictionary){
		bigpic = dictionary["bigpic"] as? String
		datatype = dictionary["datatype"] as? Int
		picurl = dictionary["picurl"] as? String
		productid = dictionary["productid"] as? Int
		remark = dictionary["remark"] as? String
		shopid = dictionary["shopid"] as? Int
		title = dictionary["title"] as? String
	}

}