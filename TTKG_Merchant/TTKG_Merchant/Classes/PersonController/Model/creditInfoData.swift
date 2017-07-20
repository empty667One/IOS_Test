//
//	creditInfoData.swift
//
//	Create by macmini on 22/8/2016
//	Copyright © 2016. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

class creditInfoData{

	var creditamount : Float!
	var creditavailable : Float!
	var creditstatus : Bool!
	var totalloan : Float!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: NSDictionary){
		creditamount = dictionary["creditamount"] as? Float
		creditavailable = dictionary["creditavailable"] as? Float
		creditstatus = dictionary["creditstatus"] as? Bool
		totalloan = dictionary["totalloan"] as? Float
	}

}