//
//	PushAD_RootClass.swift
//
//	Create by macmini on 23/8/2016
//	Copyright © 2016. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

class PushAD_RootClass{

	var code : Int!
	var data : PushAD_Data!
	var msg : String!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: NSDictionary){
		code = dictionary["code"] as? Int
		if let dataData = dictionary["data"] as? NSDictionary{
			data = PushAD_Data(fromDictionary: dataData)
		}
		msg = dictionary["msg"] as? String
	}

}