//
//	BuyForGitModel.swift
//
//	Create by macmini on 19/8/2016
//	Copyright © 2016. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

class BuyForGitModel{

	var code : Int!
	var data : [BuyForGitData]!
	var msg : String!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: NSDictionary){
		code = dictionary["code"] as? Int
		data = [BuyForGitData]()
		if let dataArray = dictionary["data"] as? [NSDictionary]{
			for dic in dataArray{
				let value = BuyForGitData(fromDictionary: dic)
				data.append(value)
			}
		}
		msg = dictionary["msg"] as? String
	}

}