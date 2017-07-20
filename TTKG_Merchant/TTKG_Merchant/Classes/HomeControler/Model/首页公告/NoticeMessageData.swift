//
//	NoticeMessageData.swift
//
//	Create by macmini on 18/8/2016
//	Copyright © 2016. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

class NoticeMessageData{

	var content : String!
	var title : String!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: NSDictionary){
		content = dictionary["content"] as? String
		title = dictionary["title"] as? String
	}

}