//
//	MerchantGoodsData.swift
//
//	Create by yd on 10/8/2016
//	Copyright © 2016. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


extension MerchantGoodsData{
    //(name,imgurl,nowPrice,oldPrice,gift)
    func showGoodsSomeInfo() -> (name:String,imgurl:String,nowPrice:Double,isactivity:Int,ispromotional:Int){
        return (self.title,self.pictureurl,self.originalprice,self.isactivity,self.ispromotional)
    }
}

class MerchantGoodsData {

	var originalprice : Double!
	var pictureurl : String!
	var productid : Int!
	var salesvolume : Int!
	var shopid : Int!
	var shopname : String!
	var title : String!

    var isactivity :Int!
    var ispromotional :Int!
	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: NSDictionary){
		originalprice = dictionary["originalprice"] as? Double
		pictureurl = dictionary["pictureurl"] as? String
		productid = dictionary["productid"] as? Int
		salesvolume = dictionary["salesvolume"] as? Int
		shopid = dictionary["shopid"] as? Int
		shopname = dictionary["shopname"] as? String
		title = dictionary["title"] as? String
        
        ispromotional = dictionary["ispromotional"] as? Int
        
        isactivity = dictionary["isactivity"] as? Int
	}




}