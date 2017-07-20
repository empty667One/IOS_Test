//
//	NoticeMessageModel.swift
//
//	Create by macmini on 18/8/2016
//	Copyright © 2016. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

class NoticeMessageModel{

	var code : Int!
	var data : [NoticeMessageData]!
	var msg : String!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: NSDictionary){
		code = dictionary["code"] as? Int
		data = [NoticeMessageData]()
		if let dataArray = dictionary["data"] as? [NSDictionary]{
			for dic in dataArray{
				let value = NoticeMessageData(fromDictionary: dic)
				data.append(value)
			}
		}
		msg = dictionary["msg"] as? String
	}

}