//
//	creditInfoModel.swift
//
//	Create by macmini on 22/8/2016
//	Copyright © 2016. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

class creditInfoModel{

	var code : Int!
	var data : creditInfoData!
	var msg : String!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: NSDictionary){
		code = dictionary["code"] as? Int
		if let dataData = dictionary["data"] as? NSDictionary{
			data = creditInfoData(fromDictionary: dataData)
		}
		msg = dictionary["msg"] as? String
	}

}