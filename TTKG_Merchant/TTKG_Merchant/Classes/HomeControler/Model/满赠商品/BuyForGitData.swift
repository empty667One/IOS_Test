//
//	BuyForGitData.swift
//
//	Create by macmini on 19/8/2016
//	Copyright © 2016. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

class BuyForGitData{

	var giftmassage : String!
	var hassale : Bool!
	var image : String!
	var merchantid : Int!
	var price : Double!
	var productid : Int!
	var productname : String!
	var saleprice : Double!
	var shopid : Int!
	var shopname : String!
	var specititle : String!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: NSDictionary){
		giftmassage = dictionary["giftmassage"] as? String
		hassale = dictionary["hassale"] as? Bool
		image = dictionary["image"] as? String
		merchantid = dictionary["merchantid"] as? Int
		price = dictionary["price"] as? Double
		productid = dictionary["productid"] as? Int
		productname = dictionary["productname"] as? String
		saleprice = dictionary["saleprice"] as? Double
		shopid = dictionary["shopid"] as? Int
		shopname = dictionary["shopname"] as? String
		specititle = dictionary["specititle"] as? String
	}

}