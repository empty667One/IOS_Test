//
//	AdApp_Data.swift
//
//	Create by macmini on 23/8/2016
//	Copyright © 2016. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

class AdApp_Data{

	var bigpicurl : String!
	var picurl : String!
	var remark : String!
	var title : String!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: NSDictionary){
		bigpicurl = dictionary["bigpicurl"] as? String
		picurl = dictionary["picurl"] as? String
		remark = dictionary["remark"] as? String
		title = dictionary["title"] as? String
	}

}