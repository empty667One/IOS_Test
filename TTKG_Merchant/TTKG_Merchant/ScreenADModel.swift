//
//	ScreenADModel.swift
//
//	Create by yd on 23/8/2016
//	Copyright © 2016. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

class ScreenADModel{

	var code : Int!
	var data : ScreenADData!
	var msg : String!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: NSDictionary){
		code = dictionary["code"] as? Int
		if let dataData = dictionary["data"] as? NSDictionary{
			data = ScreenADData(fromDictionary: dataData)
		}
		msg = dictionary["msg"] as? String
	}

}