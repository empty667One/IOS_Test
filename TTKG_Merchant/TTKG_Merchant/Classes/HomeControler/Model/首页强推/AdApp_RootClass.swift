//
//	AdApp_RootClass.swift
//
//	Create by macmini on 23/8/2016
//	Copyright © 2016. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

class AdApp_RootClass{

	var code : Int!
	var data : AdApp_Data!
	var msg : String!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: NSDictionary){
		code = dictionary["code"] as? Int
		if let dataData = dictionary["data"] as? NSDictionary{
			data = AdApp_Data(fromDictionary: dataData)
		}
		msg = dictionary["msg"] as? String
	}

}